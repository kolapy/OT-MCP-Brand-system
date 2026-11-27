---
name: ot-brand-motion
description: >-
  Animate, assemble, and expand OpenText-branded motion graphics in Adobe After Effects
  using the `ae-motion` MCP server and the master project `Projects/AE MCP Brand System.aep`.
  Use when the user asks to create, customize, or animate OpenText videos, Bento layouts,
  lower thirds, CTA bumpers, transitions, sonic idents, or net-new branded motion scenes
  in 16:9 or 9:16 at 30 fps.
---

# OpenText Brand Motion System (`ot-brand-motion`)

Use this skill to operate on the deduplicated, 30 fps, zero-plugin After Effects brand system in `Projects/AE MCP Brand System.aep` via the `ae-motion` MCP server.

The brand system is organized into **two separate modules** (always filed under root **`Assets/_Dependancies`** inside working `.aep` projects):
1. **Corp Brand Package** (`Projects/Modules/OT_Corp_Brand_30fps.aep` / `OT Corp level brand package (CC26)-V3.aep`) — canonical 16:9 and 9:16 Backgrounds, Lower Thirds (`L3`), Logo Bugs, Simple/CTA Bumpers, Transitions, and Sonic Ident.
2. **Bento Module** (`Projects/Modules/OT_Bento_30fps.aep` / `Bento Base template (converted).aep`) — modular Bento layout skeletons (`Bento 3-Up`, `4-Quad`, `Asymmetric`, `Frame`, `Grid 2x2`, `Hero Chips`, `Timeline`, `Info Slide`) and footage-framing comps (`4 up`, `Border Frame`, `Frame`, `Windows`).

## References (Load on Demand)
- [Brand Tokens & Motion DNA](./references/brand-tokens.md) — exact RGB/Hex palette, `Inter` type hierarchy, Bento card geometry, and timing/easing standards.
- [Template Catalog](./references/template-catalog.md) — comp inventory, controller nulls, checkboxes, sliders, and footage-holder precomps across both modules.
- [Native AE Expressions](./references/native-expressions.md) — zero-plugin text reveal IN/OUT, responsive `sourceRectAtTime()` auto-sizing, and looping Living Blue/Metal gradient expressions.
- [OT Icons Library](../ot-storyboard-bento/references/ot-icons-library.md) — searching `ot-icons-library.onrender.com` (`/data/icons-index.json`) for official OpenText SVGs.

---

## Core Standards (Non-Negotiable)

1. **Frame Rate**: Always **30 fps** (`1920x1080` for 16:9, `1080x1920` for 9:16, `3840x2160` for 4K).
2. **Never Edit Canonical Templates Directly**: Duplicate or precompose from `Assets/_Dependancies/...` into a working folder before customizing copy, timing, or layout. When starting a brand-new video from the master `.aep`, immediately `save_project` to a new file path first.
3. **Never Fake Canonical Brand Assets**:
   - **Standard Intro**: Always duplicate one of the 3 real `Bumper IN` / `Bumper IN CTA` comps (`White`, `Blue`, or `Black`) from `OT_Corp_Brand_30fps.aep`. Never redraw the OpenText logo or fake the 3D `Bumper IN CTA` rig from scratch. `Bumper IN CTA` ends with a `1.23s` circular `"O"` alpha wipe (`7.80s`–`9.03s`) — overlap the opening footage starting at `7.80s`.
   - **Standard Lower Thirds (`L3`), Backgrounds & Bento Rigs**: Always use the real `Lowerthird 1 EDIT ME`, `NEW Lving Blue`/`Metal`, `OUTPUT/Frame`, `OUTPUT/Border Frame`, `4 up`, and `Windows` comps from `Assets/_Dependancies`—never silently rebuild Tier-2 lookalikes when the `.aep` templates haven't been loaded yet.
   - **Standard Closer**: Always end with the **real Sonic Ident** (`STD ident` comp or `IDENT 2025 - Tail --2026 - Rev2.mov` with `OpenText_Mnemonic_Final_WAV.wav`). Note: the pre-rendered 2026 Tail `.mov` has a `1.30s` alpha wipe-in (`0.00s`–`1.30s`) and should be laid on an upper video track overlapping the final `1.30s` of the closing shot.
