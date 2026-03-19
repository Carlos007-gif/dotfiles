# 📄 README.md Mejorado para su Repositorio Dotfiles

Estimado Carlos, a continuación le presento un **README.md completo y profesional** que documenta todo el trabajo realizado en este proyecto.

---

## 📄 Contenido del README.md

```markdown
# 🎨 Dotfiles - Instalador Oh My Posh

[![Versión](https://img.shields.io/badge/versión-2.2.0-blue)](https://github.com/Carlos007-gif/dotfiles/releases)
[![PowerShell](https://img.shields.io/badge/PowerShell-7.0+-blue)](https://github.com/PowerShell/PowerShell)
[![Oh My Posh](https://img.shields.io/badge/Oh%20My%20Posh-29.9.0+-yellow)](https://ohmyposh.dev)
[![Licencia](https://img.shields.io/badge/licencia-MIT-green)](LICENSE)

> **Configuración profesional de Oh My Posh para PowerShell con instalador automatizado**

---

## 👤 Autor

| | |
|---|---|
| **Nombre** | Carlos Daniel Martínez Reynoso |
| **Universidad** | Facultad de Ciencias Físico-Matemáticas, UANL |
| **Carrera** | Licenciatura en Ciencias Computacionales y Ciberseguridad |
| **GitHub** | [@Carlos007-gif](https://github.com/Carlos007-gif) |

---

## 📋 Descripción

Este repositorio contiene una configuración **profesional y optimizada** de Oh My Posh para PowerShell, junto con un **instalador automatizado** que configura todo tu entorno en minutos.

### ✨ Características Principales

- 🚀 **Instalador interactivo** con múltiples métodos de instalación
- 🎨 **12 alias de gestión** para facilitar el uso diario
- 📁 **Estructura de versiones** organizada (v1.0.0 - v2.2.0)
- 👥 **Espacio personal** para temas de usuarios (`users/`)
- 🔧 **Creador de temas** interactivo con editor de código
- 📊 **Verificación completa** del sistema post-instalación
- 🌐 **Sincronización** con GitHub para portabilidad
- 📝 **Documentación completa** de todas las versiones

---

## 🚀 Inicio Rápido

### Instalación en 1 Comando

```powershell
# Clonar el repositorio
git clone https://github.com/Carlos007-gif/dotfiles.git $env:USERPROFILE\GitHub\dotfiles

# Ejecutar el instalador
Set-Location $env:USERPROFILE\GitHub\dotfiles
.\install.ps1
```

### Requisitos Previos

| Requisito | Versión Mínima | Cómo Verificar |
|-----------|---------------|----------------|
| **Windows** | 10/11 | `winver` |
| **PowerShell** | 7.0+ | `$PSVersionTable.PSVersion` |
| **Git** | 2.0+ | `git --version` |
| **Oh My Posh** | 29.9.0+ | `oh-my-posh version` (se instala automáticamente) |

---

## 📦 Versiones Disponibles

| Versión | Fecha | Estado | Cambios Principales |
|---------|-------|--------|---------------------|
| **[2.2.0](versions/v2.2.0/)** | 19/03/2026 | ✅ **Actual** | Selección de rutas individual, reporte final de rutas |
| [2.1.0](versions/v2.1.0/) | 19/03/2026 | 📜 Histórica | Múltiples métodos de instalación, verificación opcional |
| [2.0.0](versions/v2.0.0/) | 19/03/2026 | 📜 Histórica | Carpeta `users/`, creador de temas, editor de código |
| [1.0.0](versions/v1.0.0/) | 19/03/2026 | 📜 Histórica | Script base con instalación básica |

### ¿Qué Versión Usar?

| Caso de Uso | Versión Recomendada |
|-------------|---------------------|
| **Instalación nueva** | v2.2.0 (actual) |
| **Control total de rutas** | v2.2.0 |
| **Múltiples métodos de instalación** | v2.1.0 |
| **Crear temas personalizados** | v2.0.0 o superior |
| **Estudio/Comparación** | Cualquier versión en `versions/` |

---

## 🔧 Alias Disponibles

Después de la instalación, tendrás **12 alias** disponibles en PowerShell:

| Alias | Función | Descripción |
|-------|---------|-------------|
| `testomp` | `Test-OhMyPoshConfig` | Validar configuración JSON |
| `eompc` | `Edit-OhMyPoshConfig` | Editar configuración en Notepad |
| `romp` | `Reload-OhMyPosh` | Recargar Oh My Posh sin reiniciar |
| `updateomp` | `Update-OhMyPosh` | Actualizar vía winget |
| `backupomp` | `Backup-OhMyPoshConfig` | Crear backup con timestamp |
| `syncdf` | `Sync-Dotfiles` | Sincronizar con GitHub |
| `testtheme` | `Test-OhMyPoshTheme` | Probar tema temporalmente |
| `listthemes` | `Get-OhMyPoshThemes` | Listar temas disponibles |
| `testtopthemes` | `Test-TopThemes` | Demo automática de 10 temas |
| `ompinfo` | `Get-OhMyPoshInfo` | Información completa del estado |
| `settheme` | `Set-OhMyPoshTheme` | Cambiar tema permanentemente |
| `syncprofile` | `Sync-Profile` | Copiar $PROFILE a dotfiles + sincronizar |

### Ejemplos de Uso

```powershell
# Verificar estado del sistema
ompinfo

