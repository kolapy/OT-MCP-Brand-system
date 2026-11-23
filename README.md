# OpenText Motion Brand System (After Effects + Figma MCP)

A modular, zero-plugin, 30 fps OpenText motion graphics & Bento storyboarding system built on the **Agent Skills open standard** (`.agents/skills/` + `AGENTS.md`). Works across **Antigravity, Claude Code, Cursor, OpenAI Codex, Gemini CLI**, and any MCP-compatible AI client using **`ae-motion` MCP** (Adobe After Effects) and **`figma` MCP** (Figma).

---

## Repository Structure

```text
├── AGENTS.md                    # Universal cross-agent instructions
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
└── setup.sh                     # Cross-platform global skill installer (Antigravity, Claude Code, Codex, Cursor)
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
   git clone https://github.com/kolapy/OT-MCP-Brand-system.git
   cd OT-MCP-Brand-system
   ```
2. **Install both skills globally** (auto-detects Antigravity, Claude Code, Codex, and Cursor; pass `--all` to install for all):
   ```bash
   chmod +x setup.sh && ./setup.sh
   ```
   *(Any tool that reads workspace `.agents/skills/` or `AGENTS.md` also discovers them automatically without running `setup.sh`.)*
3. **Configure `AE_MCP_ALLOWED_DIRS`** in your MCP client config under `ae-motion` (using the exact path printed by `./setup.sh`), then restart/refresh your `ae-motion` MCP server.

---

## Working in Parallel (Figma vs. After Effects)
- **Figma MCP (Remote)**: Works **100% headless** via Figma's cloud API—Figma Desktop does **not** need to be open, so you and the agent can work simultaneously.
- **After Effects MCP (`ae-motion`)**: Requires **After Effects open** with `Window → Extensions → AE Motion MCP` docked. You can freely work in other apps (Figma, Premiere, Resolve, browser) while the agent animates in AE in the background, though two people/agents cannot edit two different projects in the same AE instance simultaneously.

---

## Usage Examples

- **Storyboard a Bento Video in Figma** (`ot-storyboard-bento`):
  > *"Create a 30-second Bento storyboard in Figma for OpenText Content Aviator using B-roll from @opentext and official OT icons."*
- **Animate in After Effects** (`ot-brand-motion`):
  > *"Animate our approved Figma storyboard in After Effects at 30 fps using the Bento and Corp Brand modules."*
- **Add Brand Elements Inside Any Existing AE Project**:
  > *"Add an OpenText Left Lower Third for 'Jane Doe — VP Engineering' and close with the Sonic Ident."*
  *(The agent automatically imports only the needed standalone `.aep` module from `Projects/Modules/` without closing your open project.)*