4. **Typography**: Always **`Inter`** (`Inter-Bold` for headlines/names, `Inter-Regular` for body/titles/CTAs). When upgrading Bento skeleton comps, replace placeholder `MyriadPro-Regular` text with `Inter`.
5. **Zero Third-Party Plugins**: Never use Animation Composer (`Pseudo/MHAC`) or third-party effects. Use native AE Text Animators with the marker-aware expressions in [Native AE Expressions](./references/native-expressions.md) or `ae-motion`'s `text_reveal`.
6. **Fast Batching & No Heavy Video Transcoding**: Combine dependent edits into `batch` calls (`$N.id` references), and run heavy `review_motion` / `preview_frame` calls **sequentially** (1–2 at a time) so the AE bridge stays responsive. **Never run heavy multi-file `ffmpeg` video transcoding** (especially 4K/BRAW on laptops); import source video directly into AE and let AE conform frame rate (`30 fps`). Restrict `ffmpeg` to lightweight audio-only extraction (`-vn`) for Whisper transcripts or single-frame PNG grabs.

---

## Loading Brand Dependencies (`Assets/_Dependancies`) in Fresh or Open Projects

Resolve `<REPO_ROOT>` as 3 levels above the symlink-resolved path of this `SKILL.md` (the root directory containing `Projects/AE MCP Brand System.aep` and `Projects/Modules/`).

> **Important `ae-motion` API Constraint**: `import_footage` only supports `footage | sequence | comp | comp_cropped` and rejects `.aep` files (`Cannot import ... as footage`). Use **Path A** (silent JSX project import, preferred) or **Path B** (fresh-project `open_project`), and **always file imported brand modules under root `Assets/_Dependancies`**.

1. **Path A — Automated `.aep` Module Import via `run_jsx` (Preferred — Works in *Any* Open `.aep`)**:
   - Requires `AE_MCP_ALLOW_JSX=1` (plus `AE_MCP_ALLOWED_DIRS` covering `<REPO_ROOT>` and the active workspace drive) in `mcp_config.json`.
   - Call `get_project` first to see which modules are already loaded; then import only missing modules via `ImportAsType.PROJECT` directly into **`Assets/_Dependancies`** (substituting the resolved `<REPO_ROOT>` path):
   ```javascript
   (function () {
     var repoRoot = "<REPO_ROOT>";
     function getOrCreateFolder(name, parent) {
       for (var i = 1; i <= app.project.numItems; i++) {
         var it = app.project.item(i);
         if (it instanceof FolderItem && it.name === name && it.parentFolder === parent) return it;
       }
       var f = app.project.items.addFolder(name);
       f.parentFolder = parent;
       return f;
     }
     var assets = getOrCreateFolder("Assets", app.project.rootFolder);
     var deps = getOrCreateFolder("_Dependancies", assets);
     var paths = [
       repoRoot + "/Projects/Modules/OT_Corp_Brand_30fps.aep",
       repoRoot + "/Projects/Modules/OT_Bento_30fps.aep"
     ];
     var imported = [];
     for (var p = 0; p < paths.length; p++) {
       var io = new ImportOptions(new File(paths[p]));
       io.importAs = ImportAsType.PROJECT;
       var res = app.project.importFile(io);
       res.parentFolder = deps;
       imported.push({ id: res.id, name: res.name });
     }
     return { deps_folder_id: deps.id, imported: imported };
   })();
   ```
2. **Path B — Fresh Project Flow (Zero-JSX Fallback)**:
   - If `get_project` shows an empty starter `.aep` (e.g., blank `Comp 1`) and `run_jsx` is disabled, call `open_project` on `<REPO_ROOT>/Projects/AE MCP Brand System.aep` **FIRST** and immediately `save_project` (`overwrite: true`) to the working `.aep` path—**before** importing any Premiere `.prproj` or footage.
   - If the open `.aep` already has client work and `run_jsx` is disabled, **STOP and ask the user** to run one `File → Import → File...` on the needed `.aep` module(s) and place them in `Assets/_Dependancies`. Never fall back to faking canonical brand comps.
