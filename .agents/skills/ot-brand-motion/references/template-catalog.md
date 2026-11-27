# Template Catalog (`AE MCP Brand System.aep` & Standalone Modules)

All paths below are relative to `<REPO_ROOT>` (resolved automatically from `../../..` relative to `SKILL.md`).

## Canonical Project & Standalone Module Paths
- **Combined Master Project (`16 MB`)**: `Projects/AE MCP Brand System.aep`
- **Standalone Module 1 — Corp Brand Package (`14 MB`, 30 fps, native)**: `Projects/Modules/OT_Corp_Brand_30fps.aep`
  - Relinked exclusively to `Assets/Brand_Footage/` (`OpenText_Mnemonic_Final_WAV.wav`, `Reverb_Audio.wav`, `Simple_Tile_1080p_Alpha.mov`, `waves_render.mp4`, `OT+OpenText logo color_white-Tagline.ai`).
  - **Sonic Ident (`STD ident`) Alpha Wipe-In Note**: `0%` transparent at `0.00s` → `100%` opaque at `1.30s` — overlap the final `1.30s` of the closing scene on an upper track so it hits full opacity on the exact end frame.
- **Standalone Module 2 — Bento Base Template (`2.4 MB`, 30 fps, zero external footage)**: `Projects/Modules/OT_Bento_30fps.aep`
  - All stock/placeholder clips replaced with clean `#1A1F2E` solids so it opens on any machine with zero missing footage.

All compositions are **30 fps**, deduplicated, and free of Animation Composer dependencies.

---

## Module 1: Corp Brand Package
Root folder: `Assets/_Dependancies/OT_Corp_Brand_30fps.aep/` (or `OT Corp level brand package (CC26)-V3.aep/`)

Available in both **`OUTPUT - 16x9/`** (`1920x1080`) and **`OUTPUT - 9x16/`** (`1080x1920`):

### Backgrounds (`BAckground/`)
| Comp Name (16:9) | 9:16 Counterpart | Notes |
| :--- | :--- | :--- |
| `NEW Lving Blue` | `NEW Lving Blue - 9x16` | Primary looping Living Blue (`CC RepeTile` + `4-Color Gradient` + `Turbulent Displace`) |
| `NEW Lving Blue Alt` | `NEW Lving Blue Alt - 9x16` | Alternate Living Blue movement/tone |
| `NEW Lving Metal` | `NEW Lving Metal - 9 x16` | Experimental metallic silver/white looping BG |
| `NEW Lving Metal Alt` | `NEW Lving Metal Alt - 9 x16` | Alternate Living Metal |

### Lower Thirds (`L3/` and `L3/W/ Out/`)
- **Positions**: `Center`, `LEft`, `Right` (each in standard hold-only and `W/ Out` animated-exit variants, for both `16x9` and `9x16`).
- **Editable Layers**:
  - `Name` (`Inter-Bold`, 46 px) — native `TR In` / `TR Out` marker-driven text reveal
  - `Title` (`Inter-Regular`, 27 px) — native `TR In` / `TR Out` marker-driven text reveal
- **Controls (`CTRL` null)**:
  - `Double Title` (Checkbox) — expands vertical spacing for 2-line titles
  - `Left Justified` (Checkbox, on Right-hand L3 comps) — toggles text justification
- **Auto-Sizing (`BG` shape layer)**:
  - `Position` uses `sourceRectAtTime()` to track `Math.max(right1, right2) + Offset` (`Offset` slider on `BG`).

### Logo Bugs (`Logo Bug/`)
- Corners: `Logo Bug - top L`, `top R`, `bot L`, `bot R` (both `16x9` and `9x16`).

### Simple Bumpers & CTA Bumpers (`Simple Bumpers/IN/` and `OUT/`)
- **Themes**: `Black`, `Blue`, `White` (both `IN` and `OUT`, in `16x9` and `9x16`). Note: `Bumper IN CTA-- Blue - 16x9` has a **Black Solid** background with the Blue/White OpenText logo; `White` has Living Blue background; `Black` has light/white background.
- **CTA Variants (`IN/CTA/` and `OUT/CTA/`)**:
  - Editable layer: `CTA Text` (IN) or `CTA Text 2` (OUT) — native `TR In` text reveal, 3D layer linked to `Cam Control` camera rig + `V2.5 -Blue/Black/White` logo precomp. Supports multi-line styled ranges via `set_text` (e.g., `Inter-Bold` 290 px headline + `Inter-Regular` 210 px subtitle).
  - **Alpha Wipe-Out (`IN/CTA`)**: `9.03s` total duration; circular `"O"` silhouette-alpha wipe runs from **`7.80s` to `9.03s`** (`1.23s`). Render with `om_template: "High Quality with Alpha"` (ProRes 4444) and place on an upper track at `0.00s` with main footage starting at `7.80s` so the `"O"` wipes cleanly into the opening shot.

### Transitions (`Transition/`)
- `Transition - Black`, `Transition - Blue`, `Transition - White` (`7 s` comp, `1.53 s` work area, circular `"O"` wipe over `NEW Lving Blue` / solid). Available in `16x9` and `9x16`.

