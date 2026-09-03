# 💜 Tema Morado Futurista para Ptyxis

Tema de terminal estilo **cyberpunk** con colores morados, neones y efectos futuristas inspirados en seguridad digital y programación.

![Status](https://img.shields.io/badge/Status-Active-brightgreen)
![License](https://img.shields.io/badge/License-MIT-blue)
![Terminal](https://img.shields.io/badge/Terminal-Ptyxis-purple)

---

## 🎨 Paleta de Colores

| Color | Hex | RGB | Uso |
|-------|-----|-----|-----|
| **Fondo** | `#0a0014` | `rgb(10, 0, 20)` | Fondo principal (negro profundo) |
| **Texto** | `#e0b0ff` | `rgb(224, 176, 255)` | Texto principal (lavanda) |
| **Cursor** | `#ff00ff` | `rgb(255, 0, 255)` | Cursor activo (magenta) |
| **Selección** | `#4d0099` | `rgb(77, 0, 153)` | Texto seleccionado (morado oscuro) |
| **Rojo** | `#ff1493` | `rgb(255, 20, 147)` | Errores y alertas |
| **Verde** | `#00ff88` | `rgb(0, 255, 136)` | Éxito y comandos |
| **Amarillo** | `#ffaa00` | `rgb(255, 170, 0)` | Advertencias |
| **Azul** | `#7700ff` | `rgb(119, 0, 255)` | Información |
| **Cian** | `#00ffff` | `rgb(0, 255, 255)` | Acentos brillantes |

---

## 📦 Instalación Rápida

### Opción 1: Script Automático Fedora + Ptyxis 5.0 (Recomendado)

```bash
chmod +x install-fedora.sh
./install-fedora.sh
```

El script hará todo automáticamente:
- ✅ Detectar instalación y versión de Ptyxis
- ✅ Aplicar el tema al perfil activo (UUID dinámico)
- ✅ Verificar claves críticas y mostrar diagnóstico

### Opción 2: Instalación Manual

#### Paso 1: Aplicar directamente al perfil activo
```bash
bash ./install-ptyxis50.sh
```

#### Paso 2: Verificar resultado
```bash
bash ./verify-ptyxis50.sh
```

#### Paso 3: Recargar Ptyxis
```bash
bash ~/.config/ptyxis/restart-with-theme.sh
```

---

## ⚙️ Activar el Tema

### Método 1: GUI (Interfaz Gráfica)
1. Abre **Ptyxis**
2. Ve a **☰ Menú** → **Preferencias**
3. Selecciona **Apariencia** o **Temas**
4. Busca y haz clic en **"Purple Cyberpunk"**
5. El cambio se aplica inmediatamente

### Método 2: Línea de Comandos (perfil UUID real)
```bash
# Leer UUID activo
UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")
# Ver color aplicado
dconf read /org/gnome/Ptyxis/Profiles/${UUID}/background-color
```

### Método 3: Edición Manual
```bash
# Editar configuración manualmente
dconf-editor

# Navega a: /org/gnome/Ptyxis/Profiles/<UUID_ACTIVO>
# UUID_ACTIVO=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")
```

---

## 🛠️ Solución de Problemas

### El tema no aparece o no se aplica

**Solución 1:** Reinicia Ptyxis completamente
```bash
killall ptyxis
sleep 2
ptyxis &
```

**Solución 2:** Verifica que los archivos están en el lugar correcto
```bash
ls -la ~/.config/ptyxis/schemes/
# Deberías ver: purple-cyberpunk.xml y purple-cyberpunk.dconf
```

**Solución 3:** Ejecuta diagnóstico completo
```bash
bash ./verify-ptyxis50.sh
```

### Los colores no se ven correctamente

**Verifica que el terminal soporta 256 colores:**
```bash
echo $TERM
# Debería mostrar: xterm-256color o screen-256color
```

Si no es así, configúralo:
```bash
export TERM=xterm-256color
```

### Problemas de opacidad

Si quieres ajustar la transparencia:
```bash
gsettings set org.gnome.Ptyxis opacity 0.90
# Valores: 0.0 (transparente) a 1.0 (opaco)
```

---

## 📋 Archivos Incluidos

```
TEMATERMINAL/
├── install-purple-theme.sh          # Script de instalación automática
├── README.md                        # Este archivo
├── purple-cyberpunk.xml             # Definición del tema (XML)
├── purple-cyberpunk.dconf           # Configuración DConf
└── purple-cyberpunk.json            # Configuración JSON
```

---

## 🎯 Características

- 🎨 **Paleta morada futurista** - Diseño cyberpunk auténtico
- ⚡ **Alto contraste** - Texto legible en lavanda sobre fondo oscuro
- 🌈 **16 colores estándar** - Compatible con la mayoría de aplicaciones
- 🔧 **Múltiples formatos** - XML, JSON y DConf
- 🚀 **Instalación rápida** - Script automatizado
- 💾 **Configuración persistente** - Cambios se guardan automáticamente

---

## 🖥️ Compatibilidad

| Componente | Versión | Estado |
|-----------|---------|--------|
| **Ptyxis** | 5.0+ | ✅ Completa |
| **GNOME** | 45+ | ✅ Completa |
| **Linux** | Cualquiera | ✅ Completa |
| **macOS** | N/A | ❌ No soportado |
| **Windows** | WSL2 | ✅ Parcial |

---

## 🎓 Personalización Avanzada

### Cambiar solo el color de fondo

```bash
UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")
dconf write /org/gnome/Ptyxis/Profiles/${UUID}/background-color "'rgb(10, 0, 20)'"
```

### Cambiar solo el color del texto

```bash
UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")
dconf write /org/gnome/Ptyxis/Profiles/${UUID}/foreground-color "'rgb(224, 176, 255)'"
```

### Cambiar el cursor

```bash
UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")
dconf write /org/gnome/Ptyxis/Profiles/${UUID}/cursor-background-color "'rgb(255, 0, 255)'"
```

### Cambiar la fuente

```bash
gsettings set org.gnome.Ptyxis monospace-font-name 'Monospace 12'
```

---

## 📸 Vista Previa

```
┌─────────────────────────────────────┐
│ 💜 Terminal Morada Futurista      │
├─────────────────────────────────────┤
│ $ ls -la                            │
│ drwxr-xr-x  10 user  staff  320 B   │
│ -rw-r--r--   1 user  staff  1.2 KB  │
│ -rwxr-xr-x   1 user  staff  7.4 KB  │
│ $ npm start                         │
│ ✅ Server running on port 3000      │
│ $ git commit -m "Update theme"      │
│ [main 7693941] Agregar tema morado  │
│ $ █                                  │
└─────────────────────────────────────┘
```

**Colores visibles:**
- Fondo: Negro profundo (#0a0014)
- Texto: Lavanda (#e0b0ff)
- Directorios: Verde neón (#00ff88)
- Archivos: Lavanda (#e0b0ff)
- Errores: Magenta/Rosa (#ff1493)
- Cursor: Magenta brillante (#ff00ff)

---

## 💡 Consejos de Uso

1. **Para máximo contraste**: Asegúrate de que tu monitor está bien calibrado
2. **Para ojos sensibles**: Usa el tema en un lugar bien iluminado
3. **Para sesiones largas**: La paleta morada es más cómoda que el verde tradicional
4. **Combina con**: Usa una fuente monoespaciada como `Fira Code` o `JetBrains Mono`

---

## 🔗 Recursos Útiles

- [Documentación de Ptyxis](https://gnome.pages.gitlab.com/ptyxis/)
- [DConf Settings](https://wiki.gnome.org/Projects/dconf)
- [GNOME Terminal Colors](https://help.gnome.org/users/gnome-terminal/stable/pref-custom-command.html)

---

## 📝 Licencia

Este proyecto está bajo licencia **MIT**. Siéntete libre de:
- ✅ Usar el tema
- ✅ Modificarlo
- ✅ Compartirlo
- ✅ Mejorarlo

---

## 👤 Autor

**h4tt3r-xplo1t**

*Tema inspirado en estética cyberpunk y seguridad digital futurista*

---

## 🐛 Reportar Problemas

Si encuentras un problema:
1. Verifica los pasos de solución de problemas arriba
2. Comprueba que Ptyxis está actualizado
3. Abre un issue en el repositorio

---

## 🎉 ¡Disfruta tu nueva terminal morada!

```
    ███████╗███████╗███████╗███████╗
    ██╔════╝██╔════╝██╔════╝██╔════╝
    ███████╗███████╗███████╗███████╗
    ╚════██║╚════██║╚════██║╚════██║
    ███████║███████║███████║███████║
    ╚══════╝╚══════╝╚══════╝╚══════╝
    
    💜 Purple Cyberpunk Theme 💜
```

---

**Última actualización:** 2026-09-03  
**Versión:** 1.1
