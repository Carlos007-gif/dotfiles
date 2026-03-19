# Changelog - Versión 2.1.0

**Fecha:** 19/03/2026  
**Estado:** 📜 Histórica  
**Autor:** Carlos Daniel Martínez Reynoso  
**Universidad:** FCFM-UANL  
**Carrera:** Ciencias Computacionales y Ciberseguridad

---

## 📋 Resumen de la versión

v2.1.0 mejora la flexibilidad de instalación y la experiencia de usuario con:

- 5 métodos de instalación (winget, chocolatey, scoop, manual, salto)
- verificación opcional, autosuficiente y con resultados detallados
- mejores mensajes de error y recuperación
- instalación guiada de fuentes Nerd Font

---

## 🆕 Novedades principales

1. Soporte multiplataforma de instalación
   - winget, chocolatey, scoop, manual (GitHub release), saltar instalación.
   - Validación de requisitos antes de ejecutar cada método.

2. Winget mejorado
   - se usa `--silent`, `--accept-package-agreements`, recarga PATH.
   - control de códigos de salida + mensajes de estado claros.

3. Chocolatey mejorado
   - `choco install oh-my-posh -y`
   - instrucciones si no está instalado.

4. Scoop mejorado
   - `scoop install oh-my-posh`
   - instalación y comprobación de `scoop` antes de usar.

5. Instalación manual mejorada
   - enlaces directos a GitHub Releases
   - pasos MSI y verificación post-instalación

6. Verificación opcional de instalación
   - pregunta al usuario
   - muestra número de elementos verificados y porcentaje de éxito
   - si Oh My Posh ya está instalado valida configuración.

7. Instalar Nerd Font (opcional)
   - comando `oh-my-posh font install meslo`
   - guía paso a paso y verificación posterior.

8. Mensajes de error mejorados
   - códigos y texto legible
   - enlaces de solución y alternativas propuestas

---

## 🔄 Cambios respecto a v2.0.0

- Métodos de instalación: 1 → 5.
- Verificación final: forzada → opcional + porcentaje.
- Reporte: simple → detallado.
- Fuentes: manual → asistida.
- Diagnóstico de errores: básico → sugerencias con enlaces.

---

## ⚙️ Uso

```powershell
# Ejecutar instalador de v2.1.0
.\versions\v2.1.0\install_v2_1_0.ps1
```

---

## 🔗 Referencias

- Repositorio: https://github.com/Carlos007-gif/dotfiles
- Oh My Posh: https://ohmyposh.dev
- Winget: https://aka.ms/winget-cli
- Chocolatey: https://chocolatey.org
- Scoop: https://scoop.sh

---

## ⚠️ Limitaciones conocidas

- Requiere conexión a internet para instalaciones desde repositorios externos.
- Productos externos (winget/choco/scoop) deben tener permisos de administrador.
- Si no se dispone de ningún gestor de paquetes, se sugiere el modo manual.

---

## 📝 Notas finales

- Recomendado para usuarios que quieran probar la instalación flexible en Windows 10/11.
- Mejora la experiencia de usuario en etapas tempranas de setup.
- Para instalaciones nuevas con gestión avanzada de rutas y reporte, usar v2.2.0.

---

## 🔗 Enlaces rápidos

- Repositorio: https://github.com/Carlos007-gif/dotfiles
- Oh My Posh: https://ohmyposh.dev
- Winget: https://aka.ms/winget-cli
- Chocolatey: https://chocolatey.org
- Scoop: https://scoop.sh
