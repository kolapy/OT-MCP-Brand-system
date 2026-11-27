---
name: interview-cut
description: >-
  Edit, sync, polish, and audit multi-camera studio or talk-show interviews and social cutdowns
  in Adobe Premiere Pro (`premiere-pro-mcp`) and After Effects (`ae-motion`). Use when the user
  asks to cut an interview, build social clips from a main edit, fix multi-cam audio sync or
  doubling/ducking, audit and eliminate jump cuts, match Lumetri color across camera angles,
  or polish intro titles and lower thirds (orphan prevention, clean naming, no L3s on social).
---

# Modular Multi-Cam Interview Cut (`interview-cut`)

A project-agnostic, modular workflow for editing, syncing, mixing, grading, and auditing multi-camera interviews and social cutdowns in **Premiere Pro** (`premiere-pro-mcp`) and **After Effects** (`ae-motion`).

This skill is intentionally **not tied to any single brand, client, or project**. Use only the module(s) you need for the current task (e.g., jump-cut audit only, audio ducking pass only, or end-to-end interview + social assembly).

## Modules (Load on Demand)
- [Multi-Cam Sync & Zero-Jump-Cut Editing](./references/multicam-sync-and-cutting.md) — per-segment acoustic cross-correlation (never assume one global reel offset), camera-switching rules, extending existing B-cam clips, and a frame-accurate jump-cut / 1-frame flash / gap audit script.
- [Audio Ducking & Dialogue Mix](./references/audio-ducking-and-mix.md) — complementary track ducking (`A1` vs. `A3`) to eliminate mic doubling/phase echo, music bed ducking, and protecting audio tracks during video-only batch placements.
- [Color Continuity & Graphics QA](./references/color-and-graphics-qa.md) — `Lumetri Color` matching across camera angles, zero-orphan typography rules, L3 naming/social-cut rules, sequential alpha rendering, and Premiere cache reload hygiene.

---

## Non-Negotiable Quality Standards

1. **Zero Jump Cuts (Always Switch Cameras or Cover with B-Roll)**:
   - Never leave a same-camera cut (`A → A` or `B → B`) exposed on a talking-head edit.
   - Every editorial cut on `V1` must switch cameras (`A → B` or `B → A`), or on single-camera interviews be cleanly covered by a B-roll cutaway, with zero 1-frame flashes and zero 1-frame gaps.
   - Prefer **extending an existing adjacent B-cam clip** (`trim_clip` with `duration`) over inserting a fresh clip—this automatically preserves its color grade, sync, and avoids disturbing audio tracks.
2. **Per-Segment Audio Sync (Never Assume One Global Offset)**:
   - Concatenated or multi-take camera reels frequently have different A/B sync offsets in different sections.
   - Always measure acoustic sync (via audio cross-correlation) **per edited segment** before locking B-cam video or audio.
3. **Zero Audio Doubling & LUFS-Calibrated Dialogue-First Mix**:
   - When multiple camera tracks carry live mics (e.g., host on `A1`, guest on `A3`), never leave both tracks sitting flat at `0 dB`. Apply complementary speaker ducking (`+6 dB` active / `-18 dB` ducked, `0.2s` ramps) so only the active mic is hot at any moment.
   - Measure both dialogue and background music integrated loudness (`ffmpeg -vn -af ebur128`) before setting dB levels: gain-stage dialogue to **`-20` to `-18 LUFS`** (True Peak `<= -1.5 dBFS`) and duck music under active speech to **`-40` to `-44 LUFS`** (**`20–24 LU` below speech**). Never rely on a blind `-20/-22 dB` cut on hot `-9` to `-11 LUFS` stock music masters.
4. **Zero Ungraded Clips & B-Roll `~80 IRE` Continuity**:
   - Every newly inserted or replaced camera clip must immediately receive the exact matching `Lumetri Color` parameters of that camera angle.
   - Audit all live-action B-roll cutaways against the A-cam interview using Rec.709 luma scopes and RGB balance so peak highlights sit cleanly around **`80 IRE`** (`79–82 IRE`), midtones/shadows match A-cam density, and skin tones / white balance match A-cam without cool fluorescent casts.
