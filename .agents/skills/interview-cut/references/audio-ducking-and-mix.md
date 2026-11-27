# Audio Ducking & Dialogue Mix

Use this module to eliminate mic doubling / phase echo across multi-cam dialogue tracks (`A1` vs. `A3`), restore lost ducking curves after sync or timeline rebuilds, and verify music bed ducking (`A4`).

---

## 1. Preventing Mic Doubling (Complementary Speaker Ducking)

In a multi-mic studio interview where Cam A (`A1`) and Cam B (`A3`) carry different speakers' lavs (with room bleed between them):
- **Never leave both `A1` and `A3` sitting flat at `0 dB` simultaneously.** Even a 10–15 ms offset creates hollow comb-filtering/doubling, and room bleed muddies the dialogue.
- **Standard complementary ducking levels**:
  - **Active speaker track**: `+6.0 dB` (Premiere normalized linear value ≈ `0.354813`)
  - **Inactive (ducked) track**: `-18.0 dB` (Premiere normalized linear value ≈ `0.022387`)
  - **Transition ramp (`fadeSeconds`)**: `0.20s` (5–6 frames)

### Mirroring `A1` Ducking onto `A3` (Fast Recovery Pattern)
If `A1` already has speaker-handoff ducking keyframes and `A3` clips were rebuilt or lost their keyframes:
1. Read `A1`'s keyframes with `get_keyframes(clipId, componentName="Volume", paramName="Level")`.
2. For each keyframe at source time `t_A` on `A1`:
   - Convert to `A3` source time using that segment's measured sync offset:
     `t_B = t_A - true_offset`
   - Invert the level:
     - Where `A1` is `+6 dB` (`~0.3548`) → set `A3` to `-18 dB`
     - Where `A1` is `-18 dB` (`~0.0224`) → set `A3` to `+6 dB`
3. Clamp `t_B` to `[A3.inPoint, A3.outPoint]` and apply via `add_audio_keyframes(clipId, keyframes=[...])`.
4. Confirm `failedKeyframes: []` in the tool response.

---

## 2. Safely Restoring `A3` Audio Clips Without Disturbing `V1` / `V2`

If an `A3` clip must be reinserted (for example, after an overwrite or sync rebuild):
1. Check if `V3` (`trackIndex: 2`) is empty during the target time range.
2. Place the Cam B source clips on `trackIndex: 2` with `linkAudio: true` and exact synced `sourceInPoint` / `sourceOutPoint` via `add_to_timeline_batch`. Premiere places the synced audio cleanly onto `A3` and temporary video onto `V3`.
3. Immediately remove the temporary `V3` video clips by their returned IDs using `remove_from_timeline(..., deleteMode="lift")`.
4. Apply the complementary ducking keyframes to the newly created `A3` clips.
5. **Essential Sound (`Enhance Speech`) note**: Premiere's API cannot programmatically add `Enhance Speech`. Inspect `list_clip_effects` on the original audio clips; if they use `Enhance Speech` (e.g., `Mix Amount: 0.7`), inform the user which rebuilt `A3` clips need `Essential Sound → Dialogue → Enhance Speech` toggled back on.

---

## 3. LUFS-Calibrated Music Bed Ducking (`A4` or AE Master)

Never guess music gain in raw dB—stock corporate music masters are frequently brickwalled at **`-9` to `-11 LUFS`**, where a naive `-20` or `-22 dB` cut still plays at `-31 LUFS` and competes with speech.

1. **Measure both stems first** with lightweight audio-only `ffmpeg`:
   ```bash
   ffmpeg -nostats -i dialogue_stem.wav -vn -af "ebur128=peak=true" -f null - 2>&1 | tail -15
   ffmpeg -nostats -i music_track.wav   -vn -af "ebur128=peak=true" -f null - 2>&1 | tail -15
   ```
2. **Apply LUFS-anchored gain staging**:
   - **Dialogue stem**: Target **`-20` to `-18 LUFS`** integrated (True Peak `<= -1.5 dBFS`).
   - **Intro / Outro (no speech)**: Target **`-22` to `-20 LUFS`** (aligned with closer ident loudness), holding up to `~0.6–0.8 s` before speech begins.
   - **Under active dialogue**: Smoothly ramp (`0.8–1.0 s` eased fade) down to **`-40` to `-44 LUFS`** (**`20–24 LU` below active speech** — typically **`-32` to `-36 dB`** on `-9` to `-11 LUFS` stock masters) and hold cleanly across speech.
   - **Outro / Closer Ident**: Optional brief lift (`+6–8 dB` on the final word tail), then fade smoothly to silence (`-60 dB`) into the closer ident's audio/mnemonic.
3. For new Premiere beds, use `setup_ducking(clipId, baseDb, duckingWindows, fadeSeconds)` for clean 4-keyframe windows.

---

## 4. Premiere Pro → After Effects Dynamic Link WAV Stem Handoff

When importing a Premiere Pro sequence (`.prproj`) that uses AI **`Enhance Speech`** into After Effects via Dynamic Link:
1. AE's headless Dynamic Link server frequently drops Premiere `Enhance Speech` audio to **`0.000` silence** past the first few seconds.
2. **Standard Fix**: Export a lossless **48 kHz WAV dialogue stem** directly from Premiere Pro (`export_sequence` using Premiere's factory `Waveform Audio 48kHz 16-bit.epr` preset) to a **colon-free POSIX path** (avoid macOS Finder folders containing `/`, which store as `:` in POSIX and break ExtendScript/Media Encoder paths).
3. Import that WAV stem into After Effects synced to the exact speaker `inPoint`, set **`audioEnabled = false`** on the Dynamic Link video layer (and all B-roll layers) so audio can never drop or double, and probe live AE audio amplitude across multiple timeline points before saving.
