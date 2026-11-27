# Color Continuity & Graphics QA

Use this module to ensure seamless color matching across all camera clips, eliminate typography orphans in intro bumpers, enforce clean lower-third standards across main vs. social edits, and avoid Premiere Pro `.mov` cache errors.

---

## 1. Color Correction Continuity & B-Roll `~80 IRE` Matching (`Lumetri Color`)

### Multi-Cam Angle Continuity
Whenever a new or replaced clip is placed on `V1` or `V2` (e.g., during a jump-cut fix or sync rebuild):
1. Inspect an existing graded clip from the **same camera angle** using `list_clip_effects(clipId)`.
2. Extract all non-default `Lumetri Color` parameters (typically `Exposure`, `Contrast`, `Highlights`, `Shadows`, `Whites`, `Blacks`, `Temperature`, `Tint`, `Saturation`).
3. Apply those exact parameters to every newly placed clip of that camera angle via `apply_effect(clipId, effectName="Lumetri Color", parameters={...})`.
4. Verify `"success": true` on every clip so no shot jumps in brightness, contrast, or color balance when switching cameras.

### Live-Action B-Roll Exposure (`~80 IRE`) & A-Cam Match
Whenever live-action B-roll cuts over an interview:
1. Measure Rec.709 luma percentiles (`p5`, `p50`, `p99` in IRE) and mid-highlight RGB balance on rendered frames of the A-cam interview alongside every B-roll shot.
2. Apply per-shot native **`Lumetri Color`** (placed **before** any `Drop Shadow` effect in AE) so every live-action B-roll clip hits **`~80 IRE` peak highlights** (`p99 ≈ 79–82 IRE`), matched midtone density (`p50 ≈ 32–37 IRE`), open non-crushed shadows, and neutral-warm white balance/skin tones matching A-cam (neutralizing fluorescent cyan-green office casts without pushing neutral white ceilings magenta).
3. Keep dark-mode screen/UI captures legible with lighter contrast/highlight tuning rather than lifting UI darks to live-action levels.

---

## 2. Intro Titles, Split Callouts & Typography QA (Zero Orphans)

1. **Zero orphan words (strict design rule)**:
   - Never leave a single word stranded alone on its own line in any intro bumper, title card, pull-quote, split body block, or CTA.
   - **Fix Option A (preferred when text barely wraps)**: Slightly reduce font `size` and `leading` via `set_text` while leaving `box_size` and 3D camera framing untouched, so the line fits cleanly on 1 line (or 2 balanced lines).
   - **Fix Option B (preferred for long headlines in a 2-tier hierarchy)**: Keep the headline `size` consistent with other videos in the series and insert a balanced manual line break (`\r`) so both headline lines have 2+ words, tightening `leading` slightly to keep the block cohesive.
   - **Important (`ae-motion` `set_text`)**: Passing new `text` clears per-range styling (`ranges_cleared: true`). Always pass `ranges` (e.g., `[{ match: "<subtitle>", font: "<RegularFont>", size: <subtitleSize> }]`) in the same `set_text` call, and use real newline characters (not escaped literal `\r`).
2. **Pull-Quote Stagger, Attribution Clearance & Optical Centering**:
   - Keep eyebrow-to-quote entrance staggers tight (**`0.25–0.35 s`**) so an eyebrow never hangs alone on screen before the quote arrives.
   - Place speaker attributions (`— Full Name`) on a separate layer **`55–65 px` below** the quote's closing line (e.g., `36 px` gap + subtle accent divider + `24 px` gap) so the name never crowds descenders.
   - Optically center the entire split text group's measured visual bounding box on **`y = 540`**.
3. **Consistent, minimal series formatting**:
   - Keep title formatting uniform across Main and Social clips in a series (e.g., `<Headline>` / `<Partner & Brand>`). Avoid redundant prefixes (`Partner Studio · `) or sub-vertical suffixes (` · Public Sector`) unless explicitly requested.
4. **Mandatory visual check**:
   - Run `preview_frame` across entrances, mid-holds, and splits and inspect the rendered image before starting any full render.

---

## 3. Lower Thirds (L3) & Social Cut Rules

1. **Full verified names and titles**:
   - Never leave placeholder first-name-only or company-only text on an L3.
   - Confirm or research the speaker's full name, role, and company, and match a single consistent formatting pattern across all speakers in the edit (e.g., `<Role>, <Company>`).
2. **No L3s on social cutdowns**:
   - Keep lower thirds on the **main full-length interview only**.
   - Strip all L3 clips from social cutdown sequences (`remove_from_timeline(..., deleteMode="lift")`) so social clips stay clean: `Intro Bumper → Interview Clip → Closer Ident`.

---

## 4. Sequential Alpha Rendering & Premiere Cache Hygiene

1. **Render sequentially on external/shared drives**:
   - Run **1 `aerender` job at a time** when writing to external/SMB drives to prevent `Can not create a file in directory` write-lock errors.
   - Always render intros and lower thirds with an alpha-capable output module (`om_template: "High Quality with Alpha"`, ProRes 4444 `yuva444p12le`).
2. **Verify rendered `.mov` integrity**:
   - Confirm `render_status` returns `state: "done"`, `exit_code: 0`, and `output_exists: true`.
3. **Avoid Premiere Pro stale-header decode errors**:
   - Overwriting a `.mov` in place while Premiere Pro has the project open often causes Premiere to hold stale byte offsets and throw frame-decode errors.
   - Either:
     - **Option A**: Remind the user to right-click the clip in the Project panel → **Make Offline…** (*Media Files Remain on Disk*) → **Link Media…** (or save, close, and reopen the `.prproj`), OR
     - **Option B**: Render to a versioned filename (`_v2.mov`) so the user can use **Replace Footage…** cleanly without closing the project.