5. **Zero Orphan Words & Balanced Title/Quote Hierarchy**:
   - Never leave a single word stranded on its own line in an intro bumper, title card, split body copy, or pull-quote.
   - Fix by either slightly reducing font size + leading (preserving `box_size` and 3D framing) or inserting a balanced manual line break (2+ words per line). Keep eyebrow-to-quote staggers tight (`0.25–0.35 s`) and leave `55–65 px` clearance between a quote's closing line and `— Speaker Name`. Visually inspect via `preview_frame` before rendering.
6. **Clean, Consistent Titles & Lower Thirds**:
   - Keep intro copy minimal and uniform across a series (no stray prefixes/suffixes unless explicitly requested).
   - Verify full speaker names, roles, and company names before rendering lower thirds—never leave first-name-only or company-only placeholders.
   - **No lower thirds (L3s) on social cuts**: Place L3s on the main full-length interview only; keep social cutdowns clean (Intro → Clip → Closer).
7. **Sequential Alpha Rendering & Premiere Cache Hygiene**:
   - Render `aerender` jobs **one at a time** on external/shared drives to avoid directory write-lock errors, using an alpha-capable output module (e.g., `High Quality with Alpha` / ProRes 4444).
   - When overwriting a `.mov` while Premiere Pro has it open, either version the filename (`_v2.mov`) or remind the user to `Make Offline → Link Media` / reopen the project so Premiere flushes stale file handles.

---

## Tooling Notes
- **Premiere MCP `readOnly` flag**: `verify_premiere_connection` may report `"readOnly": true` even when write tools (`trim_clip`, `add_to_timeline_batch`, `remove_from_timeline`, `apply_effect`, `add_audio_keyframes`, `save_project`) work normally. Do not assume edits are blocked without testing or asking the user.
- **Trimming timeline duration vs. source out**: In Premiere MCP, `trim_clip` with `outPoint` alone may update source out without extending timeline duration; pass `duration` when extending or shortening a clip's timeline footprint, and always verify `after.start`, `after.end`, and `after.duration` in the response.
- **Essential Sound (`Enhance Speech`) & AE Dynamic Link**: Premiere's ExtendScript API cannot add Essential Sound's AI `Enhance Speech` module programmatically—note clearly if rebuilt clips need it re-enabled. Additionally, when importing a Premiere `.prproj` sequence with `Enhance Speech` into After Effects via Dynamic Link, AE's audio bridge frequently drops to `0.000` silence after a few seconds; always export a lossless 48 kHz WAV dialogue stem from Premiere (`Waveform Audio 48kHz 16-bit.epr` to a colon-free path), import it synced in AE, and mute the Dynamic Link layer's audio.
- **Avoid Heavy Local Video Transcoding**: Restrict `ffmpeg` to lightweight audio-only (`-vn`) extraction/LUFS measurement and single-frame PNG grabs—never batch-transcode heavy 4K/RAW camera files locally when Premiere/AE can conform frame rates natively.

---

## Mandatory Post-Edit QA Audit (Run Before Finishing)

Before reporting any interview edit or fix as complete, verify all 5 gates:
1. **Jump-Cut & Gap Sweep**: Run the boundary audit script from [Multi-Cam Sync & Zero-Jump-Cut Editing](./references/multicam-sync-and-cutting.md) — confirm every `V1` edit point switches cameras (`A ↔ B`) with `0` exposed jump cuts, `0` 1-frame flashes, and `0` gaps.
2. **Per-Segment Sync Check**: Confirm every edited segment's B-cam video and audio match the measured acoustic offset for that segment's source range.
3. **Audio Track & Ducking Check**: Confirm `A1`/`A3` have all expected clips intact (none stripped by `linkAudio: false`), complementary ducking keyframes are present with no flat `0 dB` overlaps, and the music bed (`A4`) ducks cleanly under dialogue.
4. **Color Continuity Check**: Confirm every `V1` and `V2` clip—especially any newly inserted clip—carries the matching `Lumetri Color` grade for its camera angle.
5. **Graphics & Social Compliance Check**: Visually verify every modified title/L3 frame (zero orphan words, verified full names/titles), and confirm social cutdowns contain **zero L3s**.
6. **Save Project**: Call `save_project` in Premiere Pro / After Effects only after all checks pass.
