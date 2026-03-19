# 📦 Historial de Versiones - Instalador Oh My Posh

Repositorio: https://github.com/Carlos007-gif/dotfiles  
Autor: Carlos Daniel Martínez Reynoso  
Universidad: FCFM-UANL  
Carrera: Ciencias Computacionales y Ciberseguridad

---

## � Propósito

Este archivo documenta las versiones y cambios del instalador Oh My Posh en este repositorio. Sirve como referencia rápida para usuarios y contribuidores.

## 📚 Índice

- [Resumen de Versiones](#-resumen-de-versiones)
- [Uso de Versiones](#-uso-de-versiones)
- [Changelog Detallado](#-changelog-detallado)
- [Recomendación de Versiones](#-qué-versión-usar)
- [Estadísticas](#-estadísticas-del-proyecto)
- [Enlaces](#-enlaces)
- [Changelog 2.2.0 (en `versions/v2.2.0/`)](#-changelogmd-para-v220-dentro-de-versionsv220)
- [Script de Creación de Estructura](#-script-para-crear-la-estructura-de-versiones)

---

## 📊 Resumen de Versiones

| Versión | Fecha      | Estado       | Cambios Principales                                                    |
| ------- | ---------- | ------------ | ---------------------------------------------------------------------- |
| 2.2.0   | 19/03/2026 | ✅ Actual    | Pregunta cada ruta, reporte final detallado, control total del usuario |
| 2.1.0   | 19/03/2026 | 📜 Histórica | Instalación multi-método, verificación opcional, feedback de errores   |
| 2.0.0   | 19/03/2026 | 📜 Histórica | Soporte `users/`, generador de temas, selector de editor               |
| 1.0.0   | 19/03/2026 | 📜 Histórica | Instalador base, estructura inicial, alias y perfil configurados       |

**Total de versiones: 4**

---

## 🔄 Uso de Versiones

### Instalar la versión actual (recomendado)

```powershell
# Ejecutar el instalador principal
.\install.ps1
```

### Instalar una versión específica

```powershell
# v2.2.0 (actual)
.\versions\v2.2.0\install_v2_2_0.ps1

# v2.1.0
.\versions\v2.1.0\install_v2_1_0.ps1

# v2.0.0
.\versions\v2.0.0\install_v2_0_0.ps1

# v1.0.0
.\versions\v1.0.0\install_v1_0_0.ps1
```

---

## 📝 Changelog Detallado

### v2.2.0 (19/03/2026) - ACTUAL

**Novedades**

- Pregunta cada ruta antes de crear carpetas (control granular)
- Reporte final con árbol de carpetas y archivos generados
- Confirmación individual para cada carpeta importante
- Mejora de iconos visuales (📁, 📄)

**Beneficios**

- Control total de rutas para el usuario
- Transparencia completa de los cambios en el sistema de archivos
- UX mejorada durante la instalación

---

### v2.1.0 (19/03/2026)

**Novedades**

- Instalación por Winget, Chocolatey, Manual, Scoop o paso para omitir
- Opción opcional de verificación final
- Reporte de verificación con contador y porcentaje
- Mensajes de error con recomendaciones de solución
- Instalación automática de fuentes de Oh My Posh

**Beneficios**

- Flexibilidad de instalación según el entorno del usuario
- Mejora de resiliencia y diagnostico de instalación

---

### v2.0.0 (19/03/2026)

**Novedades**

- Estructura de carpetas `users/` para configuración personalizada
- Generador de temas interactivo
- Selector de editor de código (VS Code, Notepad++, etc.)
- Validación de tema en tiempo real
- Solicitud de retroalimentación de satisfacción

**Beneficios**

- Personalización simplificada
- Experiencia de usuario más amigable

---

### v1.0.0 (19/03/2026)

**Características**

- Instalación inicial con Winget
- Creación de estructura de carpetas base
- Configuración automática de `$PROFILE`
- 12 alias de gestión configurados
- Sincronización inicial con GitHub

**Estado**: Base histórica

---

## 🎯 ¿Qué versión usar?

| Caso de uso                      | Versión recomendada              |
| -------------------------------- | -------------------------------- |
| Instalación nueva                | v2.2.0                           |
| Control total de rutas           | v2.2.0                           |
| Métodos de instalación alternos  | v2.1.0                           |
| Creación de temas personalizados | v2.0.0+                          |
| Análisis/Comparación             | cualquier versión en `versions/` |

---

## 📈 Estadísticas del proyecto

- Versiones lanzadas: 4
- Versión actual: 2.2.0
- Última actualización: 19/03/2026
- Alias incluidos (base): 12
- Métodos de instalación soportados: 5 (winget, chocolatey, manual, scoop, omitir)
- Temas soportados: 100+
- Idioma principal: Español

---

## 🔗 Enlaces

- Repositorio: https://github.com/Carlos007-gif/dotfiles
- Oh My Posh: https://ohmyposh.dev
- Documentación: https://ohmyposh.dev/docs

---

## 📄 `CHANGELOG.md` para v2.2.0 (Dentro de `versions/v2.2.0/`)

```markdown
# Changelog - Versión 2.2.0

**Fecha:** 19/03/2026  
**Estado:** ✅ Actual  
**Autor:** Carlos Daniel Martínez Reynoso

## 🆕 Novedades

- Pregunta CADA ruta antes de crear carpetas
- Control total de rutas individuales
- Reporte final visual con árbol y lista de archivos
- Iconos visuales por tipo de recurso

## 📊 Comparación con v2.1.0

| Característica        | v2.1.0       | v2.2.0           |
| --------------------- | ------------ | ---------------- |
| Pregunta rutas        | Parcial      | ✅ Cada ruta     |
| Confirmación de rutas | No           | ✅ Resumen antes |
| Reporte final         | Básico       | ✅ Detallado     |
| Carpetas mostradas    | Lista simple | ✅ Árbol visual  |
| Archivos mostrados    | No           | ✅ Sí            |
| Iconos visuales       | Limitado     | ✅ Completo      |
```

---

## 🚀 Script para Crear la Estructura de Versiones

```powershell
$repoPath = "$env:USERPROFILE\GitHub\dotfiles"
Set-Location $repoPath

# 1. crear carpeta versions
New-Item -ItemType Directory -Path "$repoPath\versions" -Force | Out-Null
Write-Output "Creado: versions/"

# 2. crear carpetas de versiones
$versions = @('v1.0.0', 'v2.0.0', 'v2.1.0', 'v2.2.0')
foreach ($version in $versions) {
    New-Item -ItemType Directory -Path "$repoPath\versions\$version" -Force | Out-Null
    Write-Output "Creado: versions/$version/"
}

# 3. copiar install.ps1 actual a v2.2.0
Copy-Item "$repoPath\install.ps1" "$repoPath\versions\v2.2.0\install_v2_2_0.ps1" -Force

Write-Success "Copiado: install.ps1 → versions/v2.2.0/"
```

# 4. Crear archivo VERSIONS.md

```powershell
$versionsContent = @'
[Contenido del VERSIONS.md de arriba]
'@
$versionsContent | Out-File -FilePath "$repoPath\VERSIONS.md" -Encoding utf8 -Force
Write-Success "Creado: VERSIONS.md"
```

# 5. Crear CHANGELOG.md para v2.2.0

```powershell
$changelogContent = @'
[Contenido del CHANGELOG.md de arriba]
'@
$changelogContent | Out-File -FilePath "$repoPath\versions\v2.2.0\CHANGELOG.md" -Encoding utf8 -Force
Write-Success "Creado: versions/v2.2.0/CHANGELOG.md"
```

# 6. Commit y push

```powershell
git add .
git commit -m "feat: agregar estructura de versiones (v1.0.0 - v2.2.0)"
git push

Write-Host ""
Write-Success "¡Estructura de versiones creada y sincronizada!"

📊 Resumen Visual de Versiones

╔═══════════════════════════════════════════════════════════╗
║ 📦 VERSIONES DEL INSTALADOR OH MY POSH ║
╠═══════════════════════════════════════════════════════════╣
║ ║
║ v1.0.0 📜 Script base (instalación básica) ║
║ │ ║
║ ▼ ║
║ v2.0.0 📜 + Carpeta users/, creador de temas ║
║ │ ║
║ ▼ ║
║ v2.1.0 📜 + Múltiples métodos de instalación ║
║ │ ║
║ ▼ ║
║ v2.2.0 ✅ ACTUAL - Selección de rutas, reporte final ║
║ ║
╠═══════════════════════════════════════════════════════════╣
║ Total de versiones: 4 ║
║ Versión actual: 2.2.0 ║
║ Última actualización: 19/03/2026 ║
╚═══════════════════════════════════════════════════════════╝

✅ Comandos Finales para Organizar el Repositorio

# 1. Ir al repositorio

Set-Location "$env:USERPROFILE\GitHub\dotfiles"

# 2. Crear estructura de versiones

New-Item -ItemType Directory -Path "versions\v1.0.0", "versions\v2.0.0", "versions\v2.1.0", "versions\v2.2.0" -Force

# 3. Copiar install.ps1 actual a v2.2.0

Copy-Item "install.ps1" "versions\v2.2.0\install.ps1" -Force

# 4. Crear VERSIONS.md

notepad "VERSIONS.md" # Pegar el contenido de arriba

# 5. Crear CHANGELOG.md para v2.2.0

notepad "versions\v2.2.0\CHANGELOG.md" # Pegar el contenido de arriba

# 6. Sincronizar con GitHub

git add .
git commit -m "feat: organizar versiones del instalador (v1.0.0 - v2.2.0)"
git push

# 7. Verificar estructura

tree /F
```