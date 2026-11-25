# Multi-Cam Sync & Zero-Jump-Cut Editing

Use this module when syncing multi-camera interview reels, assembling a talk-show cut, or auditing an existing Premiere Pro timeline for jump cuts, 1-frame flashes, and sync drift.

---

## 1. Per-Segment Acoustic Sync Verification

Never assume a single global A/B offset applies across an entire camera reel. Multi-take or concatenated reels (`Cam A.mov`, `Cam B.mov`) often shift offsets between takes.

Run this lightweight `ffmpeg` + `numpy` cross-correlation check against **every edited segment's source range** (using the `inPoint` of each `V1` clip):

```python
import subprocess, numpy as np

CAM_A = "/path/to/Cam_A.mov"
CAM_B = "/path/to/Cam_B.mov"
FPS = 23.976  # or 29.97 / 30.0 — match sequence frame rate

def read_mono(path, ss, dur=15, sr=8000):
    cmd = ["ffmpeg", "-v", "error", "-ss", str(ss), "-t", str(dur),
           "-i", path, "-ac", "1", "-ar", str(sr), "-f", "f32le", "-"]
    return np.frombuffer(subprocess.check_output(cmd), dtype=np.float32)

sr = 8000
for label, src_a_sec in [("Seg 0", 12), ("Seg 1", 250), ("Seg 2", 1160)]:
    a = read_mono(CAM_A, src_a_sec, 15, sr)
    b = read_mono(CAM_B, src_a_sec, 15, sr)
    an = (a - a.mean()) / (a.std() + 1e-9)
    bn = (b - b.mean()) / (b.std() + 1e-9)
    n = 1 << (len(an) + len(bn) - 1).bit_length()
    cc = np.fft.irfft(np.fft.rfft(an, n) * np.conj(np.fft.rfft(bn, n)), n)
    max_lag = 5 * sr
    lp, ln = cc[:max_lag], cc[-max_lag:]
    ip, in_ = int(np.argmax(lp)), int(np.argmax(ln))
    lag = ip if lp[ip] >= ln[in_] else (in_ - max_lag)
    offset = lag / sr  # A_source_time - B_source_time
    print(f"{label} @ A={src_a_sec}s: true (A - B) = {offset:+.4f}s ({offset*FPS:+.1f} frames)")
```

### Sync Formula for Placing or Slipping Cam B
Given a timeline time `T` inside a `V1` segment starting at `V1_start` with source `V1_inPoint`:
- `A_src(T) = V1_inPoint + (T - V1_start)`
- `B_src(T) = A_src(T) - true_offset`

To slip an out-of-sync `A3` (Cam B audio) clip in place without shifting its timeline position, call `trim_clip` with both `inPoint` and `outPoint` set to the synced `B_src` range and verify `after.start` and `after.end` remain unchanged.

---

## 2. Zero-Jump-Cut Editorial Rules

1. **Every `V1` cut must switch cameras**:
   - If `V1[i-1]` ends on Cam A and `V1[i]` starts on Cam A, place or extend a synced Cam B clip on `V2` so the viewer transitions `Cam B → Cam A` (B ends right on the cut) or `Cam A → Cam B` (B starts right on the cut).
2. **Prefer extending existing `V2` clips**:
   - If an existing `V2` clip ends within ~2–3 seconds before a `V1` cut (or starts shortly after), **extend that clip in place** using `trim_clip(clipId, duration=...)` rather than inserting a new clip.
   - Extending preserves the clip's existing `Lumetri Color` grade and avoids touching any audio track.
3. **Eliminate 1-frame flashes and 1-frame gaps**:
   - If `V2` ends 1 frame (`0.033s` at 29.97fps or `0.042s` at 23.976fps) before a `V1` cut, extend `V2` by that exact 1 frame so it lands squarely on the cut.
   - If a 1-frame black gap exists between `V1[i-1]` and `V1[i]`, cover the gap with a synced `V2` Cam B shot starting at `V1[i-1].endTime`.
4. **Watch out for `linkAudio: false` side effects**:
   - When placing new video-only `V2` clips via `add_to_timeline_batch(..., linkAudio=False)` at the **exact same start timestamp** as an existing `A3` clip, Premiere MCP's unlinked-audio cleanup may also remove the existing `A3` clip starting at that timestamp.
   - **Always** run `list_sequence_tracks` immediately after any `add_to_timeline_batch` call to confirm `A1` and `A3` clip counts are intact.

---

## 3. Frame-Accurate Jump-Cut & Boundary Audit Script

Run this against the JSON returned by `list_sequence_tracks` on the main edit sequence:

```python
import json

with open("/path/to/list_sequence_tracks_output.json") as f:
    data = json.load(f)

v1 = data["videoTracks"][0]["clips"]
v2 = data["videoTracks"][1]["clips"]

def fmt(s):
    m = int(s // 60)
    return f"{m:02d}:{s - m*60:05.2f}"

def cam_at(t):
    for c in v2:
        if c["startTime"] <= t <= c["endTime"]:
            return ("B", c["id"], c["startTime"], c["endTime"])
    return ("A", None, None, None)

# 1. Audit every V1 edit point (including 1-frame flashes and gaps)
for i in range(1, len(v1)):
    t_prev_end = v1[i - 1]["endTime"]
    t_next_start = v1[i]["startTime"]
    gap = t_next_start - t_prev_end
    before = cam_at(t_prev_end - 0.015)   # ~half a frame before cut
    after = cam_at(t_next_start + 0.015)  # ~half a frame after cut
    status = "JUMP CUT" if before[0] == after[0] else "OK"
    print(f"{status:8s} V1[{i-1}]->{i} @ {fmt(t_prev_end)}/{fmt(t_next_start)} (gap={gap:+.3f}s): {before[0]} -> {after[0]}")

# 2. Audit touching V2 -> V2 boundaries (check source continuity with get_clip_properties)
for i in range(1, len(v2)):
    if abs(v2[i]["startTime"] - v2[i - 1]["endTime"]) < 0.15:
        print(f"V2->V2 TOUCHING @ {fmt(v2[i-1]['endTime'])}: {v2[i-1]['id']} -> {v2[i]['id']} (verify continuous source in/out)")
```

Every `V1` edit point must report `OK` (`A -> B` or `B -> A`) with `gap ≈ 0.000s` (or covered by `V2`). Any touching `V2 -> V2` pair must be verified via `get_clip_properties` to confirm `prev.outPoint == next.inPoint` (continuous through-edit, not a jump cut).