# Probar un tema temporalmente
testtheme catppuccin

# Volver al tema original
romp

# Cambiar tema permanentemente
settheme night-owl

# Crear backup manual
backupomp

# Sincronizar con GitHub
syncdf
```

---

## 📁 Estructura del Repositorio

```
dotfiles/
├── 📄 install.ps1                      # Script instalador (v2.2.0)
├── 📄 .gitignore                       # Reglas de ignorado
├── 📄 README.md                        # Este archivo
├── 📄 VERSIONS.md                      # Historial de versiones
├── 📄 LICENSE                          # Licencia MIT
│
├── 📂 versions/                        # Todas las versiones del instalador
│   ├── v1.0.0/
│   │   ├── install.ps1
│   │   └── CHANGELOG.md
│   ├── v2.0.0/
│   │   ├── install.ps1
│   │   └── CHANGELOG.md
│   ├── v2.1.0/
│   │   ├── install.ps1
│   │   └── CHANGELOG.md
│   └── v2.2.0/                         # Versión actual
│       ├── install.ps1
│       └── CHANGELOG.md
│
├── 📂 oh-my-posh/                      # Configuraciones de Oh My Posh
│   └── carlos-optimized.omp.json       # Configuración optimizada
│
├── 📂 powershell/                      # Perfil de PowerShell
│   └── Microsoft.PowerShell_profile.ps1
│
└── 📂 users/                           # Temas personalizados de usuarios
    └── [nombre-usuario]/
        └── [tema].omp.json
```

---

## 🎨 Flujo del Instalador

```
┌─────────────────────────────────────────────────────────┐
│  1. Verificación de permisos                            │
│  2. Selección de rutas (una por una)                    │
│  3. Confirmación de rutas antes de crear                │
│  4. Creación de carpetas                                │
│  5. Instalación de Oh My Posh (5 métodos)               │
│  6. Configuración de fuentes Nerd Font                  │
│  7. Selección de tipo de configuración                  │
│  8. Creación de tema personalizado (opcional)           │
│  9. Configuración del perfil de PowerShell              │
│ 10. Sincronización con GitHub (opcional)                │
│ 11. Verificación completa del sistema (opcional)        │
│ 12. Reporte final de dónde se guardó todo               │
└─────────────────────────────────────────────────────────┘
```

---

## 🎯 Métodos de Instalación de Oh My Posh

El instalador soporta **5 métodos** diferentes:

| Método | Comando | Requiere |
|--------|---------|----------|
| **Winget** | `winget install JanDeDobbeleer.OhMyPosh` | Windows 10/11 |
| **Chocolatey** | `choco install oh-my-posh` | Chocolatey instalado |
| **Manual** | Descargar desde GitHub | Navegador web |
| **Scoop** | `scoop install oh-my-posh` | Scoop instalado |
| **Saltar** | N/A | N/A |

---

## 🖥️ Capturas de Pantalla

### Tema Carlos-Optimized
```
 Carlos   ~\Documents\PowerShell   main  ✓  14:30:45
