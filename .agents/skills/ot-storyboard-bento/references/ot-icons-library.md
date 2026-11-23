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

## Recoloring for Brand Use

Downloaded SVGs use black (`#000000` / `#000` / `currentColor`) strokes/fills by default:
- **White Icon on Royal-Blue Badge (`#1A6AFF`)**: Replace `#000000`, `#000`, and `currentColor` with `#FFFFFF` (or set stroke/fill color in Figma after `figma.createNodeFromSvg()`).
- **Royal Blue Icon on White Surface**: Replace with `#1A6AFF`.
- **After Effects Handoff**: Save downloaded SVGs into `Assets/Icons/` (or convert to clean high-res PNG / vector EPS/AI if importing directly into AE via `import_footage`).
