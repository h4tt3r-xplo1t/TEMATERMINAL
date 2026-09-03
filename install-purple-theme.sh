#!/bin/bash

# Script de instalación del Tema Morado Futurista para Ptyxis
# Basado en estética Cyberpunk - h4tt3r-xplo1t
# Tema inspirado en diseño de seguridad digital futurista

set -e

echo "🚀 ==========================================";
echo "   Instalador - Tema Morado Futurista";
echo "   Para Terminal Ptyxis";
echo "🚀 ==========================================";
echo "";

# Obtener el directorio de configuración de Ptyxis
PTYXIS_CONFIG_DIR="${HOME}/.config/ptyxis"
THEME_DIR="${PTYXIS_CONFIG_DIR}/schemes"

# Paso 1: Crear directorios si no existen
echo "📁 PASO 1: Creando directorios de configuración..."
mkdir -p "${THEME_DIR}"
echo "✅ Directorios creados en: ${PTYXIS_CONFIG_DIR}"
echo "";

# Paso 2: Crear el archivo del tema en formato DConf
echo "🎨 PASO 2: Generando archivo de tema (DConf)..."
cat > "${THEME_DIR}/purple-cyberpunk.dconf" << 'EOF'
[/org/gnome/Ptyxis/Profiles/purple-cyberpunk]
background-color='rgb(10, 0, 20)'
foreground-color='rgb(224, 176, 255)'
palette=['rgb(26, 0, 51)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(119, 0, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(224, 176, 255)', 'rgb(77, 0, 153)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(153, 51, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(255, 255, 255)']
bold-color-same-as-fg=true
bold-is-bright=true
cursor-background-color='rgb(255, 0, 255)'
cursor-foreground-color='rgb(10, 0, 20)'
highlight-background-color='rgb(77, 0, 153)'
highlight-foreground-color='rgb(224, 176, 255)'
EOF
echo "✅ Archivo DConf creado"
echo "";

# Paso 3: Crear configuración en formato JSON
echo "📝 PASO 3: Creando configuración JSON..."
cat > "${PTYXIS_CONFIG_DIR}/purple-cyberpunk.json" << 'EOF'
{
  "name": "Purple Cyberpunk",
  "description": "Tema morado futurista estilo cyberpunk",
  "colors": {
    "background": "#0a0014",
    "foreground": "#e0b0ff",
    "black": "#1a0033",
    "red": "#ff1493",
    "green": "#00ff88",
    "yellow": "#ffaa00",
    "blue": "#7700ff",
    "magenta": "#ff00ff",
    "cyan": "#00ffff",
    "white": "#e0b0ff",
    "bright_black": "#4d0099",
    "bright_red": "#ff1493",
    "bright_green": "#00ff88",
    "bright_yellow": "#ffaa00",
    "bright_blue": "#9933ff",
    "bright_magenta": "#ff00ff",
    "bright_cyan": "#00ffff",
    "bright_white": "#ffffff"
  },
  "metadata": {
    "author": "h4tt3r-xplo1t",
    "license": "MIT",
    "version": "1.0"
  }
}
EOF
echo "✅ Archivo JSON creado"
echo "";

# Paso 4: Crear configuración alternativa en XML
echo "🎭 PASO 4: Creando configuración XML (compatible)..."
cat > "${THEME_DIR}/purple-cyberpunk.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<colorScheme name="Purple Cyberpunk" version="1">
  <author>h4tt3r-xplo1t</author>
  <description>Tema morado futurista estilo cyberpunk para Ptyxis</description>
  
  <!-- Colores básicos -->
  <color name="background" value="#0a0014"/>
  <color name="foreground" value="#e0b0ff"/>
  <color name="cursor" value="#ff00ff"/>
  <color name="selection" value="#4d0099"/>
  
  <!-- Paleta de 16 colores estándar -->
  <palette>
    <!-- Colores oscuros (0-7) -->
    <color index="0" value="#1a0033"/>  <!-- Negro -->
    <color index="1" value="#ff1493"/>  <!-- Rojo (Deep Pink) -->
    <color index="2" value="#00ff88"/>  <!-- Verde (Bright Green) -->
    <color index="3" value="#ffaa00"/>  <!-- Amarillo (Orange) -->
    <color index="4" value="#7700ff"/>  <!-- Azul (Morado Oscuro) -->
    <color index="5" value="#ff00ff"/>  <!-- Magenta -->
    <color index="6" value="#00ffff"/>  <!-- Cyan -->
    <color index="7" value="#e0b0ff"/>  <!-- Blanco (Lavanda) -->
    
    <!-- Colores brillantes (8-15) -->
    <color index="8" value="#4d0099"/>  <!-- Gris Oscuro (Morado) -->
    <color index="9" value="#ff1493"/>  <!-- Rojo Brillante -->
    <color index="10" value="#00ff88"/> <!-- Verde Brillante -->
    <color index="11" value="#ffaa00"/> <!-- Amarillo Brillante -->
    <color index="12" value="#9933ff"/> <!-- Azul Brillante -->
    <color index="13" value="#ff00ff"/> <!-- Magenta Brillante -->
    <color index="14" value="#00ffff"/> <!-- Cyan Brillante -->
    <color index="15" value="#ffffff"/> <!-- Blanco Puro -->
  </palette>
