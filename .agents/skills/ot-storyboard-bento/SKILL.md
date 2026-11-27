---
name: ot-storyboard-bento
description: >-
  Design and build OpenText Bento-treatment video storyboards and B-roll guides in Figma
  using the `figma` MCP server, `ot-icons-library.onrender.com` SVGs, and `@opentext`
  YouTube B-roll sourcing. Use when the user asks to storyboard an OpenText Bento video,
  plan scenes/VO/B-roll in Figma before animating in After Effects, or generate a
  Bento Storyboard + B-Roll Guide.
---

# OpenText Bento Storyboard System (`ot-storyboard-bento`)

Use this skill for **pre-production** of OpenText videos using the **Bento treatment**: drafting beat-by-beat scripts, sourcing B-roll from `@opentext` (or user footage), pulling official SVG icons from `ot-icons-library.onrender.com`, and building the visual storyboard in Figma (`figma` MCP) ready for handoff to `ot-brand-motion` (After Effects).

## References & Bundled Brand Stills (Load on Demand)
- [OT Icons Library Lookup](./references/ot-icons-library.md) — searching `/data/icons-index.json` (10,679 icons) and fetching/recoloring SVGs for Figma and AE.
- **Bundled Official Brand Stills (`./resources/`)** — ALWAYS upload these real renders into Figma via `upload_assets` (`scaleMode: "FILL"`). **NEVER** fake or redraw the OpenText logo with `Inter` text!
  - `resources/bumper_in_white.png` — **White logo on Living Blue** (`Bumper IN --WHite` — default for Living Blue Bento / flagship corporate pieces)
  - `resources/bumper_in_blue.png` — **Blue `ot` tile + white wordmark on Black** (`Bumper IN --BLUE` — use for dark/cyber/dramatic/tech themes)
  - `resources/bumper_in_black.png` — **Black logo on White** (`Bumper IN -- Black` — use for light/clean/editorial themes)
  - `resources/sonic_ident_tile.png` — **Real Sonic Ident Part 1** (3D `ot` tile converge from `STD ident` / `IDENT 2025 - Tail --2026 - Rev2.mov`)
  - `resources/sonic_ident_lockup.png` — **Real Sonic Ident Part 2** (final `ot opentext™` lockup from `STD ident` / `IDENT 2025 - Tail --2026 - Rev2.mov`)

---

## Canonical Storyboard Layout

### Canvas Grid
- **3-column horizontal grid** of storyboard boards:
  - Board size: **`1920 × 1181`** (`1920 × 1080` visual frame + `101 px` `Explaining Text` footer below)
  - Column stride: **`2040 px`** (`x = 0, 2040, 4080` → `120 px` gap)
  - Row stride: **`1420 px`** (`y = 0, 1420, 2840, ...` → `239 px` gap)

### Bento Frame Geometry (`1920 × 1080` visual area — `45 px` Even-Gap Grid)
- **Living Blue Outer Border**: Full `1920 × 1080` background filled with the OpenText Living Blue diagonal gradient (`#00008B` deep navy → `#1A6AFF` royal blue), leaving exact **`45 px` even outer margins & internal gutters** around all B-roll bays (`cornerRadius: 18 px`).
- **Standard Bay Layouts** (`45 px` margins & gutters):
  - **1-Up Establisher**: `1` bay at `(45, 45)`, `1830 × 990`
  - **2-Up Comparison**: `2` bays at `x = 45` and `x = 982.5`, each `892.5 × 990` — use for pure visual side-by-side comparisons (never straddle a floating white info pill across the center gutter)
  - **3-Up Pillars**: `3` bays at `x = 45, 670, 1295`, each `580 × 990`
  - **4-Up Grid (2×2)**: `4` bays (`892.5 × 472.5`) at `(45, 45)`, `(982.5, 45)`, `(45, 562.5)`, `(982.5, 562.5)` — align lower-corner white Info Pills cleanly to uniform `24 px` left/bottom bay insets
  - **50/50 Living Blue Split (Preferred for B-Roll + Copy)**: Left B-roll bay `(45, 45, 892.5 × 990)` + right open Living Blue canvas (`770 px` symmetrical measure `x = 1044..1814`) with optically centered (`y = 540`) pure oversized white `Inter-Bold` (`78–84 px`) headline and `36 px` balanced 3-line body copy — **no generic eyebrows or divider rules**
  - **Speaker Text Splits (`Icon List`, `Pull-Quote`, `Icon Headline`, `Big Stat`)**: Speaker framed with clean portrait headroom (`Scale 100–105%`) in one `892.5 × 990` Bento bay + pure oversized editorial typography directly on the opposite Living Blue half (`x = 1044..1814` Right / `x = 106..876` Left, optically centered on `y = 540`, zero eyebrows or divider lines): `76 px` quotes anchored by a `360 px` `“` watermark (`15%` white) + 2-line attribution (`38 px` Bold / `28 px` Regular); `76 px` Icon List headline + 3 rows with `84×84` `#FFFFFF` rounded badges (`r = 18 px`, royal-blue SVG icons) + `54 px` titles / `28 px` sub-copy; or `184 px` hero Big Stat KPIs
  - **Full-Bleed Statement**: Full `1920 × 1080` Living Blue gradient with centered editorial headline + subtitle
  - **Bookends (MANDATORY — Real Brand Stills Only)**:
    - **Frame 01 (Standard Intro)**: Pick 1 of the 3 official `Bumper IN` color options based on the video's visual tone and upload its real still from `resources/`: `bumper_in_white.png` (White logo on Living Blue), `bumper_in_blue.png` (Blue/White logo on Black), or `bumper_in_black.png` (Black logo on White).
    - **Final Frame(s) (REAL Sonic Ident)**: Always close with the real **Sonic Ident** (`STD ident` / `IDENT 2025 - Tail --2026 - Rev2.mov`), uploading `resources/sonic_ident_tile.png` (3D tile converge) and/or `resources/sonic_ident_lockup.png` (final lockup). Never substitute a fake text logo or generic CTA card for the Sonic Ident.

