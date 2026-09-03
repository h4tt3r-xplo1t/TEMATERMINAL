#!/bin/bash

# Script de instalación del Tema Morado Futurista para Ptyxis en FEDORA
# Optimizado para Fedora 40+
# Basado en estética Cyberpunk - h4tt3r-xplo1t

set -e

echo "🚀 ==========================================="
echo "   Instalador Tema Morado - FEDORA"
echo "   Para Terminal Ptyxis 45.0+"
echo "🚀 ==========================================="
echo ""

# Verificar si Ptyxis está instalado
echo "🔍 Verificando dependencias..."
if ! command -v ptyxis &> /dev/null; then
    echo "❌ ERROR: Ptyxis no está instalado"
    echo "📦 Para instalar en Fedora ejecuta:"
    echo "   sudo dnf install gnome-ptyxis"
    exit 1
fi

# Verificar si gsettings está disponible
if ! command -v gsettings &> /dev/null; then
    echo "⚠️  gsettings no encontrado, instalando..."
    sudo dnf install -y glib2 &> /dev/null || true
fi

echo "✅ Dependencias verificadas"
echo ""

# Directorio de configuración
PTYXIS_CONFIG_DIR="${HOME}/.config/ptyxis"
PROFILES_DIR="${HOME}/.local/share/ptyxis/profiles"
DCONF_CONFIG_DIR="${HOME}/.config/dconf"

# Crear directorios
echo "📁 PASO 1: Creando directorios necesarios..."
mkdir -p "${PTYXIS_CONFIG_DIR}"
mkdir -p "${PROFILES_DIR}"
mkdir -p "${DCONF_CONFIG_DIR}"
echo "✅ Directorios creados"
echo ""

# Paso 2: Crear configuración GSSettings
echo "⚙️  PASO 2: Configurando tema con GSSettings..."

# Crear el ID del perfil
PROFILE_ID="purple-cyberpunk"

# Configurar colores usando gsettings
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE_ID}" background-color 'rgb(10, 0, 20)' 2>/dev/null || true
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE_ID}" foreground-color 'rgb(224, 176, 255)' 2>/dev/null || true

# Configurar paleta de colores
PALETTE="['rgb(26, 0, 51)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(119, 0, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(224, 176, 255)', 'rgb(77, 0, 153)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(153, 51, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(255, 255, 255)']"

gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE_ID}" palette "${PALETTE}" 2>/dev/null || true

# Configurar propiedades adicionales
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE_ID}" cursor-background-color 'rgb(255, 0, 255)' 2>/dev/null || true
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE_ID}" cursor-foreground-color 'rgb(10, 0, 20)' 2>/dev/null || true
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE_ID}" bold-color-same-as-fg true 2>/dev/null || true
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE_ID}" bold-is-bright true 2>/dev/null || true

echo "✅ Configuración GSSettings aplicada"
echo ""

# Paso 3: Crear archivo de configuración alternativa
echo "📝 PASO 3: Creando configuración alternativa..."
cat > "${PTYXIS_CONFIG_DIR}/purple-theme.conf" << 'EOF'
# Tema Morado Cyberpunk para Ptyxis en Fedora
# Archivo de configuración alternativo

[org/gnome/Ptyxis/Profiles/purple-cyberpunk]
background-color=rgb(10, 0, 20)
foreground-color=rgb(224, 176, 255)
cursor-background-color=rgb(255, 0, 255)
cursor-foreground-color=rgb(10, 0, 20)
palette=['rgb(26, 0, 51)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(119, 0, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(224, 176, 255)', 'rgb(77, 0, 153)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(153, 51, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(255, 255, 255)']
bold-color-same-as-fg=true
bold-is-bright=true
EOF
echo "✅ Archivo de configuración creado"
echo ""

# Paso 4: Crear script para aplicar el tema manualmente si es necesario
echo "🔧 PASO 4: Creando script de aplicación manual..."
cat > "${PTYXIS_CONFIG_DIR}/apply-theme.sh" << 'EOF'
#!/bin/bash
# Script para aplicar el tema morado manualmente en Fedora

PROFILE="purple-cyberpunk"

echo "Aplicando tema morado a Ptyxis..."

gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE}" background-color 'rgb(10, 0, 20)'
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE}" foreground-color 'rgb(224, 176, 255)'
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE}" cursor-background-color 'rgb(255, 0, 255)'
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE}" cursor-foreground-color 'rgb(10, 0, 20)'
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE}" palette "['rgb(26, 0, 51)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(119, 0, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(224, 176, 255)', 'rgb(77, 0, 153)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(153, 51, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(255, 255, 255)']"
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE}" bold-color-same-as-fg true
gsettings set org.gnome.Ptyxis.Profiles:"${PROFILE}" bold-is-bright true

echo "✅ Tema aplicado correctamente"
echo ""
echo "Reiniciando Ptyxis..."
killall ptyxis 2>/dev/null || true
sleep 1
ptyxis &
EOF

chmod +x "${PTYXIS_CONFIG_DIR}/apply-theme.sh"
echo "✅ Script de aplicación manual creado"
echo ""

# Paso 5: Mostrar información de completación
echo "════════════════════════════════════════════"
echo "✅ INSTALACIÓN COMPLETADA EN FEDORA"
echo "════════════════════════════════════════════"
echo ""
echo "📍 Archivos de configuración en:"
echo "   • ${PTYXIS_CONFIG_DIR}/purple-theme.conf"
echo "   • ${PTYXIS_CONFIG_DIR}/apply-theme.sh"
echo ""
echo "🎯 PRÓXIMOS PASOS:"
echo ""
echo "Método 1: Seleccionar desde GUI (Recomendado)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. Abre Ptyxis"
echo "2. Haz clic en el botón ☰ (Menú)"
echo "3. Selecciona 'Preferencias'"
echo "4. En la sección 'Apariencia' o 'Perfiles'"
echo "5. Busca y selecciona 'purple-cyberpunk'"
echo "6. Cierra y reabre Ptyxis"
echo ""
echo "Método 2: Aplicar via script"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$ ${PTYXIS_CONFIG_DIR}/apply-theme.sh"
echo ""
echo "Método 3: Aplicar via línea de comandos"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$ gsettings list-schemas | grep -i ptyxis"
echo "$ gsettings list-keys org.gnome.Ptyxis.Profiles:purple-cyberpunk"
echo ""
echo "🔧 Si el tema no aparece:"
echo ""
echo "   Opción A: Forzar recarga de DConf"
echo "   $ dconf update"
echo "   $ gsettings list-keys org.gnome.Ptyxis.Profiles"
echo ""
echo "   Opción B: Reiniciar completamente"
echo "   $ killall ptyxis"
echo "   $ killall -9 gnome-ptyxis"
echo "   $ ptyxis &"
echo ""
echo "   Opción C: Verificar esquema"
echo "   $ gsettings list-schemas | grep ptyxis"
echo ""
echo "📊 Información del tema:"
echo "   • Nombre: Purple Cyberpunk"
echo "   • Fondo: #0a0014 (Negro morado)"
echo "   • Texto: #e0b0ff (Lavanda brillante)"
echo "   • Cursor: #ff00ff (Magenta)"
echo "   • Errores: #ff1493 (Rosa)"
echo "   • Éxito: #00ff88 (Verde neón)"
echo "   • Advertencias: #ffaa00 (Naranja)"
echo ""
echo "💜 ¡Tu terminal morada está lista! 💜"
echo ""
