# 🎨 Dotfiles - Instalador Oh My Posh

[![Versión](https://img.shields.io/badge/versión-2.2.0-blue)](https://github.com/Carlos007-gif/dotfiles/releases)
[![PowerShell](https://img.shields.io/badge/PowerShell-7.0+-blue)](https://github.com/PowerShell/PowerShell)
[![Oh My Posh](https://img.shields.io/badge/Oh%20My%20Posh-29.9.0+-yellow)](https://ohmyposh.dev)
[![Licencia](https://img.shields.io/badge/licencia-MIT-green)](LICENSE)

> Configuración profesional de Oh My Posh para PowerShell con instalador automatizado.

---

## 👤 Autor

- **Nombre:** Carlos Daniel Martínez Reynoso
- **Universidad:** Facultad de Ciencias Físico-Matemáticas, UANL
- **Carrera:** Licenciatura en Ciencias Computacionales y Ciberseguridad
- **GitHub:** [@Carlos007-gif](https://github.com/Carlos007-gif)

---

## 📋 Descripción

Este repositorio ofrece una configuración **profesional y optimizada** de Oh My Posh para PowerShell y un instalador interactivo que permite:

- Instalar Oh My Posh automáticamente
- Personalizar temas y alias
- Crear el perfil de PowerShell y sincronizarlo con GitHub
- Validar el estado completo del entorno

---

## 🚀 Inicio Rápido

1. Clona el repositorio:

```powershell
git clone https://github.com/Carlos007-gif/dotfiles.git $env:USERPROFILE\GitHub\dotfiles
```

2. Cambia al directorio del repo:

```powershell
Set-Location $env:USERPROFILE\GitHub\dotfiles
```

3. Ejecuta el instalador:

```powershell
.\install.ps1
```

---

## 🛠️ Requisitos previos

| Requisito  | Versión mínima | Cómo verificar              |
| ---------- | -------------- | --------------------------- |
| Windows    | 10/11          | `winver`                    |
| PowerShell | 7.0+           | `$PSVersionTable.PSVersion` |
| Git        | 2.0+           | `git --version`             |
| Oh My Posh | 29.9.0+        | `oh-my-posh version`        |

---

## 📦 Versiones disponibles

| Versión | Fecha      | Estado       | Cambios principales                                   |
| ------- | ---------- | ------------ | ----------------------------------------------------- |
| 2.2.0   | 19/03/2026 | ✅ Actual    | Selección de rutas individual, reporte final de rutas |
| 2.1.0   | 19/03/2026 | 📜 Histórica | Métodos de instalación, verificación opcional         |
| 2.0.0   | 19/03/2026 | 📜 Histórica | Carpeta `users/`, creador de temas, editor de código  |
| 1.0.0   | 19/03/2026 | 📜 Histórica | Script base con instalación básica                    |

### ¿Qué versión usar?

| Caso de uso                | Versión recomendada              |
| -------------------------- | -------------------------------- |
| Instalación nueva          | v2.2.0 (actual)                  |
| Control total de rutas     | v2.2.0                           |
| Múltiples métodos          | v2.1.0                           |
| Crear temas personalizados | v2.0.0 o superior                |
| Estudio/Comparación        | Cualquier versión en `versions/` |

---

## 🔧 Alias incluidos

Después de la instalación, estos alias quedan disponibles:

| Alias           | Comando                 | Descripción                                |
| --------------- | ----------------------- | ------------------------------------------ |
| `testomp`       | `Test-OhMyPoshConfig`   | Validar configuración JSON                 |
| `eompc`         | `Edit-OhMyPoshConfig`   | Editar configuración en Notepad            |
| `romp`          | `Reload-OhMyPosh`       | Recargar Oh My Posh sin reiniciar          |
| `updateomp`     | `Update-OhMyPosh`       | Actualizar vía winget                      |
| `backupomp`     | `Backup-OhMyPoshConfig` | Crear backup con timestamp                 |
| `syncdf`        | `Sync-Dotfiles`         | Sincronizar con GitHub                     |
| `testtheme`     | `Test-OhMyPoshTheme`    | Probar tema temporalmente                  |
| `listthemes`    | `Get-OhMyPoshThemes`    | Listar temas disponibles                   |
| `testtopthemes` | `Test-TopThemes`        | Demo automática de 10 temas                |
| `ompinfo`       | `Get-OhMyPoshInfo`      | Información completa del estado            |
| `settheme`      | `Set-OhMyPoshTheme`     | Cambiar tema permanentemente               |
| `syncprofile`   | `Sync-Profile`          | Copiar `$PROFILE` a dotfiles + sincronizar |

---

## 🧩 Ejemplos de uso

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

## 📁 Estructura del repositorio

```
dotfiles/
├── install.ps1
├── .gitignore
├── README.md
├── VERSIONS.md
├── LICENSE
├── versions/
│   ├── v1.0.0/
│   ├── v2.0.0/
│   ├── v2.1.0/
│   └── v2.2.0/
├── oh-my-posh/
│   └── carlos-optimized.omp.json
├── powershell/
│   └── Microsoft.PowerShell_profile.ps1
└── users/
    └── [nombre-usuario]/
        └── [tema].omp.json
```

---

## 🛠️ Flujo del instalador

1. Verificación de permisos
2. Selección de rutas (una por una)
3. Confirmación de rutas antes de crear
4. Creación de carpetas
5. Instalación de Oh My Posh (5 métodos)
6. Configuración de fuentes Nerd Font
7. Selección de tipo de configuración
8. Creación de tema personalizado (opcional)
9. Configuración del perfil de PowerShell
10. Sincronización con GitHub (opcional)
11. Verificación completa del sistema (opcional)
12. Reporte final de dónde se guardó todo

---

## 🎯 Métodos de instalación de Oh My Posh

| Método     | Comando                                  | Requisito            |
| ---------- | ---------------------------------------- | -------------------- |
| Winget     | `winget install JanDeDobbeleer.OhMyPosh` | Windows 10/11        |
| Chocolatey | `choco install oh-my-posh`               | Chocolatey instalado |
| Manual     | Descargar desde GitHub                   | Navegador web        |
| Scoop      | `scoop install oh-my-posh`               | Scoop instalado      |
| Saltar     | N/A                                      | N/A                  |

---

## 📊 Métricas de rendimiento (v2.2.0)

| Métrica             | Valor   | Estado                 |
| ------------------- | ------- | ---------------------- |
| Tiempo de carga     | ~350 ms | ✅ Óptimo (<500 ms)    |
| Mejora vs inicial   | 53%     | ✅ Reducido de ~743 ms |
| Alias disponibles   | 12      | ✅ Todos funcionales   |
| Temas soportados    | 100+    | ✅ Catálogo completo   |
| Backups automáticos | Sí      | ✅                     |

---

## �️ Seguridad y sincronización

| Elemento                                  | Incluido | No incluido |
| ----------------------------------------- | -------- | ----------- |
| Scripts de instalación (.ps1)             | ✅       |             |
| Configuraciones de Oh My Posh (.omp.json) | ✅       |             |
| Perfil de PowerShell                      | ✅       |             |
| Documentación (.md)                       | ✅       |             |
| Backups de configuraciones                |          | ❌          |
| Credenciales o claves privadas            |          | ❌          |
| Archivos temporales del editor            |          | ❌          |
| Archivos del sistema operativo            |          | ❌          |

---

## 🤝 Cómo contribuir

1. Haz fork del repositorio.
2. Crea una rama para tu feature:
   - `git checkout -b feature/AmazingFeature`
3. Haz commit de tus cambios:
   - `git commit -m "Add some AmazingFeature"`
4. Sube tu rama:
   - `git push origin feature/AmazingFeature`
5. Abre un Pull Request en GitHub.

### Estándares de código

- Usa PowerShell 7.0+.
- Sigue las mejores prácticas de PowerShell.
- Documenta funciones y parámetros.
- Incluye comentarios en español donde aplique.

---

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para detalles completos.

```text
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

| 🌐 Recurso        | 🔗 Enlace                                                       |
| ----------------- | --------------------------------------------------------------- |
| **Repositorio**   | [GitHub - dotfiles](https://github.com/Carlos007-gif/dotfiles)  |
| **Oh My Posh**    | [Sitio Oficial](https://ohmyposh.dev)                           |
| **Documentación** | [Docs Oh My Posh](https://ohmyposh.dev/docs)                    |
| **Temas**         | [Catálogo Disponible](https://ohmyposh.dev/docs/themes)         |
| **PowerShell**    | [GitHub - PowerShell](https://github.com/PowerShell/PowerShell) |
| **Nerd Fonts**    | [Descargar Fuentes](https://www.nerdfonts.com)                  |
| **Winget**        | [Microsoft Package Manager](https://aka.ms/winget-cli)          |
| **Chocolatey**    | [Package Manager](https://chocolatey.org)                       |
| **Scoop**         | [Package Installer](https://scoop.sh)                           |

---

## 📞 Contacto

| Campo              | Valor                                              |
| ------------------ | -------------------------------------------------- |
| 👨‍💻 **GitHub**      | [@Carlos007-gif](https://github.com/Carlos007-gif) |
| 🎓 **Universidad** | FCFM-UANL                                          |
| 📚 **Carrera**     | Ciencias Computacionales y Ciberseguridad          |
| 📍 **Ubicación**   | Monterrey, Nuevo León, México 🇲🇽                   |

---

## ⭐ Agradecimientos

- **Jan De Dobbeleer** — Creador de Oh My Posh
- **Comunidad de PowerShell** — Recursos y documentación
- **Nerd Fonts** — Fuentes para íconos
- **FCFM-UANL** — Universidad y apoyo académico

---

## 📈 Estadísticas del Proyecto

| 📊 Métrica             | 📌 Valor                           |
| ---------------------- | ---------------------------------- |
| Versiones lanzadas     | **4**                              |
| Versión actual         | **2.2.0**                          |
| Última actualización   | **19/03/2026**                     |
| Alias incluidos        | **12**                             |
| Métodos de instalación | **5**                              |
| Temas soportados       | **100+**                           |
| Idioma                 | **Español** 🇪🇸                     |
| Compatibilidad         | **Windows 10/11, PowerShell 7.0+** |

<div align="center">

Hecho con ❤️ por Carlos Daniel Martínez Reynoso
