# Setup for Ciencia Fora de Controle project on Windows.
#
# Installs 3 skills into %USERPROFILE%\.claude\skills\, runs EL4CTEO
# official installer (symlinks for 28 sub-skills), optionally prepares
# Blender MCP. Reversible.
#
# Usage:
#   cd $HOME\Documents\CienciaForaDeControle
#   powershell -ExecutionPolicy Bypass -File .\scripts\setup_windows.ps1
#
# Options:
#   -SkipMcp         Skip uv/blender-mcp install
#   -Reinstall       Remove ~/.claude/skills/{blender-skills,3d-animator-skill,
#                    claude-animation-skill} before cloning

param(
    [switch]$SkipMcp,
    [switch]$Reinstall
)

$ErrorActionPreference = "Stop"

function Info($msg) { Write-Host "[setup] $msg" -ForegroundColor Cyan }
function Ok($msg)   { Write-Host "[ ok ] $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "[warn] $msg" -ForegroundColor Yellow }
function Die($msg)  { Write-Host "[fail] $msg" -ForegroundColor Red; exit 1 }

# --- 1. Prereqs ---
Info "checking prerequisites"
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Die "git not found. Install it first."
}
Ok "git available"
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Warn "claude CLI not found. Install later with: npm install -g @anthropic-ai/claude-code"
} else {
    Ok "claude CLI available"
}

# --- 2. Skills dir ---
$skillsDir = Join-Path $HOME ".claude\skills"
if (-not (Test-Path $skillsDir)) {
    New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null
    Ok "created $skillsDir"
}

# --- 3. Clone the 3 skills ---
$repos = @(
    @{ url = "https://github.com/EL4CTEO/blender-skills.git";                     dir = "blender-skills" },
    @{ url = "https://github.com/studioigor/3d-animator-skill.git";               dir = "3d-animator-skill" },
    @{ url = "https://github.com/DisturbedMediaGroup/claude-animation-skill.git"; dir = "claude-animation-skill" }
)

foreach ($r in $repos) {
    $target = Join-Path $skillsDir $r.dir
    if ($Reinstall -and (Test-Path $target)) {
        Info "removing (reinstall) $target"
        Remove-Item -Recurse -Force $target
    }
    if (Test-Path $target) {
        Info "$($r.dir) already present, updating"
        git -C $target pull --ff-only 2>&1 | Out-Null
    } else {
        Info "cloning $($r.url)"
        git clone --depth 1 $r.url $target
    }
    Ok "$($r.dir) ready"
}

# --- 4. Run EL4CTEO official installer ---
$installer = Join-Path $skillsDir "blender-skills\install\install.ps1"
if (Test-Path $installer) {
    Info "running EL4CTEO installer (symlinks for 28 sub-skills)"
    $ok = $false
    try {
        & $installer --agent claude --scope user
        $ok = $true
    } catch {
        Warn "install.ps1 failed. Likely needs admin to create symlinks on Windows."
        Warn "Options:"
        Warn "  A) Reopen PowerShell as Administrator and rerun this script"
        Warn "  B) Enable Developer Mode (Settings - Privacy and security - For developers)"
        Warn "  C) Copy instead of symlink: & '$installer' --agent claude --scope user --copy"
    }
    if ($ok) { Ok "28 blender-* sub-skills linked under $skillsDir" }
} else {
    Warn "EL4CTEO installer not found at $installer"
}

# --- 5. Blender MCP (optional) ---
if (-not $SkipMcp) {
    Info "checking uv (python package runner used by blender-mcp)"
    if (-not (Get-Command uvx -ErrorAction SilentlyContinue)) {
        Info "installing uv"
        try {
            Invoke-RestMethod https://astral.sh/uv/install.ps1 | Invoke-Expression
            Ok "uv installed"
        } catch {
            Warn "auto-install of uv failed. Install manually from https://docs.astral.sh/uv/"
        }
    } else {
        Ok "uv already available"
    }

    Info "Blender MCP manual steps:"
    Write-Host "    1. In a new PowerShell: uvx blender-mcp (leave it running)"
    Write-Host "    2. In another PowerShell inside the project:"
    Write-Host "       claude mcp add blender-mcp -- uvx blender-mcp"
    Write-Host "    3. In Blender 5.3: Edit then Preferences then Add-ons, find 'Blender MCP', enable it."
    Write-Host "       If not present, get the add-on from the same blender-mcp project page."
}

# --- 6. Summary ---
Info "=== summary ==="
Get-ChildItem $skillsDir -Directory | Select-Object Name | Format-Table
Info "to start a local Claude Code session:"
Write-Host "    cd $HOME\Documents\CienciaForaDeControle"
Write-Host "    claude"
Write-Host ""
Info "first message to paste into the local session:"
Write-Host "    Read STATUS.md and docs/DIRECAO_ARTE.md, then run scripts/smoke_test.py"
