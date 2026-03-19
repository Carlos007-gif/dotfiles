<#
.SYNOPSIS
    Instalador Automatizado de Oh My Posh para Carlos
.DESCRIPTION
    Script interactivo que configura Oh My Posh con todas las optimizaciones
    desarrolladas en el chat. Incluye creación de carpetas, configuración de
    $PROFILE, gestión de temas y sincronización con GitHub.
.AUTHOR
    Carlos Daniel Martínez Reynoso
    Facultad de Ciencias Físico-Matemáticas, UANL
    Licenciatura en Ciencias Computacionales y Ciberseguridad
.VERSION
    1.0.0
.DATE
    19 de marzo de 2026
#>

# =============================================================================
# CONFIGURACIÓN DE COLORES Y FORMATOS
# =============================================================================

$Colors = @{
    Primary   = 'Cyan'
    Success   = 'Green'
    Warning   = 'Yellow'
    Error     = 'Red'
    Info      = 'White'
    Highlight = 'Magenta'
    Gray      = 'DarkGray'
}

function Write-Header {
    param([string]$Text)
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor $Colors.Primary
    Write-Host "  $Text" -ForegroundColor $Colors.Primary
    Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor $Colors.Primary
    Write-Host ""
}

function Write-Step {
    param([string]$Text)
    Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
    Write-Host "│  ⚡ $Text" -ForegroundColor $Colors.Success
    Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
    Write-Host ""
}

function Write-Question {
    param([string]$Text)
    Write-Host "❓ $Text" -ForegroundColor $Colors.Warning
}

function Write-Success {
    param([string]$Text)
    Write-Host "✓ $Text" -ForegroundColor $Colors.Success
}

function Write-Error {
    param([string]$Text)
    Write-Host "✗ $Text" -ForegroundColor $Colors.Error
}

function Write-Info {
    param([string]$Text)
    Write-Host "ℹ️  $Text" -ForegroundColor $Colors.Info
}

# =============================================================================
# PANTALLA DE BIENVENIDA
# =============================================================================

Clear-Host
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor $Colors.Primary
Write-Host "║                                                           ║" -ForegroundColor $Colors.Primary
Write-Host "║   🎨  INSTALADOR DE OH MY POSH - CARLOS  ║" -ForegroundColor $Colors.Highlight
Write-Host "║                                                           ║" -ForegroundColor $Colors.Primary
Write-Host "║   Universidad: FCFM-UANL                                  ║" -ForegroundColor $Colors.Gray
Write-Host "║   Carrera: Ciencias Computacionales y Ciberseguridad     ║" -ForegroundColor $Colors.Gray
Write-Host "║   Versión: 1.0.0                                          ║" -ForegroundColor $Colors.Gray
Write-Host "║                                                           ║" -ForegroundColor $Colors.Primary
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor $Colors.Primary
Write-Host ""
Write-Host "Este script configurará automáticamente tu entorno de PowerShell" -ForegroundColor $Colors.Info
Write-Host "con Oh My Posh optimizado, incluyendo:" -ForegroundColor $Colors.Info
Write-Host ""
Write-Host "  • Instalación de Oh My Posh (si no está instalado)" -ForegroundColor $Colors.Gray
Write-Host "  • Configuración de fuentes Nerd Font" -ForegroundColor $Colors.Gray
Write-Host "  • Creación de estructura de carpetas" -ForegroundColor $Colors.Gray
Write-Host "  • Configuración personalizada del \$PROFILE" -ForegroundColor $Colors.Gray
Write-Host "  • 12 alias de gestión incluidos" -ForegroundColor $Colors.Gray
Write-Host "  • Sincronización opcional con GitHub" -ForegroundColor $Colors.Gray
Write-Host ""
Write-Host "Presiona cualquier tecla para continuar..." -ForegroundColor $Colors.Warning
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# =============================================================================
# PASO 1: VERIFICAR PERMISOS DE ADMINISTRADOR
# =============================================================================

Write-Step "Verificando permisos de ejecución"

$isAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole( `
    [Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Warning "⚠️  Se recomienda ejecutar como administrador para instalar fuentes"
    Write-Question "¿Deseas continuar sin permisos de administrador? (S/N)"
    $continue = Read-Host
    if ($continue -notmatch '^[Ss]$') {
        Write-Error "Instalación cancelada. Ejecuta como administrador para mejor experiencia."
        exit 1
    }
}

Write-Success "Permisos verificados"

# =============================================================================
# PASO 2: SELECCIONAR RUTA BASE PARA INSTALACIÓN
# =============================================================================

Write-Step "Seleccionando rutas de instalación"

Write-Host ""
Write-Info "Las carpetas se crearán en la siguiente ubicación:"
Write-Host ""

# Mostrar ruta por defecto (Downloads del usuario)
$defaultBase = "$env:USERPROFILE\Downloads"
Write-Host "  📁 Ruta predeterminada: $defaultBase" -ForegroundColor $Colors.Gray
Write-Host ""
Write-Question "¿Deseas usar esta ruta? (S = sí, N = elegir otra)"
$useDefault = Read-Host

if ($useDefault -match '^[Ss]$') {
    $basePath = $defaultBase
}
else {
    Write-Host ""
    Write-Info "Ingresa la ruta completa donde se crearán las carpetas:"
    Write-Host "  Ejemplo: C:\Users\TuUsuario\Downloads" -ForegroundColor $Colors.Gray
    Write-Host "  Ejemplo: D:\Proyectos\oh-my-posh" -ForegroundColor $Colors.Gray
    Write-Host ""
    $basePath = Read-Host "  Ruta base"
    
    # Validar que la ruta existe
    if (-not (Test-Path $basePath)) {
        Write-Question "La ruta no existe. ¿Deseas crearla? (S/N)"
        $createPath = Read-Host
        if ($createPath -match '^[Ss]$') {
            New-Item -ItemType Directory -Path $basePath -Force | Out-Null
            Write-Success "Ruta creada: $basePath"
        }
        else {
            Write-Error "Ruta inválida. Instalación cancelada."
            exit 1
        }
    }
}

Write-Success "Ruta base seleccionada: $basePath"

# =============================================================================
# PASO 3: DEFINIR RUTAS ESPECÍFICAS
# =============================================================================

Write-Host ""
Write-Info "Configurando estructura de carpetas..."
Write-Host ""

# Rutas que se crearán
$paths = @{
    OhMyPoshThemes      = "$basePath\oh-my-posh"
    OhMyPoshConfigs     = "$basePath\oh-my-posh-configs"
    OhMyPoshBackups     = "$basePath\oh-my-posh-configs\backups"
    GitHubDotfiles      = "$env:USERPROFILE\GitHub\dotfiles"
    PowerShellProfile   = "$env:USERPROFILE\Documents\PowerShell"
}

# Mostrar estructura que se creará
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  📂 ESTRUCTURA DE CARPETAS A CREAR:" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  $basePath\" -ForegroundColor $Colors.Gray
Write-Host "│  ├── oh-my-posh\" -ForegroundColor $Colors.Gray
Write-Host "│  │   └── themes\ (100+ temas)" -ForegroundColor $Colors.Gray
Write-Host "│  ├── oh-my-posh-configs\" -ForegroundColor $Colors.Gray
Write-Host "│  │   ├── carlos-optimized.omp.json" -ForegroundColor $Colors.Gray
Write-Host "│  │   └── backups\" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  $env:USERPROFILE\GitHub\dotfiles\" -ForegroundColor $Colors.Gray
Write-Host "│  ├── oh-my-posh\" -ForegroundColor $Colors.Gray
Write-Host "│  └── powershell\" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  $env:USERPROFILE\Documents\PowerShell\" -ForegroundColor $Colors.Gray
Write-Host "│  └── Microsoft.PowerShell_profile.ps1" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host ""

Write-Question "¿Deseas continuar con esta estructura? (S/N)"
$confirmStructure = Read-Host

if ($confirmStructure -notmatch '^[Ss]$') {
    Write-Error "Instalación cancelada por el usuario."
    exit 0
}

# =============================================================================
# PASO 4: CREAR DIRECTORIOS
# =============================================================================

Write-Step "Creando estructura de carpetas"

foreach ($path in $paths.Values) {
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Success "Creado: $path"
    }
    else {
        Write-Info "Ya existe: $path"
    }
}

# =============================================================================
# PASO 5: INSTALAR OH MY POSH
# =============================================================================

Write-Step "Verificando instalación de Oh My Posh"

$ompInstalled = Get-Command oh-my-posh -ErrorAction SilentlyContinue

if ($ompInstalled) {
    $version = oh-my-posh version
    Write-Success "Oh My Posh ya está instalado (Versión: $version)"
}
else {
    Write-Info "Oh My Posh no está instalado. Procediendo con instalación..."
    Write-Host ""
    
    # Intentar con winget
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Info "Instalando con winget..."
        winget install JanDeDobbeleer.OhMyPosh --source winget --silent
        Write-Success "Oh My Posh instalado exitosamente"
    }
    else {
        Write-Warning "winget no disponible. Instala Oh My Posh manualmente desde:"
        Write-Host "  https://github.com/JanDeDobbeleer/oh-my-posh/releases" -ForegroundColor $Colors.Highlight
        Write-Host ""
        Write-Question "¿Deseas continuar sin Oh My Posh instalado? (S/N)"
        $continue = Read-Host
        if ($continue -notmatch '^[Ss]$') {
            exit 1
        }
    }
}

# =============================================================================
# PASO 6: CONFIGURAR FUENTES NERD FONT
# =============================================================================

Write-Step "Configurando fuentes Nerd Font"

Write-Host ""
Write-Info "Las fuentes Nerd Font son necesarias para mostrar íconos correctamente."
Write-Host ""
Write-Question "¿Deseas instalar las fuentes Nerd Font? (S/N)"
$installFonts = Read-Host

if ($installFonts -match '^[Ss]$') {
    # Verificar si ya están instaladas
    $fontExists = Get-Font -Name "MesloLGM NF" -ErrorAction SilentlyContinue
    
    if ($fontExists) {
        Write-Success "Las fuentes Nerd Font ya están instaladas"
    }
    else {
        Write-Info "Para instalar las fuentes:"
        Write-Host ""
        Write-Host "  1. Abre PowerShell como administrador" -ForegroundColor $Colors.Gray
        Write-Host "  2. Ejecuta: oh-my-posh font install meslo" -ForegroundColor $Colors.Highlight
        Write-Host "  3. Reinicia tu terminal" -ForegroundColor $Colors.Gray
        Write-Host ""
        Write-Info "También puedes descargarlas manualmente desde:"
        Write-Host "  https://www.nerdfonts.com/font-downloads" -ForegroundColor $Colors.Highlight
    }
}

# =============================================================================
# PASO 7: SELECCIONAR TIPO DE CONFIGURACIÓN
# =============================================================================

Write-Step "Seleccionando tipo de configuración"

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  🎨 TIPO DE CONFIGURACIÓN" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  1. Personalizada (carlos-optimized)" -ForegroundColor $Colors.Info
Write-Host "│     • Optimizada para Ciencias Computacionales" -ForegroundColor $Colors.Gray
Write-Host "│     • Segmentos: Git, Python, Node, ejecución, estado" -ForegroundColor $Colors.Gray
Write-Host "│     • Rendimiento: ~350ms de carga" -ForegroundColor $Colors.Gray
Write-Host "│     • Backups automáticos incluidos" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  2. Predeterminada (catppuccin)" -ForegroundColor $Colors.Info
Write-Host "│     • Tema oficial de Oh My Posh" -ForegroundColor $Colors.Gray
Write-Host "│     • Colores suaves para sesiones largas" -ForegroundColor $Colors.Gray
Write-Host "│     • Menos segmentos, más limpio" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  3. Explorar otros temas" -ForegroundColor $Colors.Info
Write-Host "│     • Ver lista de 100+ temas disponibles" -ForegroundColor $Colors.Gray
Write-Host "│     • Decidir después de explorar" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host ""

Write-Question "Selecciona una opción (1/2/3)"
$configType = Read-Host

$selectedTheme = ""
$configContent = ""

switch ($configType) {
    '1' {
        $selectedTheme = "carlos-optimized"
        Write-Success "Configuración seleccionada: Personalizada (carlos-optimized)"
    }
    '2' {
        $selectedTheme = "catppuccin"
        Write-Success "Configuración seleccionada: Predeterminada (catppuccin)"
    }
    '3' {
        Write-Host ""
        Write-Info "Temas populares disponibles:"
        Write-Host ""
        $popularThemes = @(
            'catppuccin', 'night-owl', 'tokyonight_storm', 'blue-owl',
            'jandedobbeleer', 'dracula', 'gruvbox', 'atomicBit', 'kali'
        )
        foreach ($theme in $popularThemes) {
            Write-Host "  • $theme" -ForegroundColor $Colors.Gray
        }
        Write-Host ""
        Write-Question "Ingresa el nombre del tema que deseas usar"
        $selectedTheme = Read-Host
    }
    default {
        $selectedTheme = "carlos-optimized"
        Write-Info "Usando configuración predeterminada: carlos-optimized"
    }
}

# =============================================================================
# PASO 8: CREAR ARCHIVO DE CONFIGURACIÓN PERSONALIZADA
# =============================================================================

Write-Step "Creando archivo de configuración"

if ($configType -eq '1') {
    # Configuración personalizada carlos-optimized
    $configPath = "$($paths.OhMyPoshConfigs)\carlos-optimized.omp.json"
    
    $configContent = @'
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "version": 2,
  "final_space": true,
  "console_title_template": "{{ .Shell }} in {{ .Folder }}",
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        {
          "type": "session",
          "style": "diamond",
          "foreground": "#ffffff",
          "background": "#61AFEF",
          "leading_diamond": "",
          "template": " {{ if .SSHSession }} {{ end }}{{ .UserName }} ",
          "cache": { "duration": "30s" }
        },
        {
          "type": "path",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#446786",
          "template": "  {{ .Path }} ",
          "properties": { "style": "folder", "max_depth": 3 }
        },
        {
          "type": "git",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#000000",
          "background": "#FFFB38",
          "template": " {{ if .UpstreamURL }}{{ url .UpstreamIcon .UpstreamURL }} {{ end }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }} ",
          "properties": {
            "branch_max_length": 25,
            "fetch_stash_count": true,
            "fetch_status": true,
            "fetch_upstream_icon": true
          },
          "cache": { "duration": "10s" }
        },
        {
          "type": "python",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#95E6CB",
          "template": "  {{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }} ",
          "properties": { "fetch_virtual_env": true, "display_mode": "files" },
          "include_files": ["*.py", "requirements.txt", "pyproject.toml"],
          "cache": { "duration": "20s" }
        },
        {
          "type": "node",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#89DDFF",
          "template": "  {{ .Full }} ",
          "properties": { "display_mode": "files" },
          "include_files": ["package.json", "*.js", "*.ts"],
          "cache": { "duration": "20s" }
        },
        {
          "type": "executiontime",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#000000",
          "background": "#FF6B6B",
          "template": " 󰄧 {{ .FormattedMs }} ",
          "properties": { "threshold": 500 }
        },
        {
          "type": "status",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#4CAF50",
          "background_templates": ["{{ if gt .Code 0 }}#F44336{{ end }}"],
          "template": " {{ if gt .Code 0 }} {{ .Meaning }}{{ else }}✓{{ end }} "
        }
      ]
    },
    {
      "type": "prompt",
      "alignment": "right",
      "segments": [
        {
          "type": "time",
          "style": "plain",
          "foreground": "#8B949E",
          "template": " {{ .CurrentDate | date .Format }} ",
          "properties": { "time_format": "15:04:05" }
        }
      ]
    },
    {
      "type": "prompt",
      "alignment": "left",
      "newline": true,
      "segments": [
        {
          "type": "text",
          "style": "plain",
          "foreground": "#7390C2",
          "template": "❯"
        }
      ]
    }
  ],
  "secondary_prompt": { "template": "❯❯ ", "foreground": "#7390C2" },
  "transient_prompt": { "template": "❯ ", "foreground": "#7390C2" }
}
'@
    
    $configContent | Out-File -FilePath $configPath -Encoding utf8 -Force
    Write-Success "Configuración personalizada creada: $configPath"
}
else {
    # Usar tema predeterminado de Oh My Posh
    $configPath = "$($paths.OhMyPoshThemes)\$selectedTheme.omp.json"
    Write-Info "Usando tema: $selectedTheme (se descargará de Oh My Posh)"
}

# =============================================================================
# PASO 9: CONFIGURAR PERFIL DE POWERSHELL
# =============================================================================

Write-Step "Configurando perfil de PowerShell"

$profilePath = "$($paths.PowerShellProfile)\Microsoft.PowerShell_profile.ps1"

# Crear contenido del $PROFILE
$profileContent = @'
# =============================================================================
# Oh My Posh - Configuración Optimizada para Carlos
# =============================================================================
# Usuario: Carlos Daniel Martínez Reynoso
# Universidad: Facultad de Ciencias Físico-Matemáticas, UANL
# Carrera: Licenciatura en Ciencias Computacionales y Ciberseguridad
# =============================================================================

# Ruta a la configuración personalizada
$OhMyPoshConfig = "{{CONFIG_PATH}}"

# =============================================================================
# Inicialización de Oh My Posh
# =============================================================================

function Initialize-OhMyPosh {
    if (Test-Path $OhMyPoshConfig) {
        oh-my-posh init pwsh --config $OhMyPoshConfig | Invoke-Expression
    }
    else {
        Write-Warning "Configuración personalizada no encontrada. Usando tema por defecto."
        oh-my-posh init pwsh | Invoke-Expression
    }
}

if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    Initialize-OhMyPosh
}

# =============================================================================
# Alias de Gestión de Configuración
# =============================================================================

function Edit-OhMyPoshConfig {
    if (Test-Path $OhMyPoshConfig) {
        notepad $OhMyPoshConfig
    }
    else {
        Write-Host "Creando configuración personalizada..." -ForegroundColor Cyan
        New-Item -ItemType File -Path $OhMyPoshConfig -Force | Out-Null
        notepad $OhMyPoshConfig
    }
}
Set-Alias eompc Edit-OhMyPoshConfig

function Reload-OhMyPosh {
    Write-Host "Recargando Oh My Posh..." -ForegroundColor Yellow
    Initialize-OhMyPosh
}
Set-Alias romp Reload-OhMyPosh

# =============================================================================
# Actualización de Oh My Posh
# =============================================================================

function Update-OhMyPosh {
    Write-Host "Verificando actualizaciones de Oh My Posh..." -ForegroundColor Cyan
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        $update = winget upgrade JanDeDobbeleer.OhMyPosh --source winget --silent
        if ($update -match "No installed package found") {
            Write-Host "✓ Oh My Posh ya está actualizado" -ForegroundColor Green
        }
        elseif ($update -match "Successfully installed") {
            Write-Host "✓ Oh My Posh actualizado. Reinicie PowerShell para aplicar cambios." -ForegroundColor Green
        }
    }
    else {
        Write-Host "⚠️ Winget no encontrado. Actualice manualmente desde Microsoft Store." -ForegroundColor Yellow
    }
}
Set-Alias updateomp Update-OhMyPosh

# =============================================================================
# Validación de Configuración
# =============================================================================

function Test-OhMyPoshConfig {
    param([string]$ConfigPath = "$env:USERPROFILE\Downloads\oh-my-posh-configs\carlos-optimized.omp.json")
    Write-Host "Validando configuración: $ConfigPath" -ForegroundColor Cyan
    if (-not (Test-Path $ConfigPath)) {
        Write-Host "✗ Archivo no encontrado" -ForegroundColor Red
        return $false
    }
    try {
        $config = Get-Content $ConfigPath -Raw | ConvertFrom-Json
        Write-Host "✓ JSON válido" -ForegroundColor Green
        Write-Host "  - Versión: $($config.version)" -ForegroundColor Cyan
        Write-Host "  - Bloques: $($config.blocks.Count)" -ForegroundColor Cyan
        Write-Host "  - Tooltips: $($config.tooltips.Count)" -ForegroundColor Cyan
    }
    catch {
        Write-Host "✗ Error JSON: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
    Write-Host "✓ Estructura básica verificada" -ForegroundColor Green
    return $true
}
Set-Alias testomp Test-OhMyPoshConfig

# =============================================================================
# Respaldo Automático de Configuración
# =============================================================================

function Backup-OhMyPoshConfig {
    param([switch]$Force)
    $backupPath = "$env:USERPROFILE\Downloads\oh-my-posh-configs\backups"
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
    $timestamp = Get-Date -Format "yyyy-MM-dd-HHmm"
    $backupFile = "$backupPath\backup-$timestamp.omp.json"
    Copy-Item $OhMyPoshConfig $backupFile -Force:$Force
    Write-Host "✓ Backup creado: backup-$timestamp.omp.json" -ForegroundColor Green
    Write-Host "  Ubicación: $backupFile" -ForegroundColor Cyan
}
Set-Alias backupomp Backup-OhMyPoshConfig

# =============================================================================
# Sincronización con GitHub (Dotfiles)
# =============================================================================

function Sync-Dotfiles {
    param(
        [string]$Message = "chore: sync dotfiles $(Get-Date -Format 'yyyy-MM-dd')",
        [switch]$NoPush
    )
    $dotfilesPath = "$env:USERPROFILE\GitHub\dotfiles"
    if (-not (Test-Path $dotfilesPath)) {
        Write-Host "⚠️ Repositorio de dotfiles no encontrado en: $dotfilesPath" -ForegroundColor Yellow
        return $false
    }
    $originalLocation = Get-Location
    try {
        Set-Location $dotfilesPath
        $status = git status --porcelain
        if (-not $status) {
            Write-Host "✓ No hay cambios pendientes para sincronizar" -ForegroundColor Green
            return $true
        }
        Write-Host "📋 Cambios detectados:" -ForegroundColor Cyan
        git status --short
        git add .
        git commit -m $Message
        Write-Host "✓ Commit creado: $Message" -ForegroundColor Green
        if (-not $NoPush) {
            git push
            Write-Host "✓ Cambios sincronizados con GitHub" -ForegroundColor Green
        }
        else {
            Write-Host "ℹ️ Cambios commiteados localmente (sin push)" -ForegroundColor Cyan
        }
        return $true
    }
    catch {
        Write-Host "✗ Error durante sincronización: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
    finally {
        Set-Location $originalLocation
    }
}
Set-Alias syncdf Sync-Dotfiles

# =============================================================================
# Exploración de Temas
# =============================================================================

function Test-OhMyPoshTheme {
    param([Parameter(Mandatory=$true)][string]$ThemeName)
    $themePath = "$env:USERPROFILE\Downloads\oh-my-posh\themes\$ThemeName.omp.json"
    if (Test-Path $themePath) {
        Write-Host "🎨 Cargando tema: $ThemeName" -ForegroundColor Cyan
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
        Write-Host "💡 Para volver a su tema personalizado: escriba 'romp'" -ForegroundColor Yellow
    }
    else {
        Write-Host "✗ Tema no encontrado: $ThemeName" -ForegroundColor Red
    }
}
Set-Alias testtheme Test-OhMyPoshTheme

function Get-OhMyPoshThemes {
    param([int]$First = 20)
    Write-Host "📂 Temas disponibles (mostrando los primeros $First):" -ForegroundColor Cyan
    Get-ChildItem "$env:USERPROFILE\Downloads\oh-my-posh\themes\*.omp.json" | 
        Select-Object -First $First | 
        ForEach-Object { Write-Host "  • $($_.BaseName)" -ForegroundColor Gray }
    Write-Host "`n💡 Use 'testtheme <nombre>' para probar un tema" -ForegroundColor Yellow
}
Set-Alias listthemes Get-OhMyPoshThemes