</colorScheme>
EOF
echo "✅ Archivo XML creado"
echo "";

# Paso 5: Crear archivo de configuración adicional
echo "⚙️  PASO 5: Creando archivo de configuración adicional..."
cat > "${PTYXIS_CONFIG_DIR}/dconf-purple-settings" << 'EOF'
# Configuración adicional recomendada para el tema Morado Cyberpunk
# Aplicar con: dconf load < dconf-purple-settings

[org/gnome/Ptyxis]
use-system-font=false
monospace-font-name='Monospace 12'
opacity=0.95

[org/gnome/Ptyxis/Profiles/purple-cyberpunk]
palette=['rgb(26, 0, 51)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(119, 0, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(224, 176, 255)', 'rgb(77, 0, 153)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(153, 51, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(255, 255, 255)']
background-color='rgb(10, 0, 20)'
foreground-color='rgb(224, 176, 255)'
cursor-background-color='rgb(255, 0, 255)'
highlight-background-color='rgb(77, 0, 153)'
EOF
echo "✅ Configuración DConf adicional creada"
echo "";

# Paso 6: Información de instalación
echo "════════════════════════════════════════════";
echo "✅ INSTALACIÓN COMPLETADA";
echo "════════════════════════════════════════════";
echo "";
echo "📍 Archivos instalados en:"
echo "   • ${THEME_DIR}/purple-cyberpunk.dconf"
echo "   • ${THEME_DIR}/purple-cyberpunk.xml"
echo "   • ${PTYXIS_CONFIG_DIR}/purple-cyberpunk.json"
echo "   • ${PTYXIS_CONFIG_DIR}/dconf-purple-settings"
echo "";
echo "🎯 PRÓXIMOS PASOS:"
echo "";
echo "Opción 1: Usando la GUI de Ptyxis"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
echo "1. Abre Ptyxis"
echo "2. Ve a ☰ Menú → Preferencias"
echo "3. Selecciona 'Apariencia' o 'Temas'"
echo "4. Busca y selecciona 'Purple Cyberpunk'"
echo "5. Reinicia Ptyxis"
echo "";
echo "Opción 2: Aplicar via DConf (línea de comandos)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
echo "$ dconf load /org/gnome/Ptyxis/Profiles/purple-cyberpunk < ${PTYXIS_CONFIG_DIR}/dconf-purple-settings"
echo "";
echo "Opción 3: Editar manualmente en gsettings"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
echo "$ gsettings set org.gnome.Ptyxis color-scheme 'purple-cyberpunk'"
echo "";
echo "🔧 Si el tema no aparece:"
echo "   • Reinicia Ptyxis completamente: killall ptyxis && ptyxis"
echo "   • Verifica la instalación: ls -la ${THEME_DIR}/"
echo "   • Recarga DConf: dconf write /org/gnome/dconf-service/user-db/locks '[]'"
echo "";
echo "📊 Información del tema:"
echo "   • Fondo: #0a0014 (Morado muy oscuro)"
echo "   • Texto: #e0b0ff (Lavanda brillante)"
echo "   • Cursor: #ff00ff (Magenta)"
echo "   • Acentos: Verde neón, Rosa, Cian"
echo "";
echo "💜 ¡Disfruta tu nueva terminal morada cyberpunk! 💜"
echo "";
