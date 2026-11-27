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
| **Bento Pull-Quote** | `Inter-Bold` | `76 px` | `90 px` | White `[1,1,1]` | `-20` tracking, `770 px` symmetrical measure (`x = 1044..1814` Right / `x = 106..876` Left), paired with an oversized `360 px` `“` watermark (`15%` white) behind the opening quote line — no eyebrow or divider rule; optically centered on `y = 540` |
| **Bento Quote Attribution** | `Inter-Bold` / `Inter-Regular` | `38 px` / `28 px` | `46 px` / `36 px` | White / `[0.76, 0.87, 1.0]` | 2-line lockup (`Speaker Name` Bold + `Title, OpenText` Regular `42 px` below) placed `~56–60 px` cleanly below closing quote line (zero divider line) |
| **Split Display Headline** | `Inter-Bold` | `78–84 px` | `90–94 px` | White `[1,1,1]` | `-25` tracking, pure editorial type directly on Living Blue (no eyebrows or divider rules); for Icon Headline, stack a `96×96 px` (`r = 22 px`) white rounded badge above the headline |
| **Split Body Copy** | `Inter-Regular` | `36 px` | `52 px` | `[0.87, 0.93, 1.0]` | `770 px` measure (`~720–750 px` lines), placed `~42 px` below headline; keep balanced 3-line wraps (zero single-word orphans) |
| **Split Icon List** | `Inter-Bold` / `Inter-Regular` | `76 px` hdr; `54 px` / `28 px` rows | `1.15×` / `1.25×` | White / `[0.87, 0.93, 1.0]` | `76 px` section headline directly above 3 rows (`144 px` stride, zero divider lines), each with an `84×84 px` crisp `#FFFFFF` rounded badge (`r = 18 px`, royal-blue `#0F40D6` native vector icon) |
| **Split Big Stat / KPI** | `Inter-Bold` | `184 px` stat / `52 px` ctx | `180 px` / `62 px` | White `[1,1,1]` | `-45` tracking on hero metric + `-15` tracking on context headline directly below, followed by `36 px` proof copy |
| **White Bento Pill Title / Sub** | `Inter-Bold` / `Inter-Regular` | `26–30 px` / `21 px` | `1.2×` | `#0D1B3E` / `#4A5568` | Inside `#FFFFFF` rounded pill (`r = 14–16 px`, `H = 68 px` compact / `92 px` hero) with Living Blue icon badge + native vector icon, uniform `24 px` left/bottom bay inset |
| **Body / Supporting Label** | `Inter-Regular` | `28–38 px` | `1.25×` | White or Off-White | Avoid <26 px on 1080p |
| **CTA Bumper Text** | `Inter-Regular` | `290 px` at `30%` scale (`~87 px` effective) | `400 px` | White (or Black on White theme) | Centered below logo lockup |

---

## 3. Card & Bento Geometry (`45 px` Even-Gap Grid)

Consistent geometry for `1920×1080` (`30 fps`, `180°` motion blur):
- **Corner Radius**: `18 px` (`ADBE Vector Filter - RC` / `Round Corners` radius `18`)
- **Even `45 px` Outer Margins & Internal Gutters**:
  - **Full-Bleed Matte**: `1998.36 × 1118.63` at `[960, 540]`
  - **1-Up Bay**: `1830 × 990` at `[960, 540]`
  - **2-Up / 50-50 Split Bays**: `892.5 × 990` at `x = 491.25` (Left) / `x = 1428.75` (Right), `y = 540`
  - **3-Up Bays**: `580 × 990` at `x = 335` / `960` / `1585`, `y = 540`
  - **4-Up Bays**: `892.5 × 472.5` at `x = 491.25 / 1428.75`, `y = 281.25 / 798.75`
  - **Split Text Column (`770 px` symmetrical measure)**: `x = 1044..1814` (Right) / `x = 106..876` (Left) — equal `106 px` clearance from both card edge and screen edge (`>5.5%` title-safe)
- **Card Drop Shadow** (`ADBE Drop Shadow`):
  - Color: `[0, 0, 0]`
  - Opacity: `77` (out of 255, ~30%)
  - Direction: `243°`
  - Distance: `20`
  - Softness: `59`