3. **Tier 2 — Supplemental Net-New Bento Elements Only**:
   - Use scratch-built layers from [Brand Tokens & Motion DNA](./references/brand-tokens.md) + [Native AE Expressions](./references/native-expressions.md) + `ot-icons-library.onrender.com` SVGs/PNGs **only** for supplemental floating icon pills, stat badges, or custom editorial callouts—never to replace canonical `L3`, `Bumper IN/OUT CTA`, `NEW Lving Blue`, `Frame`, `Border Frame`, `4 up`, `Windows`, or `STD ident` comps.

---

## Workflows

### Workflow 1: Assemble & Customize from Corp Brand Templates
1. Call `get_project` to confirm whether the Corp Brand module is already in `Assets/_Dependancies` (if not, import via `run_jsx` into `Assets/_Dependancies` per Path A, or open `AE MCP Brand System.aep` and `save_project` per Path B).
2. Look up the required template comp(s) in [Template Catalog](./references/template-catalog.md) (matching target aspect ratio `16x9` or `9x16`).
3. Create a new master assembly comp (`create_comp`, `fps: 30`) or duplicate the target template comp into a working folder.
4. Customize layers:
   - **Lower Thirds (`L3`)**: Update `Name` and `Title` via `set_text`. **Always append `, OpenText`** to internal speaker titles (e.g., `Chief Executive Officer, OpenText`, `President, Worldwide Sales, OpenText`). Toggle `CTRL` checkboxes (`Double Title`, and `Left Justified` on Right-hand L3s) via `set_property`. Retime reveals by moving layer `in`/`out` or `TR In` / `TR Out` markers—do **not** touch the `BG` `sourceRectAtTime()` expression.
   - **CTA Bumpers**: Update `CTA Text` / `CTA Text 2` via `set_text`. Keep `scale` and `box_size` intact so the 3D camera rig frames properly.
   - **Transitions & Idents**: Drop `Transition - Blue/Black/White` across scene cuts; place `STD ident` (with `OpenText_Mnemonic_Final_WAV.wav`) as opener/closer.

### Workflow 2: Upgrade & Animate a Bento Layout in Brand Style
The 8 top-level `Bento *` / `Info Slide` comps are structural skeletons; upgrade them into full OpenText motion pieces as follows:
1. Read [Brand Tokens & Motion DNA](./references/brand-tokens.md) for exact RGB values, card corner radius (`18 px`), and shadow specs.
2. Place `NEW Lving Blue` or `NEW Lving Metal` (from Corp Brand Package) as the background layer, or use the dark Bento surface (`#0F0F14` / `#1A1F2E`) with subtle depth.
3. Style cards: `Round Corners` radius `18`, consistent padding/gaps (use `4-Quad Controller` sliders when starting from `Bento 4-Quad`), and soft `Drop Shadow` (`Opacity 77`, `Direction 243`, `Distance 20`, `Softness 59`).
4. Replace placeholder `MyriadPro-Regular` text with `Inter-Bold` (card titles/metrics) and `Inter-Regular` (labels/body), white fill (`[1, 1, 1]`).
5. Populate footage slots by swapping `Window - Footage Holder 1–4` or `Footage Holder Comp` via `replace_source`.
6. Animate entrances:
   - Cards enter with snappy decelerating scale/position (`0.45–0.6s`, staggered `0.06–0.10s`).
   - Text reveals use the native OT Text Reveal IN expression (or `text_reveal`), offset `0.15s` after its parent card settles.
   - Add subtle continuous motion during holds (e.g., 3–5% slow push on a parent null, or the looping Living Blue/Metal background).

### Workflow 3: Build a Net-New Branded Motion Scene
When expanding beyond existing templates (e.g., kinetic stats, feature callouts, multi-card explainers, social cutdowns):
1. Start a new `30 fps` comp (`1920x1080` or `1080x1920`) and nest a canonical background (`NEW Lving Blue`, `NEW Lving Metal`, or clean black/white brand theme).
2. Follow the typography hierarchy, safe margins (5% title-safe on 16:9; top 10% / bottom 20% / side 5% clear on 9:16), and circular `"O"` or `18 px` rounded-card visual motifs from [Brand Tokens & Motion DNA](./references/brand-tokens.md).
3. Use `sourceRectAtTime()` expressions from [Native AE Expressions](./references/native-expressions.md) for any dynamic pills, badges, or chips so text edits never break box framing.
4. Connect scenes using canonical `Transition - Blue/Black/White` comps and close with `Bumper OUT` or `STD ident`.

