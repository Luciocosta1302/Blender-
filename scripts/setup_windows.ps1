# Setup do projeto Ciência Fora de Controle no Windows.
#
# Instala as 3 skills em %USERPROFILE%\.claude\skills\, roda o installer
# oficial do EL4CTEO (symlinks das 28 sub-skills), opcionalmente prepara
# Blender MCP. Reversível.
#
# Uso:
#   # Primeiro, abrir PowerShell como ADMIN uma vez para permitir symlinks:
#   #   Start-Process powershell -Verb RunAs
#   # Depois:
#   cd $HOME\Documents\CienciaForaDeControle
#   powershell -ExecutionPolicy Bypass -File .\scripts\setup_windows.ps1
#
# Opções:
#   -SkipMcp         Pula instalação do uv/blender-mcp
#   -Reinstall       Remove ~/.claude/skills/{blender-skills,3d-animator-skill,
#                    claude-animation-skill} antes de clonar

param(
    [switch]$SkipMcp,
    [switch]$Reinstall
)

$ErrorActionPreference = "Stop"

function Info($msg) { Write-Host "[setup] $msg" -ForegroundColor Cyan }
function Ok($msg)   { Write-Host "[ ok ] $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "[warn] $msg" -ForegroundColor Yellow }
function Die($msg)  { Write-Host "[fail] $msg" -ForegroundColor Red; exit 1 }

# --- 1. Pré-requisitos ---
Info "verificando pré-requisitos"
foreach ($cmd in @("git", "claude")) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        if ($cmd -eq "claude") {
            Warn "claude CLI não encontrado. Instale com: npm install -g @anthropic-ai/claude-code"
        } else {
            Die "$cmd não encontrado. Instale antes de continuar."
        }
    }
}
Ok "git disponível"

# --- 2. Diretório das skills ---
$skillsDir = Join-Path $HOME ".claude\skills"
if (-not (Test-Path $skillsDir)) {
    New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null
    Ok "criado $skillsDir"
}

# --- 3. Clonar as 3 skills ---
$repos = @(
    @{ url = "https://github.com/EL4CTEO/blender-skills.git";              dir = "blender-skills" },
    @{ url = "https://github.com/studioigor/3d-animator-skill.git";        dir = "3d-animator-skill" },
    @{ url = "https://github.com/DisturbedMediaGroup/claude-animation-skill.git"; dir = "claude-animation-skill" }
)

foreach ($r in $repos) {
    $target = Join-Path $skillsDir $r.dir
    if ($Reinstall -and (Test-Path $target)) {
        Info "removendo (reinstall) $target"
        Remove-Item -Recurse -Force $target
    }
    if (Test-Path $target) {
        Info "$($r.dir) já presente, atualizando"
        git -C $target pull --ff-only 2>&1 | Out-Null
    } else {
        Info "clonando $($r.url)"
        git clone --depth 1 $r.url $target
    }
    Ok "$($r.dir) pronto"
}

# --- 4. Rodar installer oficial do EL4CTEO (cria symlinks das 28 sub-skills) ---
$installer = Join-Path $skillsDir "blender-skills\install\install.ps1"
if (Test-Path $installer) {
    Info "rodando installer oficial do EL4CTEO (symlinks das 28 skills)"
    try {
        & $installer --agent claude --scope user
        Ok "28 sub-skills blender-* linkadas em $skillsDir"
    } catch {
        Warn "install.ps1 falhou — possivelmente precisa de admin para criar symlinks."
        Warn "alternativa 1: reabrir PowerShell como administrador e rodar novamente"
        Warn "alternativa 2: executar '& `"$installer`" --agent claude --scope user --copy' (copia em vez de linkar)"
    }
} else {
    Warn "installer do EL4CTEO não encontrado em $installer"
}

# --- 5. Blender MCP (opcional) ---
if (-not $SkipMcp) {
    Info "verificando uv (gerenciador Python usado pelo blender-mcp)"
    if (-not (Get-Command uvx -ErrorAction SilentlyContinue)) {
        Info "instalando uv"
        try {
            Invoke-RestMethod https://astral.sh/uv/install.ps1 | Invoke-Expression
            Ok "uv instalado"
        } catch {
            Warn "falhou instalar uv automaticamente. Instale manualmente: https://docs.astral.sh/uv/"
        }
    } else {
        Ok "uv já disponível"
    }

    Info "próximos passos manuais do Blender MCP:"
    Write-Host "    1. Em um PowerShell novo:  uvx blender-mcp" -ForegroundColor White
    Write-Host "       (deixe esse terminal rodando enquanto usar o Claude)" -ForegroundColor White
    Write-Host "    2. Em outro PowerShell dentro deste projeto:" -ForegroundColor White
    Write-Host "       claude mcp add blender-mcp -- uvx blender-mcp" -ForegroundColor White
    Write-Host "    3. No Blender 5.3: Edit > Preferences > Add-ons > procure 'Blender MCP' > enable" -ForegroundColor White
    Write-Host "       (se não existir, baixe o add-on do mesmo repo blender-mcp)" -ForegroundColor White
}

# --- 6. Sumário ---
Info "=== resumo ==="
Get-ChildItem $skillsDir -Directory | Select-Object Name | Format-Table
Info "para iniciar:"
Write-Host "    cd $HOME\Documents\CienciaForaDeControle" -ForegroundColor White
Write-Host "    claude" -ForegroundColor White
Write-Host ""
Info "primeira pergunta para a sessão local:"
Write-Host "    'Leia docs/DIRECAO_ARTE.md e STATUS.md e rode scripts\smoke_test.py'" -ForegroundColor White
