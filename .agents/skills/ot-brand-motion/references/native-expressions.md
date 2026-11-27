# Native AE Expressions (Zero-Plugin Brand Standard)

Use these native After Effects expressions when creating new text reveals, responsive pills/chips, or looping brand surfaces. Never reintroduce Animation Composer (`Pseudo/MHAC`) expressions.

---

## 1. Native OT Text Reveal — IN
Apply to a Text Layer's **Animator 1** (`Properties > Opacity = 0%`, `Range Selector 1 > Start = 0%`, `End = 100%`, `Advanced > Based On = Characters Excluding Spaces`, `Shape = Ramp Up`, `Smoothness = 100%`, `Mode = Add`).

Property path:
`["ADBE Text Properties", "ADBE Text Animators", 1, "ADBE Text Selectors", 1, "ADBE Text Percent Offset"]`

```javascript
// Native OT Text Reveal IN (reads "TR In" marker if present, else 0.5s from inPoint)
var tStart = inPoint;
var tEnd = inPoint + 0.5;
for (var i = 1; i <= marker.numKeys; i++) {
  if (marker.key(i).comment == "TR In") { tEnd = marker.key(i).time; break; }
}
easeOut(time, tStart, tEnd, -100, 100);
```

---

## 2. Native OT Text Reveal — OUT
Apply to **Animator 2** (`Properties > Opacity = 0%`, `Range Selector 1 > Start = 0%`, `End = 100%`, `Advanced > Based On = Characters Excluding Spaces`, `Shape = Ramp Up`, `Smoothness = 100%`, `Mode = Subtract`).

Property path:
`["ADBE Text Properties", "ADBE Text Animators", 2, "ADBE Text Selectors", 1, "ADBE Text Percent Offset"]`

```javascript
// Native OT Text Reveal OUT (reads "TR Out" marker if present, else 0.4s before outPoint)
var tStart = outPoint - 0.4;
var tEnd = outPoint;
for (var i = 1; i <= marker.numKeys; i++) {
  if (marker.key(i).comment == "TR Out") { tStart = marker.key(i).time; break; }
}
easeIn(time, tStart, tEnd, -100, 100);
```

---

## 3. Responsive Pill / Chip / Lower-Third Auto-Sizer (`sourceRectAtTime`)
Use on a Shape Layer's **Rectangle Size** to wrap a single text layer (`"Label"`) with brand padding:

```javascript
var padX = 48;
var padY = 24;
var r = thisComp.layer("Label").sourceRectAtTime(time, false);
[r.width + padX * 2, r.height + padY * 2];
```

And on the Shape Layer's **Position** (to stay centered on the text layer):

```javascript
var t = thisComp.layer("Label");
var r = t.sourceRectAtTime(time, false);
t.toComp([r.left + r.width / 2, r.top + r.height / 2]);
```

For two-line Lower Thirds (`Name` + `Title`), use the canonical horizontal right-edge tracker already on `L3 > BG`:

```javascript
var textLayer1 = thisComp.layer("Name");
var textLayer2 = thisComp.layer("Title");
var rect1 = textLayer1.sourceRectAtTime(time, false);
var rect2 = textLayer2.sourceRectAtTime(time, false);
var right1 = textLayer1.toComp([rect1.left + rect1.width, 0])[0];
var right2 = textLayer2.toComp([rect2.left + rect2.width, 0])[0];
var finalX = Math.max(right1, right2);
var offset = effect("Offset")("Slider");
[finalX + offset, value[1]];
```

---

## 4. Looping Background Motion (`4-Color Gradient`)
Apply to each animated `Point 1–4` on `ADBE 4ColorGradient` (with matching start/end keyframes):

```javascript
loopOut(type = "cycle", numKeyframes = 0);
```

---

## 5. Info Pill Clipping & Responsive Width (`Info Pill CTRL`)
Used across `Assets/Components/Info Pills/` for responsive rounded pills containing a Living Blue animated badge + continuously rasterized native AE vector icon:

1. **Always Create `Info Pill CTRL` Null First**: Add `Auto Width` (Checkbox), `Manual Width` (Slider), and `Right Padding` (Slider) to `Info Pill CTRL` *before* assigning any expressions that reference `thisComp.layer("Info Pill CTRL")` so AE never throws missing-layer expression errors.
2. **Track Matte + Continuous Rasterization (`☀`) Clipping Recipe**:
   - After Effects does **not** chain Track Mattes (`Living Blue → Pill_Badge` ignores `Pill_Badge → Pill_BG`), and precomp layers with `Collapse Transformations / Continuously Rasterize (☀)` **ignore** `Preserve Underlying Transparency (T)`.
   - **Correct Stack**:
     - Bottom layer: `Pill_BG` (white rounded rect, **no** internal Drop Shadow — apply `Drop Shadow` externally on the `Info Pill` precomp layer in the parent B-Roll comp).
     - `Living Blue`: Alpha Track Matte to `Pill_Badge` + **`Preserve Underlying Transparency (T)` ON**.
     - `Pill_Title` & `Pill_Sub`: **`Preserve Underlying Transparency (T)` ON**.
     - `Pill_Icon` (continuously rasterized `100×100` vector precomp): Apply `ic.setTrackMatte(bg, TrackMatteType.ALPHA)` AND **immediately restore `bg.enabled = true`** so the vector icon clips crisply inside `Pill_BG` without turning `Pill_BG` invisible.