### Workflow 4: Speaker & Pull-Quote Videos via Bento `Frame` (`Frame - MAIN`) + Dynamic Link
For executive welcomes, interviews, keynote cutdowns, and speaker videos with B-roll and pull-quotes, **assemble the layout natively inside a duplicate of `OUTPUT/Frame`** (renamed e.g. `Frame - MAIN`). Keep rough editorial cutting in Premiere Pro, then either import the Premiere `.prproj` sequence into AE's `Footage Holder Comp` (preferred for full AE Bento builds, paired with a Premiere WAV dialogue stem per item 10) or Dynamic Link `Frame - MAIN` back into Premiere Pro:
1. **No Custom "Vibed" Dark-Card Slides**: Never invent dark-scrim/pill title cards. Use a real canonical **`Bumper IN CTA`** (`White`, `Blue`, or `Black` matching the video's tone) for the opening bumper, and clean centered `Inter-Bold` titles sitting directly on `BG` (`NEW Lving Blue`) behind `Footage Holder Comp`—revealed via `Frame Down`. Do **not** invent extra subheads unless requested; keep single-line titles dead-center (`[960, 540]`).
2. **Real Source Slides & Jump-Cut Coverage**:
   - If the brief references an existing slide at a source timestamp, extract and crop the actual 1080p slide with a single-frame `ffmpeg` grab, mask it with an `18 px` rounded Bento shape matte over `NEW Lving Blue`, and reveal it via `Frame Down` with a subtle slide-up and `3%` slow push.
   - For single-camera speaker edits, inspect edit points on the rough cut for exposed same-scale jump cuts and schedule `1-Up`, `4-Up`, or `50/50 Split` B-roll beats directly across those cuts to hide them seamlessly.
3. **Coupled `MATTE` + `Footage Holder Comp` Rig (Never Leave Scale Behind)**:
   - Place the trimmed speaker footage sequence (`01_Footage_Track`) inside `Footage Holder Comp`.
   - `MATTE` (`Position` + `Rectangle 1 → Size`) and `Footage Holder Comp` (`Scale` `120% ↔ 100%`) work as a **coupled rig**. Every `Frame Up`, `Frame Down`, `Slide Left`, and `Slide Right` beat must keyframe **both** layers 1-to-1 at the exact same timestamps:
     - Full-bleed (`1998.36 × 1118.63`) ↔ `Footage Holder Comp` `Scale = 100%`.
     - Bento card (`1838.36 × 998.625` or Slide `927.36 × 989.625`) ↔ `Footage Holder Comp` `Scale = 120%` (or `100%` on tight/medium shots when avoiding excessive headroom crop—see item 7).
4. **Full-Screen White `Border` (`MATTE 2`) Pattern & Layer Stacking**:
   - When using the white rounded border (`Border` with `Solid White` enabled, `4-Color Gradient` off, `alpha_inverted` to `MATTE 2`), extend both layers across the full timeline and keyframe IN (`Scale 113% → 100%`, `ease_out 61% / ease_in 60%`) on every full-screen video segment.
   - For every OUT (just before `Slide Left`, `Slide Right`, or `Frame Down`), **invert the bezier curve** (`Scale 100% → 113%`, `ease_out 60% / ease_in 61%`, and `Rect Size 1839.1 → 1778.1`) so the border accelerates cleanly off all 4 edges.
   - **Lower Thirds (`L3`) ALWAYS Sit BELOW the Bento Border Frame**: In `Frame - MAIN`, stack `Border Frame` **above** any `L3` precomp (`Border Frame` > `L3` > `Footage`) so the white rounded Bento border frames the lower third cleanly from the outside rather than being overlapped by the L3 bar.
5. **Zero Scene Opacity Fades — Animate the Bento Frame Instead**:
   - **Never crossfade/opacity-fade between scenes or B-roll cards** inside a Bento treatment.
   - Keep **one continuous `NEW Lving Blue` background** at the bottom of `Frame - MAIN` (disable redundant internal backgrounds inside B-roll precomps so each rounded Bento bay has real alpha).
   - Transition between speaker and B-roll beats by **physically animating the Bento mattes** (`Frame Up` from `y = 1610 → 540`, `Frame Up & Off` to `y = -560`, or `Frame Down`, using exact `61/60` ease curves and `HOLD` keyframes for off-screen resets so cards never streak behind the Bento margins).
6. **High-Impact Pull-Quote Discovery, Uniform Styling, Optical Centering & Zero Orphans**:
   - When the SME hasn't picked quotes, extract clip audio with `ffmpeg` (`-vn` audio-only) and transcribe with `whisper` / `faster-whisper` to get verbatim quotes with exact spoken timestamps.
   - Place pull-quotes and split callouts **behind `Footage Holder Comp` (above `BG`)**, alternating `Slide Left` (text on right) and `Slide Right` (text on left), using the exact **Canonical Bento Quote Spec** in [Brand Tokens & Motion DNA](./references/brand-tokens.md).
   - **Mandatory Optical Vertical Centering (`y = 540`), Tight Stagger, Attribution Spacing & Zero Orphans**: Measure the true visual bounding box (`sourceRectAtTime`) of **every** split callout group across the entire video and shift its vertical midpoint onto exact **`y = 540`** (never let text float high in the top half with empty space below). Keep eyebrow-to-quote staggers tight (**`0.25–0.35 s`** — never leave a lone eyebrow hanging for 2+ seconds before the quote arrives), separate speaker attributions (`— Name`) onto their own layer with **`55–65 px`** breathing room (`36 px` gap + `84×3 px` subtle accent divider + `24 px` gap) below the quote's closing line so names never crowd descenders, and audit every headline, body block, and quote for single-word orphan lines.
7. **Mandatory Headroom & Framing Audit Across Every Split**:
   - Visually inspect **every** `Slide Left` / `Slide Right` timestamp with `preview_frame`.
   - Check **headroom** inside the `927×990` Bento window across every camera punch-in scale: avoid unnecessary zoom (`Scale 100%` on medium/tight shots) and shift speaker `Y` down (`+35–75 px`, verifying zero black gap at the top matte edge) so the speaker has clean, consistent portrait headroom on every single split.
   - Check **PiP / wide-stage shots**: conference recordings often place the presenter in a small left PiP box or off-center on stage. Inspect the uncropped source frame and keyframe `Position` + `Scale` on that clip inside `01_Footage_Track` so the presenter (never a slide edge or empty chairs) fills the Bento window.
8. **50/50 Living Blue Splits vs. 2-Up Callout Boxes**:
   - When pairing B-roll with editorial copy, build a clean **50/50 Living Blue split** (rounded `18 px` video bay on the left `908×1004` + optically centered white `Inter` typography and brand icon directly on `NEW Lving Blue` on the right at `x = 1056..1796`) rather than straddling a floating white info callout box across a 2-up video gutter.
   - When shifting B-roll `startTime` in ExtendScript, always set `startTime` **before** clamping `inPoint = 0` and `outPoint = comp.duration` (shifting `startTime` shifts `outPoint` too).
9. **Bento Pill Precision Alignment, Tight Multi-Up Staggers & Matte Coverage**:
   - Position every lower-corner white Bento pill mathematically from exact measured bay boundaries and `sourceRectAtTime()` (uniform `24 px` left/bottom bay insets across all columns and rows, uniform `Inter-Bold` font size, icon/badge and text anchor optically centered on exact `pillCY`, and synchronized child opacity + `outPoint` exits because AE does not inherit Opacity to children).
   - On `4 up` grids, use tight **`0.15–0.22 s`** quadrant staggers (`0.45 s` slide-up, pills entering **`+0.25–0.35 s`** after each bay starts so pills never float over early motion blur or empty blue) so all 4 bays arrive briskly with momentum.
   - **Never Leave Footage `startTime > matte.inPoint`**: Whenever tightening a Bento card/bay stagger, always verify every child video layer's `startTime <= matte.inPoint`, `inPoint === matte.inPoint`, and `(outPoint - startTime) <= source.duration` so footage never pops in late over an empty matte or freezes early.
10. **Dialogue-First Audio Mixing, Loudness & Premiere Dynamic Link WAV Stem Rule**:
   - **Dynamic Link + Premiere `Enhance Speech` Silent Audio Bug**: When a Premiere Pro sequence containing AI `Enhance Speech` is imported into After Effects via Dynamic Link (`.prproj`), AE's headless Dynamic Link audio bridge frequently drops out to literal **`0.000` silence** after the first few seconds. **Always export a lossless 48 kHz WAV dialogue stem** directly from Premiere Pro (using Premiere's factory `Waveform Audio 48kHz 16-bit.epr` preset via `export_sequence` to a colon-free path), import that WAV into AE's `04_Audio` folder synced to the exact speaker `inPoint`, and set `audioEnabled = false` on the Dynamic Link video layer (and all B-roll layers) so dialogue never drops out or doubles.
   - **Measure Both Stems Before Setting dB**: Measure integrated loudness (`ffmpeg -vn -af ebur128`) on **both** the exported dialogue WAV and the background music track—stock corporate masters are often brickwalled at **`-9` to `-11 LUFS`**, where a naive `-20` or `-22 dB` duck still blasts `-31 LUFS` over dialogue.
   - **Target Loudness**: Gain-stage dialogue to **`-20 to -18 LUFS`** (True Peak `<= -1.5 dBFS`), set speech-free intro/outro music beds to **`-22 to -20 LUFS`** (matching the `-22.7 LUFS` Sonic Ident), and duck music under active speech to **`-40 to -44 LUFS`** (**`20–24 LU` below active speech**, typically **`-32 to -36 dB`** on hot `-9 to -11 LUFS` masters) with smooth eased `0.8–1.0 s` duck ramps and a clean fade to `-60 dB` into the Sonic Ident. Verify live audio levels across multiple timestamps in the master comp before saving.