- **Footage Windows**: Use shape layers as **Alpha Track Mattes** (`set_track_matte`) over dedicated full-frame `1920×1080` holder precomps (`Footage Holder - Primary`, `B-Roll Holder 1–4`) so swapping footage never breaks rounded corners or card motion.
- **Parented Info Pills**: Anchor each pill comp at `24 px` left/bottom bay-local inset (`leftX = 960 - bayW/2 + 24`, `bottomY = 540 + bayH/2 - 24`), parent directly to its `Bay N - Matte` (`Anchor [960, 540]`, `Position [0, 0]`, `Motion Blur ON`), and apply `Drop Shadow` externally on the pill precomp layer.
- **Border Frame**: Inverted alpha matte (`alpha_inverted`) with a `4-Color Gradient` border or `Solid White` toggle.

---

## 4. Motion & Timing Signature

- **Frame Rate**: `30 fps` everywhere (`180°` shutter angle motion blur enabled on Bento master, B-Roll beats, Info Pills, and Split Text Slides).
- **Signature Motifs**:
  1. **Left-to-Right Character Ramp Reveal (`Info Pill - 1-Up` DNA)**: Native AE Text Animator (`Opacity: 0%`, `Shape: Ramp Up`, `Smoothness: 100%`, `Based On: Characters`, `Offset: -100% → 100%` with `22 / 84` ease IN, reversed `100% → -100%` over `0.67 s` at `16.67 / 16.67` OUT) paired with crisp vertical position glide (`74 px` text / `80 px` badges over `0.67 s`: snap-decel **`0.1 / 100`** IN, velvety **`100 / 0.1`** OUT; linear `0.25 s` opacity IN, smooth `0.25 s` fade at end of exit; steady `100%` badge scale with zero bounce).
  2. **Circular `"O"` Reveal / Wipe**: Used across `Transition` and `Bumper` comps (`SILHOUETE_ALPHA` / 3D scale push).
  3. **Living Backgrounds**: Continuous subtle drift (`loopOut("cycle")` on `4-Color Gradient` points + `Turbulent Displace` evolution) so holds never feel dead/frozen.
- **Pacing & Easing**:
  - First motion starts within `0.15–0.33 s`.
  - **Unified Bento Card / Matte / Border Curve**: Exact **`ease_out 61% / ease_in 60%`** across ALL Bento matte, `Border_MATTE`, `Footage Holder - Primary` scale, and B-Roll bay IN & OUT transitions (`0.55–0.65 s`); use `HOLD` keyframes for off-screen resets.
  - **Parented Info Pill Timing**: Start each bay's `Info Pill` **1 frame after its bay finishes landing** (`~0.57–1.13 s`), with pill hold extended so outro begins *after* bay lift-off (pills ride up 100% solid with their card and still preserve Responsive Design – Time Protected Regions).
  - `4-Up` quadrant stagger: `0.18 s` between bays (`0.55 s` slide-up).
  - Split text exits: reverse-staggered (lowest rows/attribution exit first, headline exits last), with **Responsive Design – Time Protected Regions** synced via `Update Markers From Source` on nested layers.
  - Lower third stagger: `Name` enters at `0.33 s`, `Title` enters at `0.87 s` (`+0.53 s` offset).

---

## 5. Audio Loudness & B-Roll Exposure Targets

| Signal | Target Metric | Notes |
| :--- | :--- | :--- |
| **Speaker Dialogue Stem** | `-20` to `-18 LUFS` (True Peak `<= -1.5 dBFS`) | Export 48 kHz WAV from Premiere when using `Enhance Speech` |
| **Intro / Outro Music (No Speech)** | `-22` to `-20 LUFS` | Anchored to Sonic Ident (`-22.7 LUFS` integrated) |
| **Ducked Music Under Speech** | `-40` to `-44 LUFS` (`20–24 LU` below speech) | Always measure raw music LUFS first (`-9` to `-11 LUFS` stock tracks need `-32` to `-36 dB`) |
| **Live-Action B-Roll Exposure** | `p99 ≈ 80 IRE` (`79–82 IRE`), `p50 ≈ 32–37 IRE` | Match A-cam neutral-warm white balance & skin tones via native `ADBE Lumetri` |
