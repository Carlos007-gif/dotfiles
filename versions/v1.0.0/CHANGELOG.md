# Changelog - Versión 1.0.0

**Fecha:** 19/03/2026  
**Estado:** 📜 Histórica  
**Autor:** Carlos Daniel Martínez Reynoso  
**Universidad:** FCFM-UANL  
**Carrera:** Ciencias Computacionales y Ciberseguridad

---

## 📋 Resumen de la versión

Esta primera versión sienta las bases del instalador automatizado de Oh My Posh y entrega un proceso confiable para:

- instalación vía winget
- estructura de carpetas y perfil PowerShell
- sincronización con repositorio local y remoto
- verificación y reporte de estado

---

## 🆕 Características principales

1. Instalación de Oh My Posh
   - Método principal: winget
   - Verificación de permisos de administrador
   - Manejo de errores con mensajes legibles

2. Estructura de carpetas creada automáticamente
   - `oh-my-posh/` (temas)
   - `oh-my-posh-configs/` (configuraciones)
   - `oh-my-posh-configs/backups/`
   - `GitHub/dotfiles/` (repositorio de dotfiles)
   - `Documents/PowerShell/` (localización de `$PROFILE`)

3. Configuración del perfil PowerShell
   - Creación de `$PROFILE` si no existe
   - Alias útiles incluidos:
     - `testomp`: validar configuración
     - `eompc`: editar configuración
     - `romp`: recargar Oh My Posh
     - `updateomp`: actualizar paquete
     - `backupomp`: crear copia de seguridad
     - `syncdf`: sincronizar con GitHub
     - `testtheme`: probar tema
     - `listthemes`: listar temas instalados
     - `testtopthemes`: demo de temas
     - `ompinfo`: estado de instalación
     - `settheme`: cambiar tema
     - `syncprofile`: sincronizar perfil

4. GitHub integrado
   - Clona el repositorio dotfiles
   - Copia configuración de OMP dentro del repo
   - Commit y push inicial (si es aplicable)

5. Verificación post-instalación
   - Comprobación básica de éxito
   - Reporte de salidas en consola

---

## 🔧 Uso

```powershell
# Ejecutar esta versión
.\versions\v1.0.0\install_v1_0_0.ps1
```

---

## 🔗 Recursos

- Repositorio: https://github.com/Carlos007-gif/dotfiles
- Oh My Posh: https://ohmyposh.dev

---

## ⚠️ Limitaciones iniciales

- Winget es obligatorio en esta primera versión.
- No aplica versiones de instalación alternativas (chocolatey/scoop/manual).
- El proceso asume conexión a Internet.