11. **B-Roll Exposure (`~80 IRE`) & A-Cam Interview Color Match**:
   - Audit **every** live-action B-roll clip against the A-cam speaker interview before finishing: render a multi-scene `preview_frame` sheet including A-cam and all B-roll shots, measure Rec.709 luma percentiles (`p50` midtones, `p99` highlight ceiling in IRE) and mid-highlight RGB balance, and apply per-shot native **`ADBE Lumetri`** (`Lumetri Color`, placed **above** any `Drop Shadow` effect) so every live-action B-roll shot sits cleanly around **`80 IRE` peak highlights** (`~79–82 IRE`), matched midtone brightness (`p50 ~32–37 IRE`), lifted non-crushed shadows, and neutral-warm white balance/skin tones matching A-cam (removing fluorescent cyan-green office casts without pushing white ceilings magenta).
   - Keep dark-mode UI dashboard captures legible with a lighter highlight/contrast touch rather than blowing UI darks out to live-action levels.

---

## Verification & QA Loop (Required Before Finishing)

1. Run `review_motion` on the target comp and fix any reported warnings (overlapping text, clipping, frozen holds, off-frame elements).
2. Run `preview_frame` with a 6–9 timestamp contact sheet spanning entrance, multi-up staggers, mid-hold, every `Slide Left`/`Slide Right` split, every B-roll clip alongside A-cam, and exit.
3. Inspect the contact sheet visually and quantitatively for:
   - `Inter` typography legibility, uniform quote sizing, optical `y = 540` vertical centering, tight eyebrow-to-quote staggers, generous attribution clearance, zero orphan words, and title-safe margins
   - Presenter headroom and framing inside every Bento window (zero cropped heads, zero empty slide-only crops)
   - Uniform white pill alignment across multi-up bays, zero late footage pop-ins, and clean `sourceRectAtTime()` padding (no misaligned text or straddling callout boxes)
   - Smooth native text reveal IN/OUT (no expression errors, ghost child text, or stuck frames)
   - Consistent `18 px` card radii, alignment, and safe margins
   - Live-action B-roll exposure (`~80 IRE` highlights) and `Lumetri Color` continuity matched to A-cam interview
   - Live dialogue WAV stem playback across the full timeline and calibrated music-to-dialogue headroom (`20–24 LU` below speech) verified against measured LUFS
