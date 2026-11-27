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
| **Bento Pull-Quote** | `Inter-Bold` | `54–56 px` | `66–70 px` | White `[1,1,1]` | `-10` tracking, `box_size: [730–740, 320–560]`, right column `x = 1056` / left column `x = 104`, entire group optically centered on `y = 540` |
| **Bento Quote Attribution** | `Inter-Regular` | `32–34 px` | `38–42 px` | `[0.84, 0.93, 1.0]` | Separate layer placed `55–65 px` below closing quote line (`36 px` gap + `84×3 px` subtle divider `[0.60, 0.82, 1.0]` + `24 px` gap) |
| **Split Eyebrow Label** | `Inter-SemiBold` | `22 px` | `26.4 px` | `[0.64, 0.82, 1.0]` | Uppercase, tracking `+160`, placed `22–24 px` above split headline or pull-quote |
| **50/50 Split Headline** | `Inter-Bold` | `54 px` | `64 px` | White `[1,1,1]` | `-15` tracking, optional `56×56 px` white brand icon vertically centered to headline glyph bounds (`20 px` gap) |
| **50/50 Split Body Copy** | `Inter-Regular` | `32 px` | `46 px` | `[0.86, 0.94, 1.0]` | `box_size: [740, 220]`, placed below `120×4 px` accent rule; keep balanced 2-line wraps (zero single-word orphans) |
| **White Bento Pill Title / Sub** | `Inter-Bold` / `Inter-Regular` | `26–30 px` / `21 px` | `1.2×` | `#0D1B3E` / `#4A5568` | Inside `#FFFFFF` rounded pill (`r = 14–16 px`, `H = 68 px` for 4-Up / `92 px` for 1-Up), uniform `24 px` left/bottom bay inset |
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
- **Pacing & Easing**:
  - First motion starts within `0.15–0.33 s`.
  - Bento matte IN / `Frame Up`: `0.45–0.65 s` decelerating (`ease_out 61% / ease_in 60%`).
  - Bento matte OUT / `Frame Up & Off` / `Border` exit: invert curves (`ease_out 60% / ease_in 61%`), `0.40–0.65 s`; use `HOLD` keyframes for off-screen resets.
  - `4 up` quadrant stagger: tight `0.15–0.22 s` between bays (`0.45 s` slide-up), with white callout pills emerging `+0.25–0.35 s` after each bay starts.
  - Split callout / pull-quote stagger: Eyebrow → Headline/Quote `0.25–0.35 s`; Rule/Attribution `+0.30–0.40 s`.
  - Lower third stagger: `Name` enters at `0.33 s`, `Title` enters at `0.87 s` (`+0.53 s` offset).
  - Exits accelerate (`easeIn`), `0.35–0.45 s`.

---

## 5. Audio Loudness & B-Roll Exposure Targets

| Signal | Target Metric | Notes |
| :--- | :--- | :--- |
| **Speaker Dialogue Stem** | `-20` to `-18 LUFS` (True Peak `<= -1.5 dBFS`) | Export 48 kHz WAV from Premiere when using `Enhance Speech` |
| **Intro / Outro Music (No Speech)** | `-22` to `-20 LUFS` | Anchored to Sonic Ident (`-22.7 LUFS` integrated) |
| **Ducked Music Under Speech** | `-40` to `-44 LUFS` (`20–24 LU` below speech) | Always measure raw music LUFS first (`-9` to `-11 LUFS` stock tracks need `-32` to `-36 dB`) |
| **Live-Action B-Roll Exposure** | `p99 ≈ 80 IRE` (`79–82 IRE`), `p50 ≈ 32–37 IRE` | Match A-cam neutral-warm white balance & skin tones via native `ADBE Lumetri` |
