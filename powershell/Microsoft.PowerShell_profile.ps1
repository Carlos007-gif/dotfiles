# =============================================================================
# Oh My Posh - Configuración Optimizada para Carlos
# =============================================================================
# Usuario: Carlos Daniel Martínez Reynoso
# Universidad: Facultad de Ciencias Físico-Matemáticas, UANL
# Carrera: Licenciatura en Ciencias Computacionales y Ciberseguridad
# =============================================================================

# Ruta a la configuración personalizada
$OhMyPoshConfig = "C:\Users\Lenovo2006CDMR\Downloads\oh-my-posh-configs\carlos-optimized.omp.json"

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
    <#
    .SYNOPSIS
        Actualiza Oh My Posh instalado como paquete MSIX
    #>
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
    <#
    .SYNOPSIS
        Valida la configuración de Oh My Posh sin recargar el prompt
    #>
    param(
        [string]$ConfigPath = "$env:USERPROFILE\Downloads\oh-my-posh-configs\carlos-optimized.omp.json"
    )
    
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
    
    if ($config.version -ne 2) {
        Write-Host "⚠ Advertencia: Versión de esquema no es 2 (actual: $($config.version))" -ForegroundColor Yellow
    }
    
    if (-not $config.blocks) {
        Write-Host "✗ Configuración inválida: falta el bloque 'blocks'" -ForegroundColor Red
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
    <#
    .SYNOPSIS
        Crea un backup timestamped de la configuración de Oh My Posh
    #>
    param(
        [switch]$Force
    )
    
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
    <#
    .SYNOPSIS
        Sincroniza configuraciones con el repositorio de dotfiles en GitHub
    #>
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
    <#
    .SYNOPSIS
        Prueba un tema de Oh My Posh temporalmente (solo sesión actual)
    .PARAMETER ThemeName
        Nombre del tema sin extensión .omp.json
    .EXAMPLE
        Test-OhMyPoshTheme catppuccin
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$ThemeName
    )
    
    $themePath = "$env:USERPROFILE\Downloads\oh-my-posh\themes\$ThemeName.omp.json"
    
    if (Test-Path $themePath) {
        Write-Host "🎨 Cargando tema: $ThemeName" -ForegroundColor Cyan
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
        Write-Host "💡 Para volver a su tema personalizado: escriba 'romp'" -ForegroundColor Yellow
    }
    else {
        Write-Host "✗ Tema no encontrado: $ThemeName" -ForegroundColor Red
        Write-Host "💡 Temas disponibles en: $env:USERPROFILE\Downloads\oh-my-posh\themes\" -ForegroundColor Gray
    }
}
Set-Alias testtheme Test-OhMyPoshTheme

function Get-OhMyPoshThemes {
    <#
    .SYNOPSIS
        Lista los temas disponibles de Oh My Posh
    #>
    param(
        [int]$First = 20
    )
    
    Write-Host "📂 Temas disponibles (mostrando los primeros $First):" -ForegroundColor Cyan
    Get-ChildItem "$env:USERPROFILE\Downloads\oh-my-posh\themes\*.omp.json" | 
        Select-Object -First $First | 
        ForEach-Object { 
            Write-Host "  • $($_.BaseName)" -ForegroundColor Gray 
        }
    Write-Host "`n💡 Use 'testtheme <nombre>' para probar un tema" -ForegroundColor Yellow
}
Set-Alias listthemes Get-OhMyPoshThemes

