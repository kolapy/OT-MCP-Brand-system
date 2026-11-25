# Color Continuity & Graphics QA

Use this module to ensure seamless color matching across all camera clips, eliminate typography orphans in intro bumpers, enforce clean lower-third standards across main vs. social edits, and avoid Premiere Pro `.mov` cache errors.

---

## 1. Color Correction Continuity (`Lumetri Color`)

Whenever a new or replaced clip is placed on `V1` or `V2` (e.g., during a jump-cut fix or sync rebuild):
1. Inspect an existing graded clip from the **same camera angle** using `list_clip_effects(clipId)`.
2. Extract all non-default `Lumetri Color` parameters (typically `Exposure`, `Contrast`, `Highlights`, `Shadows`, `Whites`, `Blacks`, `Temperature`, `Tint`, `Saturation`).
3. Apply those exact parameters to every newly placed clip of that camera angle via `apply_effect(clipId, effectName="Lumetri Color", parameters={...})`.
4. Verify `"success": true` on every clip so no shot jumps in brightness, contrast, or color balance when switching cameras.

---

## 2. Intro Titles & Typography QA (Zero Orphans)

1. **Zero orphan words (strict design rule)**:
   - Never leave a single word stranded alone on its own line in any intro bumper, title card, or CTA.
   - **Fix Option A (preferred when text barely wraps)**: Slightly reduce font `size` and `leading` via `set_text` while leaving `box_size` and 3D camera framing untouched, so the line fits cleanly on 1 line (or 2 balanced lines).
   - **Fix Option B (preferred for long headlines in a 2-tier hierarchy)**: Keep the headline `size` consistent with other videos in the series and insert a balanced manual line break (`\r`) so both headline lines have 2+ words, tightening `leading` slightly to keep the block cohesive.
   - **Important (`ae-motion` `set_text`)**: Passing new `text` clears per-range styling (`ranges_cleared: true`). Always pass `ranges` (e.g., `[{ match: "<subtitle>", font: "<RegularFont>", size: <subtitleSize> }]`) in the same `set_text` call.
2. **Consistent, minimal series formatting**:
   - Keep title formatting uniform across Main and Social clips in a series (e.g., `<Headline>` / `<Partner & Brand>`). Avoid redundant prefixes (`Partner Studio · `) or sub-vertical suffixes (` · Public Sector`) unless explicitly requested.
3. **Mandatory visual check**:
   - Run `preview_frame` at the mid-hold timestamp (e.g., `t=6.0s`) and inspect the rendered image before starting any full render.

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