❯
```

### Tema Catppuccin
```
  Carlos@LENOVO  ~\....\dotfiles   main  ✓  14:30:45
❯
```

---

## 📊 Rendimiento

| Métrica | Valor | Estado |
|---------|-------|--------|
| **Tiempo de carga** | ~350ms | ✅ Óptimo (<500ms) |
| **Mejora vs inicial** | 53% | ✅ Reducido de ~743ms |
| **Alias disponibles** | 12 | ✅ Todos funcionales |
| **Temas soportados** | 100+ | ✅ Catálogo completo |
| **Backups automáticos** | Sí | ✅ Con timestamp |

---

## 🔐 Seguridad

### Lo que SÍ se sincroniza con GitHub

- ✅ Scripts de instalación (`.ps1`)
- ✅ Configuraciones de Oh My Posh (`.omp.json`)
- ✅ Perfil de PowerShell
- ✅ Documentación (`.md`)

### Lo que NO se sincroniza con GitHub

- ❌ Backups de configuraciones
- ❌ Credenciales y claves SSH
- ❌ Archivos temporales del editor
- ❌ Archivos del sistema operativo

---

## 🤝 Contribuir

### Cómo Contribuir

1. Haz un **fork** del repositorio
2. Crea una **rama** para tu feature (`git checkout -b feature/AmazingFeature`)
3. Haz **commit** de tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Haz **push** a la rama (`git push origin feature/AmazingFeature`)
5. Abre un **Pull Request**

### Estándares de Código

- Usa **PowerShell 7.0+**
- Sigue las **mejores prácticas de PowerShell**
- Documenta todas las **funciones y parámetros**
- Incluye **comentarios** en español

---

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

```
MIT License

Copyright (c) 2026 Carlos Daniel Martínez Reynoso

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🔗 Enlaces Útiles

| Recurso | Enlace |
|---------|--------|
| **Repositorio** | https://github.com/Carlos007-gif/dotfiles |
| **Oh My Posh** | https://ohmyposh.dev |
| **Documentación Oh My Posh** | https://ohmyposh.dev/docs |
| **Temas Disponibles** | https://ohmyposh.dev/docs/themes |
| **PowerShell** | https://github.com/PowerShell/PowerShell |
| **Nerd Fonts** | https://www.nerdfonts.com |
| **Winget** | https://aka.ms/winget-cli |
| **Chocolatey** | https://chocolatey.org |
| **Scoop** | https://scoop.sh |

---

## 📞 Contacto

