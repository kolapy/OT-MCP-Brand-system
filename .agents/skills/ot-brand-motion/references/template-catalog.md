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
Root folder: `Assets/Dependancies/OT Corp level brand package (CC26)-V3.aep/`

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

---

## Module 2: Bento Base Template
Root folder: `Assets/Dependancies/Bento Base template (converted).aep/`

### Layout Skeleton Comps (`1920x1080`, `10 s`, `30 fps`)
Use these as structural starting points; upgrade typography from `MyriadPro-Regular` → `Inter` and apply brand surfaces/animations:
| Comp Name | Structure / Controls |
| :--- | :--- |
| `Bento 3-Up` | 3-card layout (4 shape layers + 4 text layers) |
| `Bento 4-Quad` | **Parametric grid** with `4-Quad Controller` null (`Padding`, `Gap`, `Card 1–4 Width %`, `Card 1–4 Height %`) + `Card 1–4` shapes |
| `Bento Asymmetric` | Asymmetric hero + supporting cards (4 shapes + 4 text layers) |
| `Bento Frame` | Framed hero container with `Bento Frame Controller` (`Solid White` checkbox) |
| `Bento Grid 2x2` | Clean dark `2x2` starter canvas (`#0F0F14`) |
| `Bento Hero Chips` | Hero card + chip callouts (4 shapes + 4 text layers) |
| `Bento Timeline` | Multi-step horizontal/vertical timeline (8 shapes + 24 text layers) |
| `Info Slide` | Structured information slide (1 shape + 4 text layers) |

### Polished Framing / Footage Output Comps (`OUTPUT/`)
| Comp Name | Purpose & Structure |
| :--- | :--- |
| `4 up` | 4 rounded (`18 px`) card mattes (`1`–`4`) over white/custom backing |
| `Border Frame` | `alpha_inverted` rounded frame with `4-Color Gradient` + `Solid White` checkbox |
| `Frame` | Rounded `MATTE` over `Footage Holder Comp` on top of canonical `NEW Lving Blue` (`BG`) |
| `Windows` | 4 staggered (`0.33 s` offset) rounded (`18 px`) drop-shadowed matte windows (`1–4 - Matte - MOVE ME`) paired with `Window - Footage Holder 1–4` precomps |

### Footage Holder Precomps (`Assets/_Comps/`)
- `Footage Holder Comp` (used by `Frame`)
- `Window- Footage Holder 1`, `Window - Footage Holder 2`, `Window - Footage Holder 3`, `Window - Footage Holder 4` (used by `Windows`)
- Swap media inside these holders (or use `replace_source`) to keep all Bento mattes, shadows, and animations intact.
