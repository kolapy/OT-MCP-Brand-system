#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS=("ot-brand-motion" "ot-storyboard-bento")

echo "Installing OpenText Motion Brand System skills from:"
echo "  $REPO_ROOT"
echo ""

# Universal Agent Skills directories across AI platforms
TARGETS=(
  "Antigravity / Gemini CLI|$HOME/.gemini/config/skills"
  "Claude Code|$HOME/.claude/skills"
  "OpenAI Codex|$HOME/.codex/skills"
  "Cursor|$HOME/.cursor/skills"
)

INSTALLED=0
for entry in "${TARGETS[@]}"; do
  LABEL="${entry%%|*}"
  DIR="${entry##*|}"
  PARENT="$(dirname "$DIR")"

  # Install if the tool's config root exists, OR if --all is passed
  if [[ -d "$PARENT" || "${1:-}" == "--all" ]]; then
    mkdir -p "$DIR"
    for skill in "${SKILLS[@]}"; do
      ln -sfn "$REPO_ROOT/.agents/skills/$skill" "$DIR/$skill"
    done
    echo "✓ Installed for $LABEL -> $DIR"
    INSTALLED=$((INSTALLED + 1))
  fi
done

if [[ "$INSTALLED" -eq 0 ]]; then
  echo "No global agent config directories detected (~/.gemini, ~/.claude, ~/.codex, ~/.cursor)."
  echo "Run './setup.sh --all' to create them, or open this repo directly as a workspace (.agents/skills/ is auto-discovered)."
fi

echo ""
echo "Next step: add this env block to your 'ae-motion' MCP server config"
echo "(Antigravity mcp_config.json, Claude Code ~/.claude.json, Cursor mcp.json, or Codex config.toml):"
echo ""
echo '  "env": {'
echo "    \"AE_MCP_ALLOWED_DIRS\": \"$REPO_ROOT:$HOME\""
echo '  }'
echo ""
echo "Then restart/refresh your ae-motion MCP server and you're ready to go!"
