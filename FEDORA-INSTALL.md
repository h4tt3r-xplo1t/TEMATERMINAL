# 🐧 Guía de Instalación para FEDORA

## Tema Morado Cyberpunk en Ptyxis - Fedora + Ptyxis 5.0

Esta guía está optimizada específicamente para Fedora. Si estás usando otra distribución, consulta el README principal.

---

## ⚡ Instalación Rápida (Fedora)

### Paso 1: Verificar que Ptyxis esté instalado

```bash
# Verificar si Ptyxis está instalado
ptyxis --version

# Si no está instalado, instálalo:
sudo dnf install -y gnome-ptyxis

# Verificar dependencias de configuración
sudo dnf install -y glib2 dconf
```

### Paso 2: Ejecutar el script de instalación

```bash
# Descargar o clonar el repositorio
git clone https://github.com/h4tt3r-xplo1t/TEMATERMINAL.git
cd TEMATERMINAL

# Dar permisos de ejecución
chmod +x install-fedora.sh

# Ejecutar el script
./install-fedora.sh
```

### Paso 3: Aplicar el tema

```bash
# Verificar inmediatamente el resultado:
bash ./verify-ptyxis50.sh

# Reiniciar Ptyxis con el script generado:
bash ~/.config/ptyxis/restart-with-theme.sh
```

O manualmente:

```bash
# Opción A: Desde la GUI
1. Abre Ptyxis
2. Haz clic en ☰ (Menú)
3. Selecciona "Preferencias"
4. Busca "purple-cyberpunk" en Apariencia
5. Selecciona y aplica
```

---

## 🔧 Solución de Problemas en Fedora

### Problema 1: "El tema no aparece en la lista"

**Solución:**

```bash
# 1. Verificar que gsettings está disponible
gsettings list-schemas | grep ptyxis

# 2. Si no aparece, actualizar DConf
dconf update

# 3. Forzar recarga
killall -9 ptyxis
sleep 2
ptyxis &
```

### Problema 2: "El script dice que Ptyxis no está instalado"

```bash
# Instalar Ptyxis en Fedora
sudo dnf install -y gnome-ptyxis

# Verificar instalación
which ptyxis
```

### Problema 3: "Los colores no se aplican"

```bash
# Opción 1: Reaplicar usando flujo Ptyxis 5.0+ (UUID dinámico)
bash ./install-ptyxis50.sh

# Opción 2: Diagnosticar claves faltantes
bash ./verify-ptyxis50.sh

# Opción 3: Verificar UUID y una clave crítica
UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d \"'\")
dconf read /org/gnome/Ptyxis/Profiles/${UUID}/background-color
```

### Problema 4: "Permission denied" al ejecutar el script

```bash
# Dar permisos correctos
chmod +x install-fedora.sh
chmod +x ~/.config/ptyxis/restart-with-theme.sh

# O ejecutar con bash directamente
bash install-fedora.sh
```

### Problema 5: "El tema se reinicia después de cerrar Ptyxis"

```bash
# 1. Obtener perfil activo
UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")

# 2. Verificar clave persistida
dconf read /org/gnome/Ptyxis/Profiles/${UUID}/background-color

# 3. Si falta, reaplicar configuración completa
bash ./install-ptyxis50.sh
```

---

## 📋 Verificación Manual

### Ver todos los esquemas disponibles

```bash
gsettings list-schemas | grep -i ptyxis
```

**Salida esperada:**
```
org.gnome.Ptyxis
org.gnome.Ptyxis.Preferences
```

### Ver perfil activo (UUID)

```bash
UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")
echo "$UUID"
```

### Ver la configuración actual

```bash
# Color de fondo
dconf read /org/gnome/Ptyxis/Profiles/${UUID}/background-color

# Color de texto
dconf read /org/gnome/Ptyxis/Profiles/${UUID}/foreground-color

# Paleta completa
dconf read /org/gnome/Ptyxis/Profiles/${UUID}/palette
```

---

## 🎯 Instalación Alternativa (Sin Script)

Si el script no funciona, sigue estos pasos manualmente:

### Paso 1: Crear directorios

```bash
mkdir -p ~/.config/ptyxis
mkdir -p ~/.local/share/ptyxis/profiles
```

### Paso 2: Aplicar colores con script robusto

```bash
bash ./install-ptyxis50.sh
```

### Paso 3: Reiniciar Ptyxis

```bash
killall ptyxis
sleep 1
ptyxis &
```

---

## 🛠️ Usando dconf-editor (GUI)

Si prefieres una interfaz gráfica:

### Instalar dconf-editor

```bash
sudo dnf install -y dconf-editor
```

### Aplicar el tema

1. Abre `dconf-editor`
2. Navega a: `org` → `gnome` → `Ptyxis` → `Profiles`
3. Selecciona el UUID retornado por:
   `dconf read /org/gnome/Ptyxis/default-profile-uuid`
4. Modifica los valores:
   - `background-color`: `'rgb(10, 0, 20)'`
   - `foreground-color`: `'rgb(224, 176, 255)'`
   - `cursor-background-color`: `'rgb(255, 0, 255)'`

---

## 📦 Dependencias en Fedora

### Verificar qué está instalado

```bash
# Verificar Ptyxis
rpm -q gnome-ptyxis

# Verificar GNOME Shell
rpm -q gnome-shell

# Verificar GLib (contiene gsettings)
rpm -q glib2
```

### Instalar todo lo necesario

```bash
sudo dnf install -y gnome-ptyxis gnome-shell glib2 dconf
```

---

## 🎨 Personalización Adicional

### Cambiar fuente en Fedora

```bash
# Lista de fuentes disponibles
fc-list : family

# Aplicar fuente
gsettings set org.gnome.Ptyxis monospace-font-name 'Fira Code 12'
```

### Cambiar opacidad

```bash
# Valores: 0.0 (transparente) a 1.0 (opaco)
gsettings set org.gnome.Ptyxis opacity 0.90
```

### Cambiar tamaño de texto

```bash
gsettings set org.gnome.Ptyxis monospace-font-name 'Monospace 14'
```

---

## 🔄 Actualizar el tema

Si hay actualizaciones del tema:

```bash
# Navega al directorio del repositorio
cd TEMATERMINAL

# Actualizar
git pull

# Ejecutar script nuevamente
bash install-fedora.sh
```

---

## 🐛 Reportar Problemas

Si encuentras un error específico de Fedora:

1. Ejecuta esto y copia el resultado:

```bash
echo "=== Sistema ==="
cat /etc/os-release | grep PRETTY_NAME
echo ""
echo "=== Ptyxis ==="
ptyxis --version
echo ""
echo "=== GNOME ==="
gnome-shell --version
echo ""
echo "=== Esquema ==="
gsettings list-schemas | grep ptyxis
echo ""
echo "=== Perfiles ==="
gsettings list-keys org.gnome.Ptyxis.Profiles 2>/dev/null || echo "No hay perfiles"
```

2. Abre un issue en: https://github.com/h4tt3r-xplo1t/TEMATERMINAL/issues

---

## 💜 ¡Disfruta tu terminal morada en Fedora!

Si todo funcionó correctamente, deberías ver:
- ✅ Fondo morado profundo (#0a0014)
- ✅ Texto lavanda (#e0b0ff)
- ✅ Cursor magenta (#ff00ff)
- ✅ Colores vibrantes en la terminal

---

**Última actualización:** 2026-09-03  
**Versión:** 1.0  
**Compatibilidad:** Fedora + Ptyxis 5.0+
