#!/usr/bin/env bash
# =============================================================================
# vscode-agents — One-liner installer (Mac & Ubuntu)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/handikadevs/vscode-agents/main/install.sh | bash
#   Or locally: ./install.sh
# =============================================================================

set -euo pipefail

REPO_URL="https://github.com/handikadevs/vscode-agents.git"
TMP_DIR=$(mktemp -d)

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo ""
echo "============================================================"
echo "  VS Code Multi-Agent System — Installer"
echo "============================================================"
echo ""

# Clone repo to temp
echo "↻ Downloading vscode-agents..."
git clone --depth 1 "$REPO_URL" "$TMP_DIR"

# Run the full install script
echo "↻ Installing..."
bash "$TMP_DIR/scripts/install-agent-skills.sh"

echo ""
echo "✓ Done! Restart VS Code to activate all agents."
echo ""
