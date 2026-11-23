# OpenText Motion Brand System (After Effects + Figma MCP)

A modular, zero-plugin, 30 fps OpenText motion graphics & Bento storyboarding system built for AI-assisted production with **Antigravity**, **`ae-motion` MCP** (Adobe After Effects), and **`figma` MCP** (Figma).

---

## Repository Structure

```text
├── .agents/skills/
│   ├── ot-brand-motion/         # After Effects animation skill (tokens, catalog, native expressions)
│   └── ot-storyboard-bento/     # Figma Bento Storyboard skill + bundled real brand stills & OT Icons lookup
├── Assets/
│   └── Brand_Footage/           # Minimal collected footage for Corp Brand module (~42 MB total)
├── Projects/
│   ├── AE MCP Brand System.aep  # Combined deduplicated 30 fps master (16 MB)
│   └── Modules/
│       ├── OT_Corp_Brand_30fps.aep  # Standalone Corp Brand Package (14 MB, 16:9 & 9:16)
│       └── OT_Bento_30fps.aep       # Standalone Bento Module (2.4 MB, zero external footage)
└── setup.sh                     # One-command global skill installer for teammates
```

### Key Standards
- **Uniform 30 fps** across all 94 compositions (16:9 and 9:16).
- **Zero third-party plugins**: All Animation Composer (`Pseudo/MHAC`) text rigs have been replaced with native marker-aware AE expressions (`TR In` / `TR Out`).
- **Official Brand Bookends**: 3-color `Bumper IN` (`White` on Living Blue, `Blue` on Black, `Black` on White) + real 2026 `Sonic Ident` (`STD ident` with `OpenText_Mnemonic_Final_WAV.wav`).
- **Official Icons**: Direct SVG search & download from `ot-icons-library.onrender.com` (10,679 icons).

---

## Team Setup (30 Seconds)

1. **Clone this repo** anywhere on your machine:
   ```bash
   git clone <YOUR_GITHUB_REPO_URL>
   cd <repo-folder>
   ```
2. **Install both skills globally** (symlinks into `~/.gemini/config/skills/`):
   ```bash
   chmod +x setup.sh && ./setup.sh
   ```
3. **Configure `AE_MCP_ALLOWED_DIRS`** in `~/.gemini/antigravity/mcp_config.json` under your `ae-motion` server (using the exact path printed by `./setup.sh`), then restart/refresh `ae-motion` MCP.

---

## Usage Examples

- **Storyboard a Bento Video in Figma** (`ot-storyboard-bento`):
  > *"Create a 30-second Bento storyboard in Figma for OpenText Content Aviator using B-roll from @opentext and official OT icons."*
- **Animate in After Effects** (`ot-brand-motion`):
  > *"Animate our approved Figma storyboard in After Effects at 30 fps using the Bento and Corp Brand modules."*
- **Add Brand Elements Inside Any Existing AE Project**:
  > *"Add an OpenText Left Lower Third for 'Jane Doe — VP Engineering' and close with the Sonic Ident."*
  *(The agent automatically imports only the needed standalone `.aep` module from `Projects/Modules/` without closing your open project.)*
