#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS=("ot-brand-motion" "ot-storyboard-bento" "interview-cut")
MCP_DIR="${OT_MCP_DIR:-$HOME/mcp-servers}"

INSTALL_ALL_AGENTS=false
INSTALL_MCPS=false

for arg in "$@"; do
  case "$arg" in
    --all) INSTALL_ALL_AGENTS=true ;;
    --install-mcps) INSTALL_MCPS=true ;;
    -h|--help)
      echo "Usage: ./setup.sh [--all] [--install-mcps]"
      echo "  --all           Install skills into all agent dirs (~/.gemini, ~/.claude, ~/.codex, ~/.cursor)"
      echo "  --install-mcps  Clone, build, and install CEP panels for ae-motion and premiere-pro-mcp into $MCP_DIR"
      exit 0
      ;;
  esac
done

echo "=== 1. Installing OpenText Motion Brand System Skills ==="
echo "Repo: $REPO_ROOT"
echo ""

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

  if [[ -d "$PARENT" || "$INSTALL_ALL_AGENTS" == true ]]; then
    mkdir -p "$DIR"
    for skill in "${SKILLS[@]}"; do
      ln -sfn "$REPO_ROOT/.agents/skills/$skill" "$DIR/$skill"
    done
    echo "✓ Installed skills for $LABEL -> $DIR"
    INSTALLED=$((INSTALLED + 1))
  fi
done

if [[ "$INSTALLED" -eq 0 ]]; then
  echo "No global agent config directories detected (~/.gemini, ~/.claude, ~/.codex, ~/.cursor)."
  echo "Run './setup.sh --all' to create them, or open this repo directly as a workspace (.agents/skills/ is auto-discovered)."
fi

if [[ "$INSTALL_MCPS" == true ]]; then
  echo ""
  echo "=== 2. Installing Required MCP Servers into $MCP_DIR ==="
  mkdir -p "$MCP_DIR"

  # After Effects MCP (dha-aa/ae-motion)
  if [[ -d "$MCP_DIR/ae-motion/.git" ]]; then
    echo "• Updating ae-motion..."
    git -C "$MCP_DIR/ae-motion" pull --ff-only
  else
    echo "• Cloning ae-motion (After Effects MCP)..."
    git clone https://github.com/dha-aa/ae-motion.git "$MCP_DIR/ae-motion"
  fi
  (cd "$MCP_DIR/ae-motion" && bash ./scripts/install.sh)

  # Premiere Pro MCP (hetpatel-11/Adobe_Premiere_Pro_MCP)
  if [[ -d "$MCP_DIR/Adobe_Premiere_Pro_MCP/.git" ]]; then
    echo "• Updating Adobe_Premiere_Pro_MCP..."
    git -C "$MCP_DIR/Adobe_Premiere_Pro_MCP" pull --ff-only
  else
    echo "• Cloning Adobe_Premiere_Pro_MCP (Premiere Pro MCP)..."
    git clone https://github.com/hetpatel-11/Adobe_Premiere_Pro_MCP.git "$MCP_DIR/Adobe_Premiere_Pro_MCP"
  fi
  (cd "$MCP_DIR/Adobe_Premiere_Pro_MCP" && npm install && npm run build && npm run setup:mac)

  echo ""
  echo "✓ Installed ae-motion and premiere-pro-mcp!"
else
  echo ""
  echo "Tip: Run './setup.sh --install-mcps' to automatically clone, build, and install the"
  echo "     After Effects (ae-motion) and Premiere Pro (premiere-pro-mcp) MCP servers."
fi

AE_INDEX="$MCP_DIR/ae-motion/dist/index.js"
PR_INDEX="$MCP_DIR/Adobe_Premiere_Pro_MCP/dist/index.js"

echo ""
echo "=== 3. MCP Config Snippet (Antigravity mcp_config.json / Cursor mcp.json / Claude) ==="
cat <<EOF
{
  "mcpServers": {
    "ae-motion": {
      "command": "node",
      "args": ["$AE_INDEX"],
      "env": {
        "AE_MCP_ALLOWED_DIRS": "$REPO_ROOT:$HOME"
      }
    },
    "premiere-pro-mcp": {
      "command": "node",
      "args": ["$PR_INDEX"],
      "env": {
        "PREMIERE_TEMP_DIR": "/tmp/premiere-mcp-bridge"
      }
    },
    "figma": {
      "url": "https://mcp.figma.com/mcp"
    }
  }
}
EOF
echo ""
echo "Figma MCP note:"
echo "  • Antigravity: Install 'Figma' from Plugins Manager and sign in."
echo "  • Claude Code: claude mcp add --transport http figma https://mcp.figma.com/mcp"
echo "  • Cursor / Codex: Add the 'figma' remote HTTP URL above and complete OAuth sign-in."
echo ""
echo "Restart/refresh your MCP client after updating config, and you're ready to go!"