4. Save the project with `save_project` (`snapshot: true`, `note` `<= 60` chars) once verified.

---

## Rendering, Premiere Pro Handoff & MCP Guardrails

1. **Always Set `start` Equal to `in` on Precomps**: When adding precomp layers (`L3`, `Bumper IN CTA`, `STD ident`) at `in: T`, always pass `start: T` as well—otherwise AE starts the precomp at `0.0s` and its animation will have already finished before `in`.
2. **Alpha Output Module**: Always render `L3` lower thirds, `Bumper IN CTA` intros, and `STD ident` with `om_template: "High Quality with Alpha"` (ProRes 4444 12-bit, `yuva444p12le`) into `Assets/Renders/` or `Assets/Graphics/` so alpha wipes and pill shapes composite cleanly.
3. **Avoid CEP & Render Contention**:
   - Never call multiple `render_start` tools in parallel (concurrent `prepare_render` calls can lock AE's bridge). Queue renders one at a time, or run `aerender` sequentially (**never** pipe `aerender.exe` directly into PowerShell `Select-Object`, which can hang on stdout).
   - In Premiere Pro (`premiere-pro-mcp`), run heavy `import_media` (multi-GB MP4s) and `add_to_timeline` calls **sequentially** (1 at a time) so the single-threaded CEP bridge never times out.
4. **Lay Directly in the Edit Sequence / Dynamic Link**: For Dynamic Link workflows, import `Frame - MAIN` directly into Premiere Pro (**File → Adobe Dynamic Link → Import After Effects Composition**). For pre-rendered overlays, place graphics directly on upper tracks (`V2`/`V3`), reserving `0.00s`–`7.80s` at the head for `Bumper IN CTA` and overlapping `STD ident` over the final `1.30s` of the closing card/shot.
5. **Two-Person Studio Interviews (`L3`)**: When both speakers are introduced together on a Wide 2-Shot, stack `Lowerthird 1 EDIT ME - LEft - OUT` and `Lowerthird 1 EDIT ME - Right - OUT` simultaneously on `V3`/`V4` and hold the wide shot until both lower thirds finish animating out (`~10s`).
6. **Importing Premiere Pro `.prproj` into After Effects**: `import_footage` on a `.prproj` works via Dynamic Link, **but** pops up AE's interactive **"Import Premiere Pro Project"** sequence-picker modal (causing `ae-motion`'s 30s timeout until the user clicks OK). Always load & save brand dependencies into `Assets/_Dependancies` *before* importing `.prproj`, warn the user that the sequence picker will appear, and confirm the imported sequence with `get_project` afterward.
7. **ExtendScript (`run_jsx`) & macOS Path Guardrails**:
   - **`setTemporalEaseAtKey` dimensions**: Spatial properties (`ADBE Position`, `ADBE Anchor Point`) require a **1-element** ease array, while non-spatial vector properties (`ADBE Scale` = 3 elements even on 2D layers, `ADBE Audio Levels` = 2 elements) require `prop.value.length` elements (`isSpatial ? 1 : prop.value.length`).
   - **Opacity is not inherited by children**: Always keyframe `Opacity` and trim `outPoint` on every child layer of a parented graphic/pill group so child text never lingers during exits.
   - **Set `startTime` before `inPoint`/`outPoint`**: Shifting `startTime` shifts both `inPoint` and `outPoint`; always set `startTime` first, then clamp `inPoint` and `outPoint`.
   - **Real newlines in `set_text`**: Pass actual newline characters rather than escaped literal `\r` strings.
   - **Avoid macOS Finder `/` (`:` in POSIX) folders for exports**: Finder folders displaying `/` (e.g., `04 V/O`) contain a POSIX colon (`04 V:O`), which can break ExtendScript `File()` and Media Encoder export paths—write exported WAV stems and renders to clean colon-free paths.
   - **`save_project` `note` length**: Keep `note` `<= 60` characters.