### Floating Overlays & Transitions
- **Stat / Callout Pill (HUG)**: White `#FFFFFF` pill (`cornerRadius: 14–16 px`, soft drop shadow), anchored inside the lower-left corner of its **own** bay (`24 px` left/bottom inset — never straddling across a multi-up gutter), containing:
  - Left **`44×44`–`48×48` royal-blue (`#1A6AFF`) rounded icon badge** (`cornerRadius: 10 px`) with a crisp **white SVG icon** from `ot-icons-library.onrender.com`
  - `Inter` **Bold** dark-navy (`#0D1B3E`) title + optional `Inter` **Regular** slate (`#4A5568`) subtitle
- **Lower Third (`L3 - Left 16x9`)**: Anchored near `(76, 836)` stacked **below** the white Bento `Border Frame`—white or Living Blue pill matching `OT Corp level brand package`, with `, OpenText` appended to internal speaker titles.
- **Physical Bento Transitions Only**: Note physical Bento matte transitions (`Frame Up`, `Frame Down`, `Slide Left`/`Slide Right`) between scenes rather than opacity crossfades. On single-camera speaker edits, schedule `1-Up`, `4-Up`, or `50/50 Split` B-roll beats across editorial jump cuts.
- **B-Roll Bay Placeholder / Preview**: Either a real extracted B-roll frame image (uploaded via `upload_assets` / image fill) or a clean pale-blue bay (`#E4ECFF`) with a subtle B-roll label centered or top-aligned so it never collides with floating pills.

### Explaining Text Footer (`x = 0, y = 1098, w = 1920, h = 83`)
Every board includes a 3-line metadata block below the `1920 × 1080` frame:
1. **Header** (`Inter Bold`, 20 px, `#111827`): `FRAME XX | M:SS.s – M:SS.s | Scene Title`
2. **VO** (`Inter Regular`, 16 px, `#374151`): `VO: "..."`
3. **Visual / B-Roll** (`Inter Regular`, 14 px, `#6B7280`): `Visual / B-Roll: [Bento layout + B-roll source/clip description + icon/overlay/transition notes]`

---

## Workflow

### Step 1: Script & Beat Sheet
1. Break the video into timed beats (typically `3.5–5.5 s` per Bento frame, starting with `Bumper IN` and ending with `Sonic Ident` or `Bumper OUT CTA`).
2. Assign each beat a Bento layout (`1-Up`, `2-Up`, `3-Up`, `4-Up`, `50/50 Split`, or `Statement`), VO line, B-roll concept, and icon keyword(s).

### Step 2: Source B-Roll from `@opentext` YouTube (When Requested)
1. Query `https://www.youtube.com/@opentext/videos` with `yt-dlp --flat-playlist --print "%(id)s | %(duration_string)s | %(title)s"` to find clean visual videos matching the script beats.
2. Download only the needed segments into `Assets/B-Roll/` using `yt-dlp` + `ffmpeg`, conformed to **30 fps** (`1920×1080`, H.264/ProRes) for seamless handoff to After Effects.
3. Extract a clean PNG poster frame per clip (`ffmpeg -ss ... -frames:v 1`) for embedding or visual reference in the Figma storyboard.

### Step 3: Fetch Official Icons from `ot-icons-library.onrender.com`
1. Follow [OT Icons Library Lookup](./references/ot-icons-library.md) to search `/data/icons-index.json` by keyword and fetch the exact `.svg` markup.
2. Normalize stroke/fill color to `#FFFFFF` (for blue icon badges) or `#1A6AFF` / `#000000` as needed, and insert into Figma via `figma.createNodeFromSvg(svgString)`.

### Step 4: Build & Verify in Figma
1. Load Figma MCP's `figma-use` guidance (`skill://figma/figma-use/SKILL.md`) before calling `use_figma`.
2. Call `whoami` to get the user's `planKey`, then `create_new_file` (`editorType: "design"`) unless the user gave an existing `fileKey`.
3. Build the full 3-column storyboard via `use_figma` (using `Inter` Regular / `Semi Bold` / `Bold`).
4. Call `get_screenshot` on the page and inspect visually for overlap, contrast, icon scaling, and readable footers.
5. Share the Figma link + summary for user sign-off **before** moving to `ot-brand-motion` in After Effects.
