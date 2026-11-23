# OpenText Motion Brand System (After Effects + Figma + Premiere MCP)

A modular, zero-plugin, 30 fps OpenText motion graphics & Bento storyboarding system built on the **Agent Skills open standard** (`.agents/skills/` + `AGENTS.md`). Works across **Antigravity, Claude Code, Cursor, OpenAI Codex, Gemini CLI**, and any MCP-compatible AI client.

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
└── setup.sh                     # One-command skills + MCP server installer (macOS)
```

### Key Standards
- **Uniform 30 fps** across all 94 compositions (16:9 and 9:16).
- **Zero third-party plugins**: All Animation Composer (`Pseudo/MHAC`) text rigs have been replaced with native marker-aware AE expressions (`TR In` / `TR Out`).
- **Official Brand Bookends**: 3-color `Bumper IN` (`White` on Living Blue, `Blue` on Black, `Black` on White) + real 2026 `Sonic Ident` (`STD ident` with `OpenText_Mnemonic_Final_WAV.wav`).
- **Official Icons**: Direct SVG search & download from `ot-icons-library.onrender.com` (10,679 icons).

---

## Team Setup

### 1. Clone This Repo
```bash
git clone https://github.com/kolapy/OT-MCP-Brand-system.git
cd OT-MCP-Brand-system
```

### 2. Install Skills + Required MCP Servers
- **Skills only** (if you already have the MCPs installed):
  ```bash
  ./setup.sh
  ```
- **Full automated setup** (installs both global skills **and** clones/builds the After Effects & Premiere Pro MCP servers + CEP panels into `~/mcp-servers/`):
  ```bash
  ./setup.sh --install-mcps
  ```
  *(Pass `--all` to symlink skills into all agent folders: `~/.gemini`, `~/.claude`, `~/.codex`, `~/.cursor`.)*

---

## Required MCP Servers

This workflow uses **three MCP servers**:

| MCP Server | Source | Purpose | Install |
| :--- | :--- | :--- | :--- |
| **After Effects (`ae-motion`)** | [`dha-aa/ae-motion`](https://github.com/dha-aa/ae-motion) | Control After Effects comps, layers, text, expressions, previews, and renders | `./setup.sh --install-mcps` (or clone + `bash ./scripts/install.sh`, Windows: `./scripts/install.ps1`) |
| **Premiere Pro (`premiere-pro-mcp`)** | [`hetpatel-11/Adobe_Premiere_Pro_MCP`](https://github.com/hetpatel-11/Adobe_Premiere_Pro_MCP) | Edit sequences, assemble timelines, and bridge B-roll/cuts in Premiere Pro | `./setup.sh --install-mcps` (or clone + `npm install && npm run build && npm run setup:mac`, Windows: `npm run setup:win`) |
| **Figma (`figma`)** | Official Remote MCP (`https://mcp.figma.com/mcp`) | Build Bento storyboards, upload B-roll stills & OT SVGs, and take screenshots | **Antigravity**: Plugins Manager → install **Figma** & sign in<br>**Claude Code**: `claude mcp add --transport http figma https://mcp.figma.com/mcp`<br>**Cursor / Codex**: Add remote HTTP MCP URL `https://mcp.figma.com/mcp` |

### Required `AE_MCP_ALLOWED_DIRS` Setting
In your MCP config (`~/.gemini/antigravity/mcp_config.json`, Cursor `mcp.json`, Claude `~/.claude.json`, or Codex `config.toml`), set `AE_MCP_ALLOWED_DIRS` on `ae-motion` so After Effects can import the brand modules from **any** project (`setup.sh` prints your exact ready-to-paste JSON):

```json
"ae-motion": {
  "command": "node",
  "args": ["/Users/<you>/mcp-servers/ae-motion/dist/index.js"],
  "env": {
    "AE_MCP_ALLOWED_DIRS": "/path/to/OT-MCP-Brand-system:/Users/<you>"
  }
}
```

### Optional CLI Tools (for `@opentext` YouTube B-Roll & SVG Icons)
```bash
brew install yt-dlp ffmpeg librsvg
```

---

## Working in Parallel (Figma vs. After Effects)
- **Figma MCP (Remote)**: Works **100% headless** via Figma's cloud API—Figma Desktop does **not** need to be open, so you and the agent can work simultaneously.
- **After Effects (`ae-motion`) & Premiere Pro (`premiere-pro-mcp`)**: Require the Adobe app open with its MCP CEP panel docked (`Window → Extensions → AE Motion MCP` / Premiere MCP panel). You can freely work in other apps while the agent edits in the background, though two people/agents cannot edit two different projects in the same Adobe instance simultaneously.

---

## Usage Examples

- **Storyboard a Bento Video in Figma** (`ot-storyboard-bento`):
  > *"Create a 30-second Bento storyboard in Figma for OpenText Content Aviator using B-roll from @opentext and official OT icons."*
- **Animate in After Effects** (`ot-brand-motion`):
  > *"Animate our approved Figma storyboard in After Effects at 30 fps using the Bento and Corp Brand modules."*
- **Add Brand Elements Inside Any Existing AE Project**:
  > *"Add an OpenText Left Lower Third for 'Jane Doe — VP Engineering' and close with the Sonic Ident."*
  *(The agent automatically imports only the needed standalone `.aep` module from `Projects/Modules/` without closing your open project.)*
