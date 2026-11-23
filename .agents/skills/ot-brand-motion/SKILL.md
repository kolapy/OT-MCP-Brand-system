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

The brand system is organized into **two separate modules**:
1. **Corp Brand Package** (`Assets/Dependancies/OT Corp level brand package (CC26)-V3.aep`) — canonical 16:9 and 9:16 Backgrounds, Lower Thirds (`L3`), Logo Bugs, Simple/CTA Bumpers, Transitions, and Sonic Ident.
2. **Bento Module** (`Assets/Dependancies/Bento Base template (converted).aep`) — modular Bento layout skeletons (`Bento 3-Up`, `4-Quad`, `Asymmetric`, `Frame`, `Grid 2x2`, `Hero Chips`, `Timeline`, `Info Slide`) and footage-framing comps (`4 up`, `Border Frame`, `Frame`, `Windows`).

## References (Load on Demand)
- [Brand Tokens & Motion DNA](./references/brand-tokens.md) — exact RGB/Hex palette, `Inter` type hierarchy, Bento card geometry, and timing/easing standards.
- [Template Catalog](./references/template-catalog.md) — comp inventory, controller nulls, checkboxes, sliders, and footage-holder precomps across both modules.
- [Native AE Expressions](./references/native-expressions.md) — zero-plugin text reveal IN/OUT, responsive `sourceRectAtTime()` auto-sizing, and looping Living Blue/Metal gradient expressions.
- [OT Icons Library](../ot-storyboard-bento/references/ot-icons-library.md) — searching `ot-icons-library.onrender.com` (`/data/icons-index.json`) for official OpenText SVGs.

---

## Core Standards (Non-Negotiable)

1. **Frame Rate**: Always **30 fps** (`1920x1080` for 16:9, `1080x1920` for 9:16, `3840x2160` for 4K).
2. **Never Edit Canonical Templates Directly**: Duplicate or precompose from `Assets/Dependancies/...` or `_OT_Brand_Dependencies/...` into a working folder before customizing copy, timing, or layout. When starting a brand-new video from the master `.aep`, immediately `save_project` to a new file path first.
3. **Real Brand Bookends Only**:
   - **Standard Intro**: Pick 1 of the 3 official `Bumper IN` / `Bumper IN CTA` color options based on tone (`White` = White logo on Living Blue; `Blue` = Blue/White logo on Black; `Black` = Black logo on White). Never redraw or fake the OpenText logo with `Inter` text. `Bumper IN CTA` ends with a `1.23s` circular `"O"` alpha wipe (`7.80s`–`9.03s`) — render with alpha and overlap the opening footage starting at `7.80s`.
   - **Standard Closer**: Always end with the **real Sonic Ident** (`STD ident` comp or `IDENT 2025 - Tail --2026 - Rev2.mov` with `OpenText_Mnemonic_Final_WAV.wav`). Note: the pre-rendered 2026 Tail `.mov` has a `1.30s` alpha wipe-in (`0.00s`–`1.30s`) and should be laid on an upper video track overlapping the final `1.30s` of the closing shot.
4. **Typography**: Always **`Inter`** (`Inter-Bold` for headlines/names, `Inter-Regular` for body/titles/CTAs). When upgrading Bento skeleton comps, replace placeholder `MyriadPro-Regular` text with `Inter`.
5. **Zero Third-Party Plugins**: Never use Animation Composer (`Pseudo/MHAC`) or third-party effects. Use native AE Text Animators with the marker-aware expressions in [Native AE Expressions](./references/native-expressions.md) or `ae-motion`'s `text_reveal`.
6. **Fast Batching (Avoid Overloading AE)**: Combine dependent edits into `batch` calls (`$N.id` references), but run heavy `review_motion` / `preview_frame` calls **sequentially** (1–2 at a time) so the AE bridge stays responsive.

---

## Working Inside *Any* Open Project (Auto-Import Dependencies)

