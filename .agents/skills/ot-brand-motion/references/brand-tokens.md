# OpenText Brand Tokens & Motion DNA

Extracted directly from the canonical `AE MCP Brand System.aep` templates. Use these exact values (`[r, g, b]` in `0–1` for `ae-motion` tools) when styling Bento layouts or creating net-new branded scenes.

---

## 1. Color Palette

### Living Blue (Primary Brand Signature)
Driven procedurally on `NEW Lving Blue` via `CC RepeTile` + looping `4-Color Gradient` + `Turbulent Displace`:
| Token | Hex | AE `[r, g, b]` | Usage |
| :--- | :--- | :--- | :--- |
| **Deep Navy** | `#00008B` | `[0.0, 0.0, 0.545]` | Gradient corners 1 & 4, dark blue depth |
| **Royal Blue** | `#1A6AFF` | `[0.102, 0.416, 1.0]` | Gradient corners 2 & 3, primary brand accent, L3 pill highlight |

### Living Metal (Secondary / Experimental Brand Surface)
Driven procedurally on `NEW Lving Metal`:
| Token | Hex | AE `[r, g, b]` | Usage |
| :--- | :--- | :--- | :--- |
| **Steel Mid** | `#6F6F6F` | `[0.436, 0.436, 0.436]` | Gradient corner 1 |
| **Silver Light** | `#B6B6B6` | `[0.715, 0.715, 0.715]` | Gradient corner 4 |
| **Pure White** | `#FFFFFF` | `[1.0, 1.0, 1.0]` | Gradient corners 2 & 3, metallic highlights |

### Neutrals & Bento Surfaces
| Token | Hex | AE `[r, g, b]` | Usage |
| :--- | :--- | :--- | :--- |
| **Pure White** | `#FFFFFF` | `[1.0, 1.0, 1.0]` | Primary text on dark/blue, White theme bumpers/transitions |
| **Off-White** | `#EBEBEB` | `[0.922, 0.922, 0.922]` | Secondary text / subtle labels |
| **Charcoal BG** | `#1F1F1F` | `[0.122, 0.122, 0.122]` | Standard dark comp background (Bumpers, Ident) |
| **Bento Slate** | `#1A1F2E` | `[0.102, 0.122, 0.180]` | Bento workspace / card dark blue-slate surface |
| **Bento Deep** | `#0F0F14` | `[0.059, 0.059, 0.078]` | High-contrast dark Bento canvas (`4 up`, `Border Frame`) |
| **True Black** | `#000000` | `[0.0, 0.0, 0.0]` | Black theme bumpers/transitions, drop shadow color |

---

## 2. Typography (`Inter`)

Always use the **`Inter`** family (replace `MyriadPro-Regular` in Bento skeletons):

| Role | Font | 16:9 Size (`1080p`) | Leading | Color | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Hero / Slide Headline** | `Inter-Bold` | `96–140 px` | `1.10–1.15×` | White `[1,1,1]` | Keep concise (1–2 lines) |
| **Bento Card Title / Metric** | `Inter-Bold` | `48–72 px` | `1.15×` | White `[1,1,1]` | Left-aligned inside card padding |
| **Lower Third — Name** | `Inter-Bold` | `46 px` | `55.2 px` | White `[1,1,1]` | Auto-sizes `BG` via `sourceRectAtTime` |
| **Lower Third — Title** | `Inter-Regular` | `27 px` | `32.4 px` | White `[1,1,1]` | Always append `, OpenText` for internal speakers; supports `Double Title` checkbox |
| **Bento Pull-Quote** | `Inter-Bold` | `56 px` | `70 px` | White `[1,1,1]` | `-10` tracking, `box_size: [730, 560]`, `anchor: [0, 0]`, `x = 1477` (right) / `x = 493` (left), visually centered on `y = 540` |
| **Bento Quote Attribution** | `Inter-Regular` | `34 px` | `70 px` | `[0.84, 0.93, 1.0]` | Styled via `set_text` range on `— Speaker Name` inside the quote box |
| **Body / Supporting Label** | `Inter-Regular` | `28–38 px` | `1.25×` | White or Off-White | Avoid <26 px on 1080p |
| **CTA Bumper Text** | `Inter-Regular` | `290 px` at `30%` scale (`~87 px` effective) | `400 px` | White (or Black on White theme) | Centered below logo lockup |

---

## 3. Card & Bento Geometry

Consistent geometry extracted from `4 up`, `Windows`, and `Border Frame`:
- **Corner Radius**: `18 px` (`ADBE Vector Filter - RC` / `Round Corners` radius `18`)
- **Card Drop Shadow** (`ADBE Drop Shadow`):
  - Color: `[0, 0, 0]`
  - Opacity: `77` (out of 255, ~30%)
  - Direction: `243°`
  - Distance: `20`
  - Softness: `59`
- **Footage Windows**: Use shape layers as **Alpha Track Mattes** (`set_track_matte`) over `Window - Footage Holder` precomps so swapping footage never breaks rounded corners or card motion.
- **Border Frame**: Inverted alpha matte (`alpha_inverted`) with a `4-Color Gradient` border or `Solid White` toggle.

---

## 4. Motion & Timing Signature

- **Frame Rate**: `30 fps` everywhere.
- **Signature Motifs**:
  1. **Left-to-Right Character Ramp Reveal**: Native AE Text Animator (`Opacity: 0%`, `Shape: Ramp Up`, `Smoothness: 100%`, `Based On: Characters Excluding Spaces`, `Offset: -100% → 100%` with `easeOut`) paired with subtle directional slide (`Position`).
  2. **Circular `"O"` Reveal / Wipe**: Used across `Transition` and `Bumper` comps (`SILHOUETE_ALPHA` / 3D scale push).
  3. **Living Backgrounds**: Continuous subtle drift (`loopOut("cycle")` on `4-Color Gradient` points + `Turbulent Displace` evolution) so holds never feel dead/frozen.
- **Pacing**:
  - First motion starts within `0.15–0.33 s`.
  - Card / element entrances: `0.45–0.65 s` decelerating (`snappy` / `easeOut`), staggered `0.06–0.12 s` across Bento cards (`Windows` staggers `0.33 s` per window).
  - Lower third stagger: `Name` enters at `0.33 s`, `Title` enters at `0.87 s` (`+0.53 s` offset).
  - Exits accelerate (`easeIn`), `0.35–0.45 s`.
