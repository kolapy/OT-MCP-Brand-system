# OpenText Motion Brand System — Agent Instructions

This repository provides modular **OpenText motion graphics templates** (After Effects, 30 fps, zero third-party plugins) and **Bento storyboard assets** (Figma) for AI coding/creative agents.

## Available Skills (Agent Skills Open Standard)
Load the relevant skill from `.agents/skills/` before editing Figma or After Effects:
- **After Effects Production**: [`.agents/skills/ot-brand-motion/SKILL.md`](./.agents/skills/ot-brand-motion/SKILL.md) — uses `ae-motion` MCP with `Projects/Modules/OT_Corp_Brand_30fps.aep`, `Projects/Modules/OT_Bento_30fps.aep`, and `Projects/AE MCP Brand System.aep`.
- **Figma Bento Storyboarding**: [`.agents/skills/ot-storyboard-bento/SKILL.md`](./.agents/skills/ot-storyboard-bento/SKILL.md) — uses `figma` MCP, `ot-icons-library.onrender.com`, `@opentext` B-roll sourcing, and bundled official brand stills in `.agents/skills/ot-storyboard-bento/resources/`.
- **Multi-Cam Interview Cut & QA**: [`.agents/skills/interview-cut/SKILL.md`](./.agents/skills/interview-cut/SKILL.md) — project-agnostic multi-cam editing, per-segment acoustic sync, complementary audio ducking, Lumetri color continuity, zero-jump-cut audits, and orphan-free title / social-cut QA (`premiere-pro-mcp` + `ae-motion`).

## Non-Negotiable Rules
1. **30 fps everywhere** (`1920x1080` 16:9, `1080x1920` 9:16, `3840x2160` 4K).
2. **Never redraw or fake the OpenText logo** — use the real bundled brand stills in Figma and the real `Bumper IN` (White/Blue/Black) and `STD ident` (Sonic Ident) comps in After Effects.
3. **Never edit canonical templates in place** — import the needed module `.aep` into `_OT_Brand_Dependencies/` or `save_project` to a new file first.
4. **Zero third-party AE plugins** — use `Inter` typography and native AE expressions only.
