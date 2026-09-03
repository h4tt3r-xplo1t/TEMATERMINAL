#!/bin/bash

# Script de Instalación para Ptyxis 50.x en Fedora 44+
# Solución para el nuevo sistema de perfiles UUID

set -e

echo "🚀 ==========================================="
echo "   Instalador Ptyxis 50.x - Tema Morado"
echo "   Fedora 44+ (Sistema de Perfiles UUID)"
echo "🚀 ==========================================="
echo ""

PTYXIS_CONFIG="${HOME}/.config/ptyxis"
PTYXIS_DATA="${HOME}/.local/share/ptyxis"

# Paso 1: Crear directorios
echo "📁 PASO 1: Creando directorios..."
mkdir -p "${PTYXIS_CONFIG}"
mkdir -p "${PTYXIS_DATA}/profiles"
echo "✅ Directorios creados"
echo ""

# Paso 2: Verificar estructura actual
echo "🔍 PASO 2: Leyendo configuración actual..."

# Leer el UUID del perfil default
DEFAULT_PROFILE_UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid 2>/dev/null | tr -d "'")

if [ -z "$DEFAULT_PROFILE_UUID" ]; then
    echo "⚠️  No hay perfil por defecto, creando uno nuevo..."
    DEFAULT_PROFILE_UUID=$(uuidgen)
    dconf write /org/gnome/Ptyxis/default-profile-uuid "'${DEFAULT_PROFILE_UUID}'"
fi

echo "✅ UUID del perfil: $DEFAULT_PROFILE_UUID"
echo ""

# Paso 3: Crear perfil con colores morados
echo "🎨 PASO 3: Configurando colores del perfil..."

# Ruta del perfil en DConf
PROFILE_PATH="/org/gnome/Ptyxis/Profiles/${DEFAULT_PROFILE_UUID}"

# Configurar colores
echo "   Aplicando colores..."

# Fondo morado profundo
dconf write "${PROFILE_PATH}/background-color" "'rgb(10, 0, 20)'"

# Texto lavanda
dconf write "${PROFILE_PATH}/foreground-color" "'rgb(224, 176, 255)'"

# Cursor magenta
dconf write "${PROFILE_PATH}/cursor-background-color" "'rgb(255, 0, 255)'"
dconf write "${PROFILE_PATH}/cursor-foreground-color" "'rgb(10, 0, 20)'"

# Paleta de 16 colores
PALETTE="['rgb(26, 0, 51)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(119, 0, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(224, 176, 255)', 'rgb(77, 0, 153)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(153, 51, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(255, 255, 255)']"
dconf write "${PROFILE_PATH}/palette" "${PALETTE}"

# Propiedades
dconf write "${PROFILE_PATH}/bold-color-same-as-fg" "true"
dconf write "${PROFILE_PATH}/bold-is-bright" "true"

echo "✅ Colores aplicados"
echo ""

# Paso 4: Verificar la configuración
echo "✔️  PASO 4: Verificando configuración..."
echo ""
echo "   Colores aplicados:"
echo "   • Fondo: $(dconf read ${PROFILE_PATH}/background-color)"
echo "   • Texto: $(dconf read ${PROFILE_PATH}/foreground-color)"
echo "   • Cursor: $(dconf read ${PROFILE_PATH}/cursor-background-color)"
echo ""

# Paso 5: Crear script de reinicio
cat > "${PTYXIS_CONFIG}/restart-with-theme.sh" << 'SCRIPT_EOF'
#!/bin/bash
echo "🔄 Reiniciando Ptyxis con tema morado..."
killall -9 ptyxis 2>/dev/null || true
sleep 1
ptyxis &
echo "✅ Ptyxis reiniciado"
SCRIPT_EOF

chmod +x "${PTYXIS_CONFIG}/restart-with-theme.sh"
echo ""

# Paso 6: Resumen final
echo "════════════════════════════════════════════"
echo "✅ INSTALACIÓN COMPLETADA"
echo "════════════════════════════════════════════"
echo ""
echo "🎨 Tema configurado para Ptyxis 50.x"
echo "📍 UUID del perfil: $DEFAULT_PROFILE_UUID"
echo ""
echo "🎯 PRÓXIMOS PASOS:"
echo ""
echo "Opción 1: Reiniciar Ptyxis (Recomendado)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$ bash ${PTYXIS_CONFIG}/restart-with-theme.sh"
echo ""
echo "O manualmente:"
echo "$ killall -9 ptyxis && sleep 1 && ptyxis &"
echo ""
echo "Opción 2: Cerrar y reabrir Ptyxis desde la GUI"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. Cierra completamente Ptyxis"
echo "2. Abre Ptyxis nuevamente"
echo "3. El tema morado debería estar aplicado"
echo ""
echo "Opción 3: Verificar configuración"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$ dconf read /org/gnome/Ptyxis/Profiles/${DEFAULT_PROFILE_UUID}/background-color"
echo ""
echo "📊 Información del tema:"
echo "   • Tipo: Cyberpunk Morado"
echo "   • Compatible: Ptyxis 50.x"
echo "   • Fondo: #0a0014 (Negro morado)"
echo "   • Texto: #e0b0ff (Lavanda)"
echo "   • Cursor: #ff00ff (Magenta)"
echo ""
echo "💜 ¡Tu terminal morada está lista! 💜"
echo ""