### Sonic Ident (`Sonic Ident/`)
- `STD ident` (`1920x1080`), `STD ident 4k` (`3840x2160`), `STD ident - 9x16` (`1080x1920`).
- Includes `OpenText_Mnemonic_Final_WAV.wav`, animated 3D `O-P-E-N-T-E-X-T` + `tm` vector chain, and `Simple Tile` pre-render.
- **Loudness Anchor**: Integrated `-22.7 LUFS` (Peak `-4.1 dBFS`) — use as the loudness reference for speech-free intro/outro music beds.

---

## Module 2: Bento Base Template (`Bento Base template (converted).aep`)
Self-contained `15 MB` portable package (`6.1 MB` `.aep` + `7.9 MB` compressed `1080p` `30 fps` placeholder MP4s in `(Footage)/Placeholder_Footage/`, zero external OneDrive links, zero third-party plugins, zero script dependencies).

### Master Output Comp (`OUTPUT/`)
| Comp Name | Purpose & Structure |
| :--- | :--- |
| **`Bento - MASTER`** | **Canonical 1-Speaker-Frame Bento Assembly (`60.03 s`, `1920×1080`, `30 fps`, `180°` motion blur, zero expressions)**: Single speaker Bento frame (`MATTE` + `Footage Holder - Primary`) over continuous `BG - NEW Lving Blue (60s)` (two back-to-back native 30s `NEW Lving Blue` layers, zero Time Remapping). Separate transparent `Broll - 1-Up / 2-Up / 3-Up / 4-Up` comps stack **above** the speaker and animate UP from bottom as the speaker animates UP & OFF (vertical conveyor belt, uniform `61 / 60` ease). Separate transparent `Split Copy` comps stack **behind** `Footage Holder - Primary` (above `BG`), revealed cleanly on `Slide Left` / `Slide Right`. `Border Frame - White` stacks above the speaker/L3 slot. |
| `OUTPUT/.old/*` | Archived legacy comps (`4 up`, `Border Frame`, `Frame`, `Windows`) kept for reference (`Window - Footage Holder 1–4` in `Assets/_Legacy (for .old)`). |

### Modular Component Library (`Assets/Components/`)
| Subfolder | Contents & Notes |
| :--- | :--- |
| **`B-Roll Beats/`** | Transparent, motion-blurred `45 px`-gap B-Roll beats (`18 px` radius, `61 / 60` easing): `Broll - 1-Up` (`1830×990`), `Broll - 2-Up` (`892.5×990`), `Broll - 3-Up` (`580×990`), `Broll - 4-Up` (`892.5×472.5`), and `Broll - 50-50 Split + Copy` (`892.5×990` left bay + right editorial copy). Every multi-up bay has its own toggleable `Info Pill` parented directly to `Bay N - Matte`. |
| **`Split Text Slides/`** | Transparent, line-free oversized editorial splits on Living Blue (`770 px` symmetrical measure, optically centered on `y = 540`, `Info Pill - 1-Up` `0.1/100` & `100/0.1` motion DNA, **Responsive Design – Time Protected Regions**): `Split Copy - Icon List (Right)`, `Split Copy - Pull-Quote (Left)`, `Split Copy - Icon Headline (Right)`, `Split Copy - Big Stat (Right)`, `Split Copy - Right`, `Split Copy - Left`. Move stationary `Center_And_Exit_CTRL.x` between `1044` (Right) and `106` (Left) to flip sides in 1 click. |
| **`Info Pills/`** | Responsive white callout pills with Living Blue badge, native AE vector icon, `Info Pill CTRL` sliders (`Auto Width`, `Manual Width`, `Right Padding`), `Preserve Underlying Transparency` + alpha-matted vector clipping, and **Responsive Design – Time Protected Regions**: master `Info Pill - 1-Up`, standalone `Info Pill - Hero (2-Line)` & `Info Pill - Compact (1-Line)`, plus per-bay folders `2-Up/`, `3-Up/`, `4-Up/`. |
| **`Icons/`** | `18` native `100×100` AE Vector Shape Layer icon comps (`icon_*`, continuously rasterized `☀`) converted from official OpenText SVGs — zero external PNG dependencies. |
| **`Footage Holders/`** | Drop-in `1920×1080` (`Scale 100%`) footage precomps: `Footage Holder - Primary` (`60.03 s`, speaker slot) and `B-Roll Holder 1–4` (`30 s`, B-Roll bay slots). Swap media inside these holders to populate every Bento layout automatically. |
| **`Backgrounds & Borders/`** | Procedural `NEW Lving Blue` (`30 s`), seamless `BG - NEW Lving Blue (60s)`, and `Border Frame - White (60s)`. |
| **`Assets/Placeholder Footage/`** | `5` heavily compressed (`7.9 MB` total) `1080p` `30 fps` silent H.264 placeholders (`Speaker_Placeholder.mp4` + `Broll_Placeholder_01–04.mp4`), natively looped via `Interpret Footage → Loop`. |
