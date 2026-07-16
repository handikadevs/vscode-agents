# =============================================================================
# vscode-agents — One-liner installer (Windows PowerShell)
#
# Usage:
#   iwr -Uri https://raw.githubusercontent.com/handikadevs/vscode-agents/main/install.ps1 | iex
#   Or locally: .\install.ps1
# =============================================================================

$ErrorActionPreference = "Stop"

$REPO_URL = "https://github.com/handikadevs/vscode-agents.git"
$TMP_DIR = Join-Path $env:TEMP "vscode-agents-$(Get-Random)"

try {
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "  VS Code Multi-Agent System — Installer (Windows)" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "↻ Downloading vscode-agents..." -ForegroundColor Cyan
    git clone --depth 1 $REPO_URL $TMP_DIR

    Write-Host "↻ Installing..." -ForegroundColor Cyan
    & "$TMP_DIR\scripts\install-agent-skills.ps1"

    Write-Host ""
    Write-Host "✓ Done! Restart VS Code to activate all agents." -ForegroundColor Green
    Write-Host ""
} finally {
    if (Test-Path $TMP_DIR) {
        Remove-Item -Recurse -Force $TMP_DIR
    }
}