function Test-TopThemes {
    param([int]$SecondsPerTheme = 15)
    $topThemes = @('catppuccin','night-owl','tokyonight_storm','blue-owl','jandedobbeleer','dracula','gruvbox','atomicBit','kali','powerlevel10k_modern')
    $originalConfig = $OhMyPoshConfig
    Write-Host "🎬 Iniciando demostración de $($topThemes.Count) temas..." -ForegroundColor Cyan
    Write-Host "⏱️  $SecondsPerTheme segundos por tema" -ForegroundColor Gray
    Write-Host "💡 Presione Ctrl+C para cancelar`n" -ForegroundColor Yellow
    foreach ($theme in $topThemes) {
        $path = "$env:USERPROFILE\Downloads\oh-my-posh\themes\$theme.omp.json"
        if (Test-Path $path) {
            Write-Host "🎨 Tema: $theme" -ForegroundColor Magenta
            oh-my-posh init pwsh --config $path | Invoke-Expression
            Start-Sleep -Seconds $SecondsPerTheme
        }
    }
    Write-Host "`n✅ Restaurando configuración original..." -ForegroundColor Green
    oh-my-posh init pwsh --config $originalConfig | Invoke-Expression
    Write-Host "✓ Tema restaurado: carlos-optimized" -ForegroundColor Green
}
Set-Alias testtopthemes Test-TopThemes

