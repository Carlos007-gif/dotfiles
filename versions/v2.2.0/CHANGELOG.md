# Changelog - Versión 2.2.0

**Fecha:** 19/03/2026  
**Estado:** ✅ ACTUAL  
**Autor:** Carlos Daniel Martínez Reynoso  
**Universidad:** FCFM-UANL  
**Carrera:** Ciencias Computacionales y Ciberseguridad

---

## 📋 Resumen de la versión

v2.2.0 es la versión recomendada para nuevas instalaciones y usuarios avanzados. Se enfoca en:

- Control total de rutas (ingreso individual + confirmación)
- Reporte final detallado (rutas, carpetas y archivos)
- Mejora de mensajes visuales y de estado
- Compatibilidad con versiones previas (v2.0.0, v2.1.0)

---

## 🆕 Novedades clave

1. Selección interactiva de rutas
   - Ruta base, dotfiles y perfil de PowerShell
   - Opciones: usar predeterminada o ingresar ruta propia
   - Validación y corrección de ruta

2. Confirmación antes de la creación
   - Resumen de rutas elegido
   - Confirmar o cancelar
   - Mensaje de cancelación claro

3. Reporte final mejorado
   - Secciones: rutas usadas, carpetas creadas, archivos generados
   - Indicadores visuales (✅ / ⚠️ / ❌)

4. Estado detallado en instalación
   - Creamos solo si no existe (idempotente)
   - Mostrar carpetas creadas vs existentes
   - Verificar y mostrar estado de Oh My Posh y perfil PowerShell

---

## 🔄 Comparación con v2.1.0

- Pregunta rutas: de parcial → individual
- Confirmación: de no disponible → resumen y confirmación
- Reporte final: básico → detallado y categorizado
- Carpeta/archivo: lista simple → árbol con resultados y descripciones
- Iconos: algunos → consistente en toda la salida

---

## ⚙️ Comandos (uso recomendado)

```powershell
# Desde la raíz del repositorio
.\install.ps1

# Desde la versión concreta
.\versions\v2.2.0\install_v2_2_0.ps1

# Ver estado
ompinfo

# Validar configuración
testomp

# Ver rutas actuales
echo $OhMyPoshConfig
echo $PROFILE
```

---

## 📌 Notas de uso

- Ideal cuando winget no está disponible.
- Recomendado para configuraciones personalizadas o no estándar.
- Para instalaciones nuevas: usar v2.2.0.

---

## 🔗 Recursos

- Repositorio: https://github.com/Carlos007-gif/dotfiles
- Oh My Posh: https://ohmyposh.dev
- Winget: https://aka.ms/winget-cli
- Chocolatey: https://chocolatey.org
- Scoop: https://scoop.sh

---

## ⚠️ Limitaciones conocidas

- Ninguna relevante en esta versión.
- Revisar logs de instalación si hay rutas con permisos bloqueados.

Todas las características de versiones anteriores
🔗 Enlaces
Repositorio: https://github.com/Carlos007-gif/dotfiles
Oh My Posh: https://ohmyposh.dev
Documentación: https://ohmyposh.dev/docs
Versión anterior: v2.1.0
Próxima versión: v2.3.0 (en desarrollo)
📈 Estadísticas de Esta Versión
Líneas de código: ~800+
Funciones: 15+
Alias: 12
Métodos de instalación: 5
Rutas personalizables: 3
Idioma: Español
Compatibilidad: Windows 10/11, PowerShell 7.0+

---

## 📋 Resumen de Todos los CHANGELOG.md

| Versión    | Archivo                        | Contenido Principal                              |
| ---------- | ------------------------------ | ------------------------------------------------ |
| **v1.0.0** | `versions/v1.0.0/CHANGELOG.md` | Script base, 12 alias, estructura básica         |
| **v2.0.0** | `versions/v2.0.0/CHANGELOG.md` | Carpeta `users/`, creador de temas, editor       |
| **v2.1.0** | `versions/v2.1.0/CHANGELOG.md` | 5 métodos de instalación, verificación opcional  |
| **v2.2.0** | `versions/v2.2.0/CHANGELOG.md` | Rutas individuales, reporte final, control total |

---

## 🚀 Comandos para Crear Todos los CHANGELOG.md

```powershell
# Ir al repositorio
Set-Location "$env:USERPROFILE\GitHub\dotfiles"

# Crear carpetas de versiones
New-Item -ItemType Directory -Path "versions\v1.0.0", "versions\v2.0.0", "versions\v2.1.0", "versions\v2.2.0" -Force

# Crear cada CHANGELOG.md
notepad "versions\v1.0.0\CHANGELOG.md"   # Pegar contenido v1.0.0
notepad "versions\v2.0.0\CHANGELOG.md"   # Pegar contenido v2.0.0
notepad "versions\v2.1.0\CHANGELOG.md"   # Pegar contenido v2.1.0
notepad "versions\v2.2.0\CHANGELOG.md"   # Pegar contenido v2.2.0

# Crear VERSIONS.md en la raíz
notepad "VERSIONS.md"  # Pegar contenido del VERSIONS.md

# Sincronizar con GitHub
git add .
git commit -m "docs: agregar CHANGELOG.md para todas las versiones (v1.0.0 - v2.2.0)"
git push

```
