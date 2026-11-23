#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.gemini/config/skills"

echo "Installing OpenText Motion Brand System skills from:"
echo "  $REPO_ROOT"
echo ""

mkdir -p "$SKILLS_DIR"
ln -sfn "$REPO_ROOT/.agents/skills/ot-brand-motion" "$SKILLS_DIR/ot-brand-motion"
ln -sfn "$REPO_ROOT/.agents/skills/ot-storyboard-bento" "$SKILLS_DIR/ot-storyboard-bento"

echo "✓ Symlinked global skills:"
echo "  - $SKILLS_DIR/ot-brand-motion"
echo "  - $SKILLS_DIR/ot-storyboard-bento"
echo ""
echo "Next step: add this env block to your 'ae-motion' server in ~/.gemini/antigravity/mcp_config.json"
echo "(so After Effects MCP can import the brand modules from any project):"
echo ""
echo '  "env": {'
echo "    \"AE_MCP_ALLOWED_DIRS\": \"$REPO_ROOT:$HOME\""
echo '  }'
echo ""
echo "Then restart/refresh your ae-motion MCP server and you're ready to go!"