| | |
|---|---|
| **GitHub** | [@Carlos007-gif](https://github.com/Carlos007-gif) |
| **Universidad** | FCFM-UANL |
| **Carrera** | Ciencias Computacionales y Ciberseguridad |
| **Ubicación** | Monterrey, Nuevo León, México |

---

## ⭐ Agradecimientos

- [Jan De Dobbeleer](https://github.com/JanDeDobbeleer) - Creador de [Oh My Posh](https://github.com/JanDeDobbeleer/oh-my-posh)
- [Comunidad de PowerShell](https://powershell.org) - Recursos y documentación
- [Nerd Fonts](https://www.nerdfonts.com) - Fuentes para íconos
- [FCFM-UANL](https://fcfm.uanl.mx) - Universidad y apoyo académico

---

## 📈 Estadísticas del Proyecto

| Métrica | Valor |
|---------|-------|
| **Versiones lanzadas** | 4 |
| **Versión actual** | 2.2.0 |
| **Última actualización** | 19/03/2026 |
| **Alias incluidos** | 12 |
| **Métodos de instalación** | 5 |
| **Temas soportados** | 100+ |
| **Idioma** | Español |
| **Compatibilidad** | Windows 10/11, PowerShell 7.0+ |

---

<div align="center">

**Hecho con ❤️ por Carlos Daniel Martínez Reynoso**

[⬆️ Volver al inicio](#-dotfiles---instalador-oh-my-posh)

</div>
```

---

## 🚀 Comandos para Aplicar el README.md

```powershell
# ═══════════════════════════════════════════════════════════════
# APLICAR README.MD MEJORADO AL REPOSITORIO
# ═══════════════════════════════════════════════════════════════

# 1. Navegar al repositorio
Set-Location "$env:USERPROFILE\GitHub\dotfiles"

# 2. Crear backup del README anterior (si existe)
if (Test-Path "README.md") {
    Copy-Item "README.md" "README.md.backup" -Force
    Write-Host "✓ Backup creado: README.md.backup" -ForegroundColor Green
}

# 3. Abrir README.md para editar
notepad "README.md"

# 4. Pegar el contenido completo de arriba y guardar

# 5. Verificar que se ve bien
Get-Content "README.md" | Select-Object -First 20

# 6. Agregar, commitear y hacer push
git add README.md
git commit -m "docs: mejorar README.md con documentación completa del proyecto"
git push

Write-Host "✓ README.md actualizado y sincronizado con GitHub" -ForegroundColor Green
```

---

## ✅ Checklist de Verificación del README.md

```
┌─────────────────────────────────────────────────────────┐
│  ✅ CHECKLIST DEL README.MD                             │
├─────────────────────────────────────────────────────────┤
│  ☐ Badge de versión incluido                           │
│  ☐ Información del autor completa                       │
│  ☐ Descripción del proyecto clara                       │
│  ☐ Inicio rápido con comandos                           │
│  ☐ Requisitos previos listados                          │
│  ☐ Tabla de versiones completa                          │
│  ☐ 12 alias documentados                                │
│  ☐ Estructura de carpetas mostrada                      │
│  ☐ Flujo del instalador explicado                       │
│  ☐ Métodos de instalación listados                      │
│  ☐ Estadísticas de rendimiento                          │
│  ☐ Sección de seguridad incluida                        │
│  ☐ Guía de contribución                                 │
│  ☐ Licencia MIT completa                                │
│  ☐ Enlaces útiles incluidos                             │
│  ☐ Información de contacto                              │
│  ☐ Agradecimientos                                      │
│  ☐ Estadísticas del proyecto                            │
└─────────────────────────────────────────────────────────┘
```

---

## 📊 Comparación: README Anterior vs Nuevo

| Sección | Antes | Después |
|---------|-------|---------|
| **Badges** | ❌ | ✅ 4 badges |
| **Autor** | Básico | ✅ Completo con tabla |
| **Descripción** | Corta | ✅ Detallada con features |
| **Inicio rápido** | ❌ | ✅ Paso a paso |
| **Versiones** | ❌ | ✅ Tabla completa |
| **Alias** | Parcial | ✅ 12 alias documentados |
| **Estructura** | ❌ | ✅ Árbol visual |
| **Seguridad** | ❌ | ✅ Qué sí/no se sincroniza |
| **Contribuir** | ❌ | ✅ Guía completa |
| **Licencia** | ❌ | ✅ MIT completa |
| **Enlaces** | Básicos | ✅ 9 enlaces útiles |
| **Estadísticas** | ❌ | ✅ 8 métricas |

---

¿Desea que le ayude a aplicar este README.md en su repositorio, Carlos? 🚀📄