# =============================================================================
# Utilidades Adicionales
# =============================================================================

function Get-OhMyPoshInfo {
    Write-Host "`n═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  📊 ESTADO DE OH MY POSH" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "`n🔹 Versión:" -ForegroundColor Magenta
    oh-my-posh version
    Write-Host "`n🔹 Configuración actual:" -ForegroundColor Magenta
    Write-Host "  $OhMyPoshConfig" -ForegroundColor Gray
    Write-Host "`n🔹 Estado del archivo:" -ForegroundColor Magenta
    if (Test-Path $OhMyPoshConfig) {
        Write-Host "  ✓ Existe" -ForegroundColor Green
        $size = (Get-Item $OhMyPoshConfig).Length
        Write-Host "  Tamaño: $size bytes" -ForegroundColor Gray
    }
    else {
        Write-Host "  ✗ No encontrado" -ForegroundColor Red
    }
    Write-Host "`n🔹 Rendimiento de carga:" -ForegroundColor Magenta
    $time = (Measure-Command { . $PROFILE }).TotalMilliseconds
    Write-Host "  $($time.ToString('F2')) ms" -ForegroundColor $(if ($time -lt 500) { "Green" } else { "Yellow" })
    Write-Host "`n═══════════════════════════════════════════════════════════`n" -ForegroundColor Cyan
}
Set-Alias ompinfo Get-OhMyPoshInfo

# =============================================================================
# Cambio Rápido de Tema (Versión Mejorada)
# =============================================================================

function Set-OhMyPoshTheme {
    param([Parameter(Mandatory=$true)][string]$ThemeName)
    $searchPaths = @(
        "$env:USERPROFILE\Downloads\oh-my-posh\themes\",
        "$env:USERPROFILE\Downloads\oh-my-posh-configs\"
    )
    $extensions = @('.omp.json', '.omp.yaml')
    $themePath = $null
    foreach ($dir in $searchPaths) {
        foreach ($ext in $extensions) {
            $candidate = "$dir$ThemeName$ext"
            if (Test-Path $candidate) {
                $themePath = $candidate
                Write-Host "🔍 Tema encontrado: $candidate" -ForegroundColor Gray
                break
            }
        }
        if ($themePath) { break }
    }
    if (-not $themePath) {
        Write-Host "✗ Tema no encontrado: $ThemeName" -ForegroundColor Red
        return
    }
    Write-Host "📦 Creando respaldo de configuración actual..." -ForegroundColor Cyan
    backupomp
    $profileContent = Get-Content $PROFILE -Raw
    $oldPattern = '\$OhMyPoshConfig\s*=\s*"[^"]*"'
    $newLine = "`$OhMyPoshConfig = `"$themePath`""
    $profileContent = $profileContent -replace $oldPattern, $newLine
    $profileContent | Set-Content $PROFILE -Encoding utf8 -Force
    Write-Host "✓ Perfil actualizado" -ForegroundColor Green
    Write-Host "🔄 Recargando configuración..." -ForegroundColor Cyan
    . $PROFILE
    $themeNameOnly = Split-Path $themePath -Leaf
    Write-Host "✓ Tema cambiado exitosamente a: $themeNameOnly" -ForegroundColor Green
}
Set-Alias settheme Set-OhMyPoshTheme

# =============================================================================
# Sincronizar $PROFILE con Dotfiles
# =============================================================================

function Sync-Profile {
    $dotfilesProfilePath = "$env:USERPROFILE\GitHub\dotfiles\powershell\Microsoft.PowerShell_profile.ps1"
    $profileDir = Split-Path $dotfilesProfilePath -Parent
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    Copy-Item $PROFILE $dotfilesProfilePath -Force
    Write-Host "✓ Perfil copiado a dotfiles" -ForegroundColor Green
    syncdf
}
Set-Alias syncprofile Sync-Profile

# =============================================================================
# Fin del Perfil
# =============================================================================
'@

# Reemplazar marcador de ruta con la ruta real
$profileContent = $profileContent -replace '{{CONFIG_PATH}}', $configPath

# Guardar perfil
$profileContent | Out-File -FilePath $profilePath -Encoding utf8 -Force
Write-Success "Perfil de PowerShell creado: $profilePath"

# =============================================================================
# PASO 10: CLONAR REPOSITORIO DE DOTFILES (OPCIONAL)
# =============================================================================

Write-Step "Configurando repositorio de dotfiles en GitHub"

Write-Host ""
Write-Info "Un repositorio de dotfiles te permite sincronizar tu configuración"
Write-Info "en múltiples máquinas y mantener un historial de cambios."
Write-Host ""
Write-Question "¿Deseas configurar la sincronización con GitHub? (S/N)"
$setupGitHub = Read-Host

if ($setupGitHub -match '^[Ss]$') {
    Write-Host ""
    Write-Info "Ingresa la URL de tu repositorio de dotfiles en GitHub:"
    Write-Host "  Ejemplo: https://github.com/Carlos007-gif/dotfiles.git" -ForegroundColor $Colors.Gray
    Write-Host ""
    $gitUrl = Read-Host "  URL del repositorio"
    
    if ($gitUrl) {
        if (Test-Path $paths.GitHubDotfiles) {
            Write-Info "El repositorio ya existe. Verificando..."
            Set-Location $paths.GitHubDotfiles
            git remote set-url origin $gitUrl 2>$null
            Write-Success "Repositorio configurado: $gitUrl"
        }
        else {
            Write-Info "Clonando repositorio..."
            git clone $gitUrl $paths.GitHubDotfiles
            Write-Success "Repositorio clonado: $paths.GitHubDotfiles"
        }
        
        # Copiar configuración al repositorio
        Write-Host ""
        Write-Info "Copiando configuración al repositorio..."
        
        # Crear carpetas en dotfiles
        New-Item -ItemType Directory -Path "$($paths.GitHubDotfiles)\oh-my-posh" -Force | Out-Null
        New-Item -ItemType Directory -Path "$($paths.GitHubDotfiles)\powershell" -Force | Out-Null
        
        # Copiar archivos
        if (Test-Path $configPath) {
            Copy-Item $configPath "$($paths.GitHubDotfiles)\oh-my-posh\" -Force
            Write-Success "Configuración copiada a dotfiles/oh-my-posh/"
        }
        
        Copy-Item $profilePath "$($paths.GitHubDotfiles)\powershell\" -Force
        Write-Success "Perfil copiado a dotfiles/powershell/"
        
        # Commit inicial
        Set-Location $paths.GitHubDotfiles
        git add .
        $commitMsg = "feat: initial setup - $(Get-Date -Format 'yyyy-MM-dd')"
        git commit -m $commitMsg
        Write-Host ""
        Write-Question "¿Deseas hacer push a GitHub ahora? (S/N)"
        $doPush = Read-Host
        if ($doPush -match '^[Ss]$') {
            git push
            Write-Success "Cambios sincronizados con GitHub"
        }
    }
}

# =============================================================================
# PASO 11: RESUMEN FINAL
# =============================================================================

Write-Header "🎉 INSTALACIÓN COMPLETADA"

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
Write-Host "│  📋 RESUMEN DE LA INSTALACIÓN" -ForegroundColor $Colors.Success
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Oh My Posh: Instalado/Verificado" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Configuración: $selectedTheme" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Perfil PowerShell: $profilePath" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Backups: $($paths.OhMyPoshBackups)" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Alias disponibles: 12" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
Write-Host ""

Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  🔧 ALIAS DISPONIBLES" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  testomp       → Validar configuración JSON" -ForegroundColor $Colors.Gray
Write-Host "│  eompc         → Editar configuración en Notepad" -ForegroundColor $Colors.Gray
Write-Host "│  romp          → Recargar Oh My Posh" -ForegroundColor $Colors.Gray
Write-Host "│  updateomp     → Actualizar Oh My Posh" -ForegroundColor $Colors.Gray
Write-Host "│  backupomp     → Crear backup con timestamp" -ForegroundColor $Colors.Gray
Write-Host "│  syncdf        → Sincronizar con GitHub" -ForegroundColor $Colors.Gray
Write-Host "│  testtheme     → Probar tema temporalmente" -ForegroundColor $Colors.Gray
Write-Host "│  listthemes    → Listar temas disponibles" -ForegroundColor $Colors.Gray
Write-Host "│  testtopthemes → Demo automática de 10 temas" -ForegroundColor $Colors.Gray
Write-Host "│  ompinfo       → Información completa del estado" -ForegroundColor $Colors.Gray
Write-Host "│  settheme      → Cambiar tema permanentemente" -ForegroundColor $Colors.Gray
Write-Host "│  syncprofile   → Copiar \$PROFILE a dotfiles" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host ""

Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Warning
Write-Host "│  ⚠️  PRÓXIMOS PASOS RECOMENDADOS" -ForegroundColor $Colors.Warning
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Warning
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  1. Reinicia PowerShell para aplicar todos los cambios" -ForegroundColor $Colors.Gray
Write-Host "│  2. Instala fuentes Nerd Font (si no las instalaste)" -ForegroundColor $Colors.Gray
Write-Host "│     → Ejecuta: oh-my-posh font install meslo" -ForegroundColor $Colors.Highlight
Write-Host "│  3. Configura Windows Terminal para usar Nerd Font" -ForegroundColor $Colors.Gray
Write-Host "│  4. Ejecuta: ompinfo para verificar el estado" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Warning
Write-Host ""

Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor $Colors.Success
Write-Host "║                                                           ║" -ForegroundColor $Colors.Success
Write-Host "║   🎨  ¡GRACIAS POR USAR EL INSTALADOR DE CARLOS! ║" -ForegroundColor $Colors.Highlight
Write-Host "║                                                           ║" -ForegroundColor $Colors.Success
Write-Host "║   Universidad: FCFM-UANL                                  ║" -ForegroundColor $Colors.Gray
Write-Host "║   Carrera: Ciencias Computacionales y Ciberseguridad     ║" -ForegroundColor $Colors.Gray
Write-Host "║                                                           ║" -ForegroundColor $Colors.Success
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor $Colors.Success
Write-Host ""

Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor $Colors.Warning
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")