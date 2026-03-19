# Dotfiles de Carlos Daniel Martínez Reynoso

Repositorio de configuración personal para desarrollo en Windows con PowerShell y estética de CLI.
Incluye ajustes para productividad, terminal y seguridad, listos para instalar en equipos nuevos.

## 🌟 ¿Qué incluye?

- `install.ps1` - Script principal de instalación y enlace de archivos.
- `oh-my-posh/` - Temas y perfiles de Oh My Posh:
  - `carlos-optimized.omp.json` - Tema optimizado con información útil y lectura clara.

## 🧩 Requisitos previos

- Windows 10/11.
- PowerShell 7+ (recomendado) o PowerShell 5.1.
- Oh My Posh instalado (o el instalador del script puede ajustar tu entorno).
- Git para clonar el repositorio.

## 🚀 Instalación rápida

Abre PowerShell con permisos de usuario y ejecuta:

```powershell
git clone https://github.com/Carlos007-gif/dotfiles.git
cd dotfiles
.
\install.ps1
```

> Si estás en carpeta con ejecución de scripts deshabilitada, usa:
> `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` (solo si confías en el repositorio).

## 🔧 Personalización

1. Revisa `oh-my-posh/carlos-optimized.omp.json` y ajusta secciones/colores según tus preferencias.
2. Agrega más dotfiles (por ejemplo, `profile.ps1`, `gitconfig`, alias) al repositorio.
3. En el `install.ps1`, añade lógicas de backup y restauración si lo deseas.

## 🛡️ Buenas prácticas

- Haz respaldo de tus dotfiles actuales antes de instalar.
- Versiona tus ajustes con commits pequeños al modificar.
- Contribuye con `issues` y `pull requests` si quieres colaborar.

## 📄 Licencia

MIT License. Usa, modifica y redistribuye con atribución.