function Test-TopThemes {
    <#
    .SYNOPSIS
        Demostración automática de los 10 mejores temas de Oh My Posh
    .PARAMETER SecondsPerTheme
        Segundos a mostrar cada tema (default: 15)
    .EXAMPLE
        Test-TopThemes -SecondsPerTheme 20
    #>
    param(
        [int]$SecondsPerTheme = 15
    )
    
    $topThemes = @(
        'catppuccin',
        'night-owl',
        'tokyonight_storm',
        'blue-owl',
        'jandedobbeleer',
        'dracula',
        'gruvbox',
        'atomicBit',
        'kali',
        'powerlevel10k_modern'
    )
    
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
    <#
    .SYNOPSIS
        Muestra información completa del estado de Oh My Posh
    #>
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
# Resumen de Alias Disponibles
# =============================================================================
<#
┌─────────────────────────────────────────────────────────────────────┐
│  ALIAS DISPONIBLES PARA GESTIÓN DE OH MY POSH                       │
├─────────────────────────────────────────────────────────────────────┤
│  testomp       → Validar configuración JSON                         │
│  eompc         → Editar configuración en Notepad                    │
│  romp          → Recargar Oh My Posh sin reiniciar terminal         │
│  updateomp     → Actualizar Oh My Posh vía winget                   │
│  backupomp     → Crear backup con timestamp                         │
│  syncdf        → Sincronizar con repositorio GitHub de dotfiles     │
│  testtheme     → Probar tema temporalmente                          │
│  listthemes    → Listar temas disponibles                           │
│  testtopthemes → Demo automática de 10 temas top                    │
│  ompinfo       → Mostrar información completa del estado            │
└─────────────────────────────────────────────────────────────────────┘
#>
# =============================================================================
# =============================================================================
# Cambio Rápido de Tema
# =============================================================================

function Set-OhMyPoshTheme {
    <#
    .SYNOPSIS
        Cambia el tema de Oh My Posh permanentemente
    .PARAMETER ThemeName
        Nombre del tema sin extensión .omp.json
    .EXAMPLE
        Set-OhMyPoshTheme catppuccin
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$ThemeName
    )
    
    $themePath = "$env:USERPROFILE\Downloads\oh-my-posh\themes\$ThemeName.omp.json"
    
    if (-not (Test-Path $themePath)) {
        Write-Host "✗ Tema no encontrado: $ThemeName" -ForegroundColor Red
        return
    }
    
    # Crear backup primero
    Write-Host "📦 Creando respaldo de configuración actual..." -ForegroundColor Cyan
    backupomp
    
    # Leer perfil actual
    $profileContent = Get-Content $PROFILE -Raw
    
    # Reemplazar ruta del tema
    $oldPattern = '\$OhMyPoshConfig\s*=\s*"[^"]*"'
    $newLine = "`$OhMyPoshConfig = `"$themePath`""
    $profileContent = $profileContent -replace $oldPattern, $newLine
    
    # Guardar cambios
    $profileContent | Set-Content $PROFILE -Encoding utf8
    Write-Host "✓ Perfil actualizado" -ForegroundColor Green
    
    # Recargar
    Write-Host "🔄 Recargando configuración..." -ForegroundColor Cyan
    . $PROFILE
    
    Write-Host "✓ Tema cambiado a: $ThemeName" -ForegroundColor Green
}
Set-Alias settheme Set-OhMyPoshTheme
# =============================================================================
# Cambio Rápido de Tema (Versión Mejorada)
# =============================================================================

function Set-OhMyPoshTheme {
    <#
    .SYNOPSIS
        Cambia el tema de Oh My Posh permanentemente (busca en themes y configs)
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$ThemeName
    )
    
    # Buscar en ambos directorios
    $themePaths = @(
        "$env:USERPROFILE\Downloads\oh-my-posh\themes\$ThemeName.omp.json",
        "$env:USERPROFILE\Downloads\oh-my-posh-configs\$ThemeName.omp.json"
    )
    
    $themePath = $null
    foreach ($path in $themePaths) {
        if (Test-Path $path) {
            $themePath = $path
            break
        }
    }
    
    if (-not $themePath) {
        Write-Host "✗ Tema no encontrado: $ThemeName" -ForegroundColor Red
        Write-Host "💡 Busque en: " -NoNewline -ForegroundColor Gray
        Write-Host "themes\ " -NoNewline -ForegroundColor Cyan
        Write-Host "o " -NoNewline -ForegroundColor Gray
        Write-Host "oh-my-posh-configs\" -ForegroundColor Cyan
        return
    }
    
    # Crear backup primero
    Write-Host "📦 Creando respaldo de configuración actual..." -ForegroundColor Cyan
    backupomp
    
    # Leer perfil actual
    $profileContent = Get-Content $PROFILE -Raw
    
    # Reemplazar ruta del tema
    $oldPattern = '\$OhMyPoshConfig\s*=\s*"[^"]*"'
    $newLine = "`$OhMyPoshConfig = `"$themePath`""
    $profileContent = $profileContent -replace $oldPattern, $newLine
    
    # Guardar cambios
    $profileContent | Set-Content $PROFILE -Encoding utf8
    Write-Host "✓ Perfil actualizado" -ForegroundColor Green
    
    # Recargar
    Write-Host "🔄 Recargando configuración..." -ForegroundColor Cyan
    . $PROFILE
    
    Write-Host "✓ Tema cambiado a: $ThemeName" -ForegroundColor Green
}
Set-Alias settheme Set-OhMyPoshTheme
# =============================================================================
# Sincronizar $PROFILE con Dotfiles
# =============================================================================

function Sync-Profile {
    <#
    .SYNOPSIS
        Copia el $PROFILE actual al repositorio de dotfiles y sincroniza con GitHub
    #>
    
    $dotfilesProfilePath = "$env:USERPROFILE\GitHub\dotfiles\powershell\Microsoft.PowerShell_profile.ps1"
    
    # Crear directorio si no existe
    $profileDir = Split-Path $dotfilesProfilePath -Parent
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
        Write-Host "📁 Directorio creado: $profileDir" -ForegroundColor Cyan
    }
    
    # Copiar perfil
    Copy-Item $PROFILE $dotfilesProfilePath -Force
    Write-Host "✓ Perfil copiado a dotfiles" -ForegroundColor Green
    
    # Sincronizar con GitHub
    syncdf
}
Set-Alias syncprofile Sync-Profile
# =============================================================================
# Fin del Perfil
# =============================================================================

