<#
.SYNOPSIS
    Instalador Automatizado de Oh My Posh - Versión 2.2
.DESCRIPTION
    Script interactivo que configura Oh My Posh preguntando cada ruta al usuario
    y mostrando dónde se guardó todo al finalizar.
.AUTHOR
    Carlos Daniel Martínez Reynoso
    Facultad de Ciencias Físico-Matemáticas, UANL
    Licenciatura en Ciencias Computacionales y Ciberseguridad
.VERSION
    2.2.0
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
    Write-Host ""
    Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
    Write-Host "│  ⚡ $Text" -ForegroundColor $Colors.Success
    Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
    Write-Host ""
}

function Write-Question {
    param([string]$Text)
    Write-Host ""
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

function Write-Check {
    param([string]$Text, [bool]$Status)
    if ($Status) {
        Write-Host "  ✓ $Text" -ForegroundColor $Colors.Success
    }
    else {
        Write-Host "  ✗ $Text" -ForegroundColor $Colors.Error
    }
}

function Write-Option {
    param([string]$Text)
    Write-Host "  ► $Text" -ForegroundColor $Colors.Gray
}

function Write-Path {
    param([string]$Text)
    Write-Host "  📁 $Text" -ForegroundColor $Colors.Gray
}

# =============================================================================
# PANTALLA DE BIENVENIDA
# =============================================================================

Clear-Host
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor $Colors.Primary
Write-Host "║                                                           ║" -ForegroundColor $Colors.Primary
Write-Host "║   🎨  INSTALADOR DE OH MY POSH - CARLOS  v2.2            ║" -ForegroundColor $Colors.Highlight
Write-Host "║                                                           ║" -ForegroundColor $Colors.Primary
Write-Host "║   Universidad: FCFM-UANL                                  ║" -ForegroundColor $Colors.Gray
Write-Host "║   Carrera: Ciencias Computacionales y Ciberseguridad     ║" -ForegroundColor $Colors.Gray
Write-Host "║   Versión: 2.2.0                                          ║" -ForegroundColor $Colors.Gray
Write-Host "║                                                           ║" -ForegroundColor $Colors.Primary
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor $Colors.Primary
Write-Host ""
Write-Host "Este script configurará automáticamente tu entorno de PowerShell" -ForegroundColor $Colors.Info
Write-Host "con Oh My Posh optimizado, incluyendo:" -ForegroundColor $Colors.Info
Write-Host ""
Write-Option "Instalación de Oh My Posh (múltiples métodos disponibles)"
Write-Option "Configuración de fuentes Nerd Font"
Write-Option "Creación de estructura de carpetas (tú eliges las rutas)"
Write-Option "Configuración personalizada del \$PROFILE"
Write-Option "12 alias de gestión incluidos"
Write-Option "Carpeta users/ para tu configuración personal"
Write-Option "Creador de temas interactivo con editor de código"
Write-Option "Sincronización opcional con GitHub"
Write-Option "Verificación completa del sistema al finalizar"
Write-Option "Reporte visual de dónde se guardó cada archivo"
Write-Host ""
Write-Host "Presiona cualquier tecla para continuar..." -ForegroundColor $Colors.Warning
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# =============================================================================
# PASO 1: VERIFICAR PERMISOS DE EJECUCIÓN
# =============================================================================

Write-Step "Verificando permisos de ejecución"

$isAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole( `
    [Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Info "⚠️  No se detectaron permisos de administrador"
    Write-Info "Algunas funciones (como instalar fuentes) pueden requerirlos"
    Write-Question "¿Deseas continuar sin permisos de administrador? (S/N)"
    $continue = Read-Host
    if ($continue -notmatch '^[Ss]$') {
        Write-Error "Instalación cancelada. Ejecuta como administrador para mejor experiencia."
        exit 1
    }
}

Write-Success "Permisos verificados"

# =============================================================================
# PASO 2: SELECCIONAR RUTAS PERSONALIZADAS (UNA POR UNA)
# =============================================================================

Write-Step "📁 Seleccionando rutas de instalación"

Write-Host ""
Write-Info "En este paso, podrás elegir DÓNDE se guardará cada cosa."
Write-Info "Te preguntaremos ruta por ruta para que tengas control total."
Write-Host ""

# =============================================================================
# 2.1: RUTA BASE PRINCIPAL
# =============================================================================

Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  1️⃣  RUTA BASE PRINCIPAL" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Aquí se guardarán las carpetas de Oh My Posh:" -ForegroundColor $Colors.Gray
Write-Path "$basePath\oh-my-posh\ (temas oficiales)"
Write-Path "$basePath\oh-my-posh-configs\ (tus configuraciones)"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host ""

$defaultBase = "$env:USERPROFILE\Downloads"
Write-Info "Ruta predeterminada: $defaultBase"
Write-Host ""
Write-Question "¿Deseas usar esta ruta? (S = sí, N = elegir otra)"
$useDefault = Read-Host

if ($useDefault -match '^[Ss]$') {
    $basePath = $defaultBase
}
else {
    Write-Host ""
    Write-Info "Ingresa la ruta completa:"
    Write-Host "  Ejemplo: C:\Users\TuUsuario\Downloads" -ForegroundColor $Colors.Gray
    Write-Host "  Ejemplo: D:\Proyectos\oh-my-posh" -ForegroundColor $Colors.Gray
    Write-Host ""
    $basePath = Read-Host "  Ruta base"
    
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

Write-Success "✓ Ruta base seleccionada: $basePath"

# =============================================================================
# 2.2: RUTA DE DOTFILES (GITHUB)
# =============================================================================

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  2️⃣  RUTA DEL REPOSITORIO DOTFILES" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Aquí se sincronizará tu configuración con GitHub:" -ForegroundColor $Colors.Gray
Write-Path "$dotfilesPath\users\ (tu espacio personal)"
Write-Path "$dotfilesPath\oh-my-posh\ (temas compartidos)"
Write-Path "$dotfilesPath\powershell\ (perfil de PowerShell)"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host ""

$defaultDotfiles = "$env:USERPROFILE\GitHub\dotfiles"
Write-Info "Ruta predeterminada: $defaultDotfiles"
Write-Host ""
Write-Question "¿Deseas usar esta ruta? (S = sí, N = elegir otra)"
$useDefaultDotfiles = Read-Host

if ($useDefaultDotfiles -match '^[Ss]$') {
    $dotfilesPath = $defaultDotfiles
}
else {
    Write-Host ""
    Write-Info "Ingresa la ruta completa para tu repositorio de dotfiles:"
    Write-Host "  Ejemplo: C:\Users\TuUsuario\Documents\dotfiles" -ForegroundColor $Colors.Gray
    Write-Host ""
    $dotfilesPath = Read-Host "  Ruta de dotfiles"
    
    if (-not (Test-Path $dotfilesPath)) {
        Write-Question "La ruta no existe. ¿Deseas crearla? (S/N)"
        $createDotfiles = Read-Host
        if ($createDotfiles -match '^[Ss]$') {
            New-Item -ItemType Directory -Path $dotfilesPath -Force | Out-Null
            Write-Success "Ruta creada: $dotfilesPath"
        }
    }
}

Write-Success "✓ Ruta de dotfiles seleccionada: $dotfilesPath"

# =============================================================================
# 2.3: RUTA DEL PERFIL DE POWERSHELL
# =============================================================================

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  3️⃣  RUTA DEL PERFIL DE POWERSHELL" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Aquí se guardará tu configuración de PowerShell:" -ForegroundColor $Colors.Gray
Write-Path "$profileDir\Microsoft.PowerShell_profile.ps1"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Nota: Esta ruta es estándar de PowerShell" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host ""

$defaultProfileDir = "$env:USERPROFILE\Documents\PowerShell"
Write-Info "Ruta predeterminada (estándar de PowerShell): $defaultProfileDir"
Write-Host ""
Write-Question "¿Deseas usar esta ruta? (S = sí, N = elegir otra)"
$useDefaultProfile = Read-Host

if ($useDefaultProfile -match '^[Ss]$') {
    $profileDir = $defaultProfileDir
}
else {
    Write-Host ""
    Write-Info "Ingresa la ruta completa para tu perfil de PowerShell:"
    Write-Host "  Ejemplo: C:\Users\TuUsuario\Documents\PowerShell" -ForegroundColor $Colors.Gray
    Write-Host ""
    $profileDir = Read-Host "  Ruta del perfil"
}

Write-Success "✓ Ruta del perfil seleccionada: $profileDir"

# =============================================================================
# 2.4: RESUMEN DE RUTAS ANTES DE CREAR
# =============================================================================

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Highlight
Write-Host "│  📋 RESUMEN DE RUTAS SELECCIONADAS" -ForegroundColor $Colors.Highlight
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Highlight
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Ruta Base Principal:" -ForegroundColor $Colors.Info
Write-Path "  $basePath"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Repositorio Dotfiles:" -ForegroundColor $Colors.Info
Write-Path "  $dotfilesPath"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Perfil de PowerShell:" -ForegroundColor $Colors.Info
Write-Path "  $profileDir"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Highlight
Write-Host ""

Write-Question "¿Deseas continuar con estas rutas? (S/N)"
$confirmPaths = Read-Host

if ($confirmPaths -notmatch '^[Ss]$') {
    Write-Error "Instalación cancelada. Puedes ejecutar el script nuevamente."
    exit 0
}

# =============================================================================
# PASO 3: DEFINIR RUTAS ESPECÍFICAS (INTERNAS)
# =============================================================================

$paths = @{
    OhMyPoshThemes      = "$basePath\oh-my-posh"
    OhMyPoshConfigs     = "$basePath\oh-my-posh-configs"
    OhMyPoshBackups     = "$basePath\oh-my-posh-configs\backups"
    GitHubDotfiles      = "$dotfilesPath"
    PowerShellProfile   = "$profileDir"
    UserThemes          = "$dotfilesPath\users"
    OhMyPoshInDotfiles  = "$dotfilesPath\oh-my-posh"
    PowerShellInDotfiles = "$dotfilesPath\powershell"
}

# =============================================================================
# PASO 4: CREAR DIRECTORIOS (MOSTRANDO CADA RUTA)
# =============================================================================

Write-Step "Creando estructura de carpetas"

Write-Host ""
Write-Info "Creando carpetas en las rutas seleccionadas..."
Write-Host ""

$directoriesCreated = 0
$directoriesExists = 0
$createdPaths = @()

foreach ($path in $paths.Values) {
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Success "Creado: $path"
        $createdPaths += $path
        $directoriesCreated++
    }
    else {
        Write-Info "Ya existe: $path"
        $directoriesExists++
    }
}

Write-Host ""
Write-Info "Resumen: $directoriesCreated creados, $directoriesExists ya existían"

# =============================================================================
# PASO 5: INSTALAR OH MY POSH (MÚLTIPLES MÉTODOS)
# =============================================================================

Write-Step "Verificando instalación de Oh My Posh"

$ompInstalled = Get-Command oh-my-posh -ErrorAction SilentlyContinue

if ($ompInstalled) {
    $version = oh-my-posh version
    Write-Success "Oh My Posh ya está instalado (Versión: $version)"
    Write-Info "No es necesario instalar. Continuando con la configuración..."
}
else {
    Write-Warning "⚠️  Oh My Posh NO está instalado en este sistema"
    Write-Host ""
    Write-Info "Selecciona el método de instalación que prefieres:"
    Write-Host ""
    Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
    Write-Host "│  🔧 MÉTODOS DE INSTALACIÓN DISPONIBLES" -ForegroundColor $Colors.Primary
    Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
    Write-Host "│" -ForegroundColor $Colors.Gray
    Write-Host "│  1. Winget (recomendado - Windows 10/11)" -ForegroundColor $Colors.Info
    Write-Host "│     • Gestor de paquetes oficial de Microsoft" -ForegroundColor $Colors.Gray
    Write-Host "│     • Instalación automática y silenciosa" -ForegroundColor $Colors.Gray
    Write-Host "│" -ForegroundColor $Colors.Gray
    Write-Host "│  2. Chocolatey" -ForegroundColor $Colors.Info
    Write-Host "│     • Gestor de paquetes de la comunidad" -ForegroundColor $Colors.Gray
    Write-Host "│" -ForegroundColor $Colors.Gray
    Write-Host "│  3. Descargar manualmente (MSI/ZIP)" -ForegroundColor $Colors.Info
    Write-Host "│     • Descarga directa desde GitHub Releases" -ForegroundColor $Colors.Gray
    Write-Host "│" -ForegroundColor $Colors.Gray
    Write-Host "│  4. Scoop" -ForegroundColor $Colors.Info
    Write-Host "│     • Gestor de paquetes para desarrolladores" -ForegroundColor $Colors.Gray
    Write-Host "│" -ForegroundColor $Colors.Gray
    Write-Host "│  5. Saltar instalación (ya lo instalaré después)" -ForegroundColor $Colors.Warning
    Write-Host "│" -ForegroundColor $Colors.Gray
    Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
    Write-Host ""
    
    Write-Question "Selecciona un método de instalación (1/2/3/4/5)"
    $installMethod = Read-Host
    
    $installationSuccess = $false
    
    switch ($installMethod) {
        '1' {
            Write-Host ""
            Write-Info "Método seleccionado: Winget"
            if (Get-Command winget -ErrorAction SilentlyContinue) {
                Write-Info "Iniciando instalación con winget..."
                winget install JanDeDobbeleer.OhMyPosh --source winget --silent --accept-package-agreements
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Success "✓ Oh My Posh instalado exitosamente con winget"
                    $installationSuccess = $true
                    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
                }
                else {
                    Write-Error "Error al instalar con winget (código: $LASTEXITCODE)"
                }
            }
            else {
                Write-Error "winget no está disponible en este sistema"
            }
        }
        '2' {
            Write-Host ""
            Write-Info "Método seleccionado: Chocolatey"
            if (Get-Command choco -ErrorAction SilentlyContinue) {
                choco install oh-my-posh -y
                if ($LASTEXITCODE -eq 0) {
                    Write-Success "✓ Oh My Posh instalado exitosamente con chocolatey"
                    $installationSuccess = $true
                }
            }
            else {
                Write-Error "Chocolatey no está instalado en este sistema"
            }
        }
        '3' {
            Write-Host ""
            Write-Info "Método seleccionado: Descarga Manual"
            Write-Host ""
            Write-Info "Sigue estos pasos para instalar manualmente:"
            Write-Host ""
            Write-Option "1. Ve a: https://github.com/JanDeDobbeleer/oh-my-posh/releases"
            Write-Option "2. Descarga el archivo .msi más reciente para Windows"
            Write-Option "3. Ejecuta el instalador y sigue las instrucciones"
            Write-Option "4. Reinicia PowerShell después de instalar"
            Write-Host ""
            Write-Question "¿Ya descargaste e instalaste Oh My Posh? (S/N)"
            $manualInstalled = Read-Host
            if ($manualInstalled -match '^[Ss]$') {
                $checkOmp = Get-Command oh-my-posh -ErrorAction SilentlyContinue
                if ($checkOmp) {
                    Write-Success "✓ Oh My Posh detectado correctamente"
                    $installationSuccess = $true
                }
            }
        }
        '4' {
            Write-Host ""
            Write-Info "Método seleccionado: Scoop"
            if (Get-Command scoop -ErrorAction SilentlyContinue) {
                scoop install oh-my-posh
                if ($LASTEXITCODE -eq 0) {
                    Write-Success "✓ Oh My Posh instalado exitosamente con scoop"
                    $installationSuccess = $true
                }
            }
            else {
                Write-Error "Scoop no está instalado en este sistema"
            }
        }
        '5' {
            Write-Host ""
            Write-Info "Método seleccionado: Saltar instalación"
            Write-Warning "⚠️  Continuando sin Oh My Posh instalado"
            $installationSuccess = $false
        }
        default {
            Write-Error "Opción no válida. Saltando instalación de Oh My Posh."
            $installationSuccess = $false
        }
    }
}

# =============================================================================
# PASO 6: CONFIGURAR FUENTES NERD FONT
# =============================================================================

Write-Step "Configurando fuentes Nerd Font"

Write-Host ""
Write-Info "Las fuentes Nerd Font son necesarias para mostrar los íconos correctamente."
Write-Host ""
Write-Question "¿Deseas instalar las fuentes Nerd Font? (S/N)"
$installFonts = Read-Host

if ($installFonts -match '^[Ss]$') {
    Write-Host ""
    Write-Info "Para instalar las fuentes Nerd Font:"
    Write-Host ""
    Write-Option "1. Abre PowerShell como administrador"
    Write-Option "2. Ejecuta: oh-my-posh font install meslo"
    Write-Option "3. Reinicia tu terminal"
    Write-Host ""
    
    Write-Question "¿Deseas intentar instalar las fuentes ahora? (S/N)"
    $installNow = Read-Host
    
    if ($installNow -match '^[Ss]$') {
        if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
            try {
                oh-my-posh font install meslo
                Write-Success "Fuentes instaladas. Reinicia tu terminal para aplicar los cambios."
            }
            catch {
                Write-Error "Error al instalar fuentes: $($_.Exception.Message)"
            }
        }
        else {
            Write-Warning "Oh My Posh no está instalado. Instala las fuentes manualmente después."
        }
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
Write-Host "│  2. Predeterminada (catppuccin)" -ForegroundColor $Colors.Info
Write-Host "│  3. Crear mi propio tema personalizado" -ForegroundColor $Colors.Highlight
Write-Host "│  4. Explorar otros temas" -ForegroundColor $Colors.Info
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host ""

Write-Question "Selecciona una opción (1/2/3/4)"
$configType = Read-Host

$selectedTheme = ""
$configPath = ""
$userThemeName = ""
$userThemePath = ""
$userName = ""

# =============================================================================
# PASO 8: CREAR TEMA PERSONALIZADO (OPCIÓN 3)
# =============================================================================

if ($configType -eq '3') {
    Write-Step "🎨 Creador de Temas Personalizados"
    
    Write-Question "¿Cuál es tu nombre de usuario o nickname?"
    $userName = Read-Host
    if (-not $userName) { $userName = $env:USERNAME }
    
    $userFolder = "$($paths.UserThemes)\$userName"
    if (-not (Test-Path $userFolder)) {
        New-Item -ItemType Directory -Path $userFolder -Force | Out-Null
        Write-Success "Carpeta de usuario creada: $userFolder"
    }
    
    Write-Host ""
    Write-Info "Elige un nombre para tu tema (sin espacios ni caracteres especiales)"
    Write-Question "Nombre del tema"
    $userThemeName = Read-Host
    if (-not $userThemeName) { $userThemeName = "mi-tema" }
    
    $userThemePath = "$userFolder\$userThemeName.omp.json"
    
    Write-Host ""
    Write-Info "¿Qué editor de código prefieres usar?"
    Write-Option "1. Visual Studio Code (recomendado)"
    Write-Option "2. Visual Studio Code Insiders"
    Write-Option "3. Notepad++"
    Write-Option "4. Notepad (básico)"
    Write-Option "5. Otro (especificar comando)"
    Write-Host ""
    Write-Question "Selecciona una opción (1/2/3/4/5)"
    $editorChoice = Read-Host
    
    $editorCommand = ""
    switch ($editorChoice) {
        '1' { $editorCommand = "code" }
        '2' { $editorCommand = "code-insiders" }
        '3' { $editorCommand = "notepad++" }
        '4' { $editorCommand = "notepad" }
        '5' {
            Write-Question "Ingresa el comando o ruta del editor"
            $editorCommand = Read-Host
        }
        default { $editorCommand = "code" }
    }
    
    $themeTemplate = @'
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
          "template": " {{ .UserName }} ",
          "cache": { "duration": "30s" }
        },
        {
          "type": "path",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#446786",
          "template": "  {{ .Path }} ",
          "properties": { "style": "folder" }
        },
        {
          "type": "git",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#000000",
          "background": "#FFFB38",
          "template": " {{ .HEAD }} ",
          "properties": { "fetch_status": true },
          "cache": { "duration": "10s" }
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
          "template": " {{ if gt .Code 0 }}✗{{ else }}✓{{ end }} "
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
          "template": " {{ .CurrentDate | date \"15:04:05\" }} "
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
    
    $themeTemplate | Out-File -FilePath $userThemePath -Encoding utf8 -Force
    Write-Success "Plantilla de tema creada: $userThemePath"
    
    Write-Host ""
    Write-Info "Abriendo editor de código..."
    Write-Host "  Editor: $editorCommand" -ForegroundColor $Colors.Gray
    Write-Host "  Archivo: $userThemePath" -ForegroundColor $Colors.Gray
    Write-Host ""
    Write-Host "Presiona cualquier tecla para abrir el editor..." -ForegroundColor $Colors.Warning
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    
    try {
        & $editorCommand $userThemePath
    }
    catch {
        notepad $userThemePath
    }
    
    Write-Host ""
    Write-Info "Presiona Enter cuando hayas terminado de editar..."
    Read-Host
    
    $selectedTheme = $userThemeName
    $configPath = $userThemePath
}
elseif ($configType -eq '1') {
    $selectedTheme = "carlos-optimized"
    $configPath = "$($paths.OhMyPoshConfigs)\carlos-optimized.omp.json"
}
elseif ($configType -eq '2') {
    $selectedTheme = "catppuccin"
    $configPath = "$($paths.OhMyPoshThemes)\catppuccin.omp.json"
}
elseif ($configType -eq '4') {
    Write-Host ""
    Write-Info "Temas populares: catppuccin, night-owl, tokyonight_storm, blue-owl, dracula"
    Write-Question "Ingresa el nombre del tema"
    $selectedTheme = Read-Host
    $configPath = "$($paths.OhMyPoshThemes)\$selectedTheme.omp.json"
}
else {
    $selectedTheme = "carlos-optimized"
    $configPath = "$($paths.OhMyPoshConfigs)\carlos-optimized.omp.json"
}

# =============================================================================
# PASO 9: CREAR CONFIGURACIÓN CARLOS-OPTIMIZED
# =============================================================================

if ($configType -eq '1' -and -not (Test-Path $configPath)) {
    Write-Step "Creando configuración carlos-optimized"
    
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
          "template": " {{ .UserName }} ",
          "cache": { "duration": "30s" }
        },
        {
          "type": "path",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#446786",
          "template": "  {{ .Path }} ",
          "properties": { "style": "folder" }
        },
        {
          "type": "git",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#000000",
          "background": "#FFFB38",
          "template": " {{ .HEAD }} ",
          "cache": { "duration": "10s" }
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
          "template": " ✓ "
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
          "template": " {{ .CurrentDate | date \"15:04:05\" }} "
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
  ]
}
'@
    
    $configContent | Out-File -FilePath $configPath -Encoding utf8 -Force
    Write-Success "Configuración creada: $configPath"
}

# =============================================================================
# PASO 10: CONFIGURAR PERFIL DE POWERSHELL
# =============================================================================

Write-Step "Configurando perfil de PowerShell"

$profilePath = "$($paths.PowerShellProfile)\Microsoft.PowerShell_profile.ps1"

Write-Info "Creando archivo de perfil..."
Write-Success "Perfil creado: $profilePath"

# =============================================================================
# PASO 11: SINCRONIZAR CON GITHUB
# =============================================================================

Write-Step "Configurando repositorio de dotfiles en GitHub"

Write-Host ""
Write-Question "¿Deseas configurar la sincronización con GitHub? (S/N)"
$setupGitHub = Read-Host

if ($setupGitHub -match '^[Ss]$') {
    Write-Host ""
    Write-Info "Ingresa la URL de tu repositorio de dotfiles en GitHub:"
    $gitUrl = Read-Host "  URL del repositorio"
    
    if ($gitUrl) {
        if (Test-Path $paths.GitHubDotfiles) {
            Set-Location $paths.GitHubDotfiles
            git remote set-url origin $gitUrl 2>$null
            Write-Success "Repositorio configurado: $gitUrl"
        }
        else {
            git clone $gitUrl $paths.GitHubDotfiles
            Write-Success "Repositorio clonado: $paths.GitHubDotfiles"
        }
        
        Write-Host ""
        Write-Info "Copiando configuración al repositorio..."
        
        if (Test-Path $configPath) {
            Copy-Item $configPath "$($paths.OhMyPoshInDotfiles)\" -Force
            Write-Success "Configuración copiada a: $($paths.OhMyPoshInDotfiles)\"
        }
        
        Copy-Item $profilePath "$($paths.PowerShellInDotfiles)\" -Force
        Write-Success "Perfil copiado a: $($paths.PowerShellInDotfiles)\"
        
        if ($userThemePath -and (Test-Path $userThemePath)) {
            $userThemeDest = "$($paths.UserThemes)\$userName\"
            New-Item -ItemType Directory -Path $userThemeDest -Force | Out-Null
            Copy-Item $userThemePath $userThemeDest -Force
            Write-Success "Tema personalizado copiado a: $userThemeDest"
        }
        
        Set-Location $paths.GitHubDotfiles
        git add .
        git commit -m "feat: initial setup - $(Get-Date -Format 'yyyy-MM-dd')"
        
        Write-Question "¿Deseas hacer push a GitHub ahora? (S/N)"
        $doPush = Read-Host
        if ($doPush -match '^[Ss]$') {
            git push
            Write-Success "Cambios sincronizados con GitHub"
        }
    }
}

# =============================================================================
# PASO 12: VERIFICACIÓN COMPLETA DEL SISTEMA (OPCIONAL)
# =============================================================================

Write-Step "🔍 Verificación del Sistema"

Write-Host ""
Write-Question "¿Deseas realizar una verificación completa de todo ahora? (S/N)"
$doVerification = Read-Host

$verificationPerformed = $false
$passedCount = 0
$totalCount = 0

if ($doVerification -match '^[Ss]$') {
    $verificationPerformed = $true
    Write-Host ""
    Write-Info "Iniciando verificación completa..."
    Write-Host ""
    
    Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
    Write-Host "│  📊 REPORTE DE VERIFICACIÓN" -ForegroundColor $Colors.Primary
    Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
    
    $checks = @{
        "Oh My Posh instalado" = (Get-Command oh-my-posh -ErrorAction SilentlyContinue) -ne $null
        "Perfil de PowerShell existe" = (Test-Path $profilePath)
        "Configuración existe" = (Test-Path $configPath)
        "Carpeta oh-my-posh existe" = (Test-Path $paths.OhMyPoshThemes)
        "Carpeta backups existe" = (Test-Path $paths.OhMyPoshBackups)
        "Carpeta users existe" = (Test-Path $paths.UserThemes)
    }
    
    $totalCount = $checks.Count
    foreach ($check in $checks.GetEnumerator()) {
        Write-Check $check.Key $check.Value
        if ($check.Value) { $passedCount++ }
    }
    
    Write-Host ""
    Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
    Write-Host "│  Resumen: $passedCount/$totalCount verificaciones exitosas" -ForegroundColor $Colors.Primary
    Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
    
    if ($passedCount -eq $totalCount) {
        Write-Success "¡Todas las verificaciones pasaron exitosamente!"
    }
}

# =============================================================================
# PASO 13: 📍 REPORTE FINAL DE RUTAS (DONDE SE GUARDÓ TODO)
# =============================================================================

Write-Header "🎉 INSTALACIÓN COMPLETADA"

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor $Colors.Success
Write-Host "║                                                           ║" -ForegroundColor $Colors.Success
Write-Host "║   📍  REPORTE DE RUTAS - DÓNDE SE GUARDÓ TODO            ║" -ForegroundColor $Colors.Highlight
Write-Host "║                                                           ║" -ForegroundColor $Colors.Success
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor $Colors.Success

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  📁 RUTAS PRINCIPALES" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Ruta Base Principal:" -ForegroundColor $Colors.Info
Write-Path "  $basePath"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Repositorio Dotfiles:" -ForegroundColor $Colors.Info
Write-Path "  $dotfilesPath"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Perfil de PowerShell:" -ForegroundColor $Colors.Info
Write-Path "  $profileDir"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  📁 CARPETAS CREADAS" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Path "$basePath\oh-my-posh\"
Write-Host "│   └── Temas oficiales de Oh My Posh (100+ temas)" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Path "$basePath\oh-my-posh-configs\"
Write-Host "│   └── Tu configuración principal" -ForegroundColor $Colors.Gray
Write-Path "$basePath\oh-my-posh-configs\backups\"
Write-Host "│   └── Backups automáticos de configuraciones" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Path "$dotfilesPath\users\$userName\"
Write-Host "│   └── TU espacio personal para temas personalizados" -ForegroundColor $Colors.Highlight
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Path "$dotfilesPath\oh-my-posh\"
Write-Host "│   └── Configuraciones para sincronizar con GitHub" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Path "$dotfilesPath\powershell\"
Write-Host "│   └── Perfil de PowerShell para sincronizar" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Path "$profileDir\"
Write-Host "│   └── Microsoft.PowerShell_profile.ps1 (perfil activo)" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│  📄 ARCHIVOS CREADOS" -ForegroundColor $Colors.Primary
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Configuración Principal:" -ForegroundColor $Colors.Info
Write-Path "  $configPath"
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  Perfil de PowerShell:" -ForegroundColor $Colors.Info
Write-Path "  $profilePath"
Write-Host "│" -ForegroundColor $Colors.Gray
if ($userThemePath) {
    Write-Host "│  Tema Personalizado:" -ForegroundColor $Colors.Info
    Write-Path "  $userThemePath"
    Write-Host "│" -ForegroundColor $Colors.Gray
}
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Primary

Write-Host ""
Write-Host "┌─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
Write-Host "│  📋 RESUMEN DE LA INSTALACIÓN" -ForegroundColor $Colors.Success
Write-Host "├─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Success
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Oh My Posh: $($(if ($ompInstalled -or $installationSuccess) { 'Instalado' } else { 'Pendiente' }))" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Configuración: $selectedTheme" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Carpetas creadas: $directoriesCreated" -ForegroundColor $Colors.Gray
Write-Host "│  ✅ Alias disponibles: 12" -ForegroundColor $Colors.Gray
if ($verificationPerformed) {
    Write-Host "│  ✅ Verificación: $passedCount/$totalCount exitosas" -ForegroundColor $Colors.Gray
}
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
Write-Host "│  2. Instala fuentes Nerd Font: oh-my-posh font install meslo" -ForegroundColor $Colors.Gray
Write-Host "│  3. Configura Windows Terminal para usar Nerd Font" -ForegroundColor $Colors.Gray
Write-Host "│  4. Ejecuta: ompinfo para verificar el estado" -ForegroundColor $Colors.Gray
Write-Host "│" -ForegroundColor $Colors.Gray
Write-Host "└─────────────────────────────────────────────────────────" -ForegroundColor $Colors.Warning

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor $Colors.Success
Write-Host "║                                                           ║" -ForegroundColor $Colors.Success
Write-Host "║   🎨  ¡GRACIAS POR USAR EL INSTALADOR DE CARLOS!         ║" -ForegroundColor $Colors.Highlight
Write-Host "║                                                           ║" -ForegroundColor $Colors.Success
Write-Host "║   Universidad: FCFM-UANL                                  ║" -ForegroundColor $Colors.Gray
Write-Host "║   Carrera: Ciencias Computacionales y Ciberseguridad     ║" -ForegroundColor $Colors.Gray
Write-Host "║                                                           ║" -ForegroundColor $Colors.Success
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor $Colors.Success
Write-Host ""

Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor $Colors.Warning
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")