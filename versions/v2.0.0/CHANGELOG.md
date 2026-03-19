---

## 📂 v2.0.0 - `versions/v2.0.0/CHANGELOG.md`

```markdown
# Changelog - Versión 2.0.0

**Fecha:** 19/03/2026  
**Estado:** 📜 Histórica  
**Autor:** Carlos Daniel Martínez Reynoso  
**Universidad:** FCFM-UANL  
**Carrera:** Ciencias Computacionales y Ciberseguridad

---

## 📋 Resumen de la versión

v2.0.0 introduce creador interactivo de temas y soporte multiusuario con directorio `users/`, mejorando la personalización y colaboración en equipo de Oh My Posh.

---

## 🆕 Novedades principales

1. Carpeta `users/` en el repositorio
   - Espacio propio para cada usuario: `users/[usuario]/[tema].omp.json`
   - Soporta múltiples usuarios y configuraciones dentro del mismo repo
   - Facilita el intercambio de temas en equipos

2. Creador de temas interactivo
   - Guía paso a paso para crear un tema nuevo
   - Solicita nombre de usuario y nombre de tema
   - Genera plantilla inicial, abre editor y valida JSON

3. Selección de editor desde script
   - Opciones: VS Code, VS Code Insiders, Notepad++, Notepad, editor personalizado
   - Abre editor elegido y espera cierre para continuar

4. Validación automática de temas
   - Comprueba JSON sintáctico
   - Valida estructura mínima (`version`, `blocks`)
   - Ofrece re-edición si hay errores

5. Mejora de la experiencia de cierre
   - Confirma satisfacción del usuario antes de guardar
   - Permite iterar varias veces con ajustes

---

## 🔄 Cambios respecto a v1.0.0

- carpeta `users/`: ❌ → ✅
- creador de temas: ❌ → ✅
- selección de editor: ❌ → ✅
- validación de temas: ❌ → ✅
- re-edición: ❌ → ✅

---

## ⚙️ Uso

```powershell
# Ejecutar instalador de v2.0.0
.\versions\v2.0.0\install_v2_0_0.ps1
```

### Flujo recomendado: creación de tema personalizado

1. Seleccionar opción 3 en el menú
2. Proveer nombre de usuario
3. Proveer nombre de tema
4. Elegir editor de código
5. Editar el archivo generado
6. Validar y guardar

---

## 🔗 Referencias

- Repositorio: https://github.com/Carlos007-gif/dotfiles
- Oh My Posh: https://ohmyposh.dev

---

## ⚠️ Limitaciones conocidas

- Winget es el método principal (no hay módulos de instalación alternativos)
- No hay selección de rutas en esta versión (predeterminadas)
- Verificación de instalación no es opcional
- Versiones nuevas recomiendan migrar a v2.2.0

---

## 📝 Nota para desarrolladores

Versión histórica para referencia y pruebas de evolución. Mantener solo para comparación y debugging de cambios de UX en temas/usuarios.