Resolve `<REPO_ROOT>` as the root of this brand-system repository (3 levels above this `SKILL.md`: `../../..`, or the user's cloned `ae-mcp-brand-system` folder).

When the user already has a different client/working `.aep` open and asks for OpenText motion graphics, **do NOT replace their open project** (`open_project`). Instead, inspect `get_project` first and import only what is missing into `_OT_Brand_Dependencies/`:

1. **Tier 1 — Editable Module Import (`.aep` via `import_footage`)**:
   - If the user needs **Lower Thirds (`L3`)**, **Bumper IN/OUT**, **CTA Bumpers**, **Living Blue/Metal**, **Transitions**, or the **real Sonic Ident (`STD ident`)**, check if they are already in the project; if not, call `import_footage` on `<REPO_ROOT>/Projects/Modules/OT_Corp_Brand_30fps.aep` with `folder: "_OT_Brand_Dependencies/Corp_Brand"`.
   - If the user needs **Bento layouts** or **Window Footage Holders**, call `import_footage` on `<REPO_ROOT>/Projects/Modules/OT_Bento_30fps.aep` with `folder: "_OT_Brand_Dependencies/Bento"` (100% self-contained, zero external footage).
   - *(Alternative: if both modules are needed together in a brand-new project, open `<REPO_ROOT>/Projects/AE MCP Brand System.aep` and immediately `save_project` to a new file path.)*
2. **Tier 2 — Standalone Net-New Titles / Bento Cards (Zero Import)**:
   - For custom Bento cards, stat pills, or editorial splits inside any project, build directly from [Brand Tokens & Motion DNA](./references/brand-tokens.md) + [Native AE Expressions](./references/native-expressions.md) + official SVGs/PNGs from `ot-icons-library.onrender.com` without importing any `.aep`.
   - *Requirement*: `AE_MCP_ALLOWED_DIRS` in `mcp_config.json` must include `<REPO_ROOT>` and the user's project directory so `import_footage` can read the brand library from any workspace.

---

## Workflows

### Workflow 1: Assemble & Customize from Corp Brand Templates
1. Call `get_project` to confirm whether the Corp Brand module is already in the open project (if starting fresh, `open_project` on `<REPO_ROOT>/Projects/AE MCP Brand System.aep` and immediately `save_project` to a new file; if inside another project, `import_footage` on `<REPO_ROOT>/Projects/Modules/OT_Corp_Brand_30fps.aep`).
2. Look up the required template comp(s) in [Template Catalog](./references/template-catalog.md) (matching target aspect ratio `16x9` or `9x16`).
3. Create a new master assembly comp (`create_comp`, `fps: 30`) or duplicate the target template comp into a working folder.
4. Customize layers:
   - **Lower Thirds (`L3`)**: Update `Name` and `Title` via `set_text`. Toggle `CTRL` checkboxes (`Double Title`, and `Left Justified` on Right-hand L3s) via `set_property`. Retime reveals by moving layer `in`/`out` or `TR In` / `TR Out` markers—do **not** touch the `BG` `sourceRectAtTime()` expression.
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

---

## Verification & QA Loop (Required Before Finishing)

1. Run `review_motion` on the target comp and fix any reported warnings (overlapping text, clipping, frozen holds, off-frame elements).
2. Run `preview_frame` with a 6–9 timestamp contact sheet spanning entrance, stagger, mid-hold, and exit.
3. Inspect the contact sheet visually for:
   - `Inter` typography legibility and contrast against Living Blue / Living Metal / footage
   - Clean `sourceRectAtTime()` box padding (no clipped text or awkward gaps)
   - Smooth native text reveal IN/OUT (no expression errors or stuck frames)
   - Consistent `18 px` card radii, alignment, and safe margins
4. Save the project with `save_project` once verified.

---

## Rendering & Premiere Pro Handoff

When rendering branded motion graphics from AE to import into Premiere Pro:
1. **Alpha Output Module**: Always render `L3` lower thirds and `Bumper IN CTA` intros with `om_template: "High Quality with Alpha"` (ProRes 4444 12-bit, `yuva444p12le`) into the project's `Assets/Graphics/` folder so alpha wipes and pill shapes composite cleanly.
2. **Avoid CEP Contention**: Running 3+ simultaneous `aerender` jobs can saturate CPU and temporarily stall Premiere Pro's CEP bridge. Render 1–2 comps at a time or finish all `aerender` jobs before issuing Premiere MCP calls.
3. **Lay Directly in the Edit Sequence**: Place rendered graphics directly on upper video tracks (`V3`/`V4`) in the active Premiere edit sequence (no extra nested master comp needed), reserving `0.00s`–`7.80s` at the head for `Bumper IN CTA` and overlapping `IDENT 2025 - Tail --2026 - Rev2.mov` over the final `1.30s` of the closing shot.
4. **Two-Person Studio Interviews (`L3`)**: When both speakers are introduced together on a Wide 2-Shot, stack `Lowerthird 1 EDIT ME - LEft - OUT` and `Lowerthird 1 EDIT ME - Right - OUT` simultaneously on `V3`/`V4` and hold the wide shot until both lower thirds finish animating out (`~10s`).
