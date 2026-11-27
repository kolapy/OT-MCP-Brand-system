# OT Icons Library Lookup (`ot-icons-library.onrender.com`)

OpenText's Creative Services VideOS Icon Library hosts **10,679 official SVG icons** with a public JSON search index.

- **Web UI**: `https://ot-icons-library.onrender.com/?q=<query>&color=%23000000`
- **Index JSON**: `https://ot-icons-library.onrender.com/data/icons-index.json`
- **SVG Base URL**: `https://ot-icons-library.onrender.com<icon.path>`

---

## Quick Search Script (CLI / Python)

Search icons by keyword and download the matching SVG:

```bash
python3 -c '
import json, urllib.request, sys
q = sys.argv[1].lower()
data = json.loads(urllib.request.urlopen("https://ot-icons-library.onrender.com/data/icons-index.json").read())
hits = [ic for ic in data["icons"] if q in ic.get("searchText", "").lower()]
print(f"Found {len(hits)} matches for {q!r}:")
for ic in hits[:8]:
    print(f"  {ic[\"displayName\"]} -> https://ot-icons-library.onrender.com{ic[\"path\"]}")
' "cloud"
```

---

## Recoloring & Native AE Vector Handoff (Zero External Icon Dependencies)

Downloaded SVGs use black (`#000000` / `#000` / `currentColor`) strokes/fills by default:
- **Figma**: Replace `#000000`, `#000`, and `currentColor` with `#FFFFFF` (white on Living Blue / Royal Blue badge) or `#1A6AFF` (Royal Blue on white) after `figma.createNodeFromSvg()`.
- **After Effects (MANDATORY — SVG → Native AE Vector Shape Layer)**: **Always prioritize SVG and convert SVG `<path>` geometry directly into native AE Vector Shape Layers** (`ADBE Vector Shape - Group` + `ADBE Vector Graphic - Stroke` with Round Cap/Join inside a `100×100` comp with `collapseTransformation = true` enabled) so every icon lives **100% natively inside the `.aep` with zero external PNG/SVG disk dependencies** and infinite vector resolution. Do **not** rasterize icons to external PNGs when SVGs are available.
