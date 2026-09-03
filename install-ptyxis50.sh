#!/bin/bash

# Script de Instalación para Ptyxis 50.x en Fedora 44+
# Solución para el sistema de perfiles UUID

set -euo pipefail

echo "🚀 ==========================================="
echo "   Instalador Ptyxis 50.x - Tema Morado"
echo "   Fedora 44+ (Sistema de Perfiles UUID)"
echo "🚀 ==========================================="
echo ""

PTYXIS_CONFIG="${HOME}/.config/ptyxis"
PTYXIS_DATA="${HOME}/.local/share/ptyxis"

if ! command -v ptyxis >/dev/null 2>&1; then
    echo "❌ ERROR: Ptyxis no está instalado"
    echo "📦 Instala en Fedora con: sudo dnf install -y gnome-ptyxis"
    exit 1
fi

if ! command -v dconf >/dev/null 2>&1; then
    echo "❌ ERROR: dconf no está disponible"
    echo "📦 Instala en Fedora con: sudo dnf install -y dconf"
    exit 1
fi

if ! command -v gsettings >/dev/null 2>&1; then
    echo "❌ ERROR: gsettings no está disponible"
    echo "📦 Instala en Fedora con: sudo dnf install -y glib2"
    exit 1
fi

PTYXIS_VERSION_RAW="$(ptyxis --version 2>/dev/null || true)"
if [ -z "${PTYXIS_VERSION_RAW}" ] && command -v rpm >/dev/null 2>&1; then
    PTYXIS_VERSION_RAW="$(rpm -q --qf '%{VERSION}\n' gnome-ptyxis 2>/dev/null || true)"
fi
PTYXIS_VERSION_NUM="$(printf '%s' "${PTYXIS_VERSION_RAW}" | grep -Eo '[0-9]+(\.[0-9]+)?' | head -n1 || true)"
PTYXIS_MAJOR="${PTYXIS_VERSION_NUM%%.*}"
if [ -z "${PTYXIS_MAJOR}" ]; then
    PTYXIS_MAJOR="0"
fi

echo "🔍 Ptyxis detectado: ${PTYXIS_VERSION_RAW:-versión desconocida}"
if [ "${PTYXIS_MAJOR}" -ge 50 ]; then
    echo "✅ Flujo: Compatibilidad Ptyxis 5.0+"
else
    echo "⚠️  Flujo: Compatibilidad retroactiva (pre-5.0)"
fi

echo ""
echo "📁 PASO 1: Creando directorios..."
mkdir -p "${PTYXIS_CONFIG}"
mkdir -p "${PTYXIS_DATA}/profiles"
echo "✅ Directorios creados"
echo ""

if ! gsettings list-schemas | grep -Fxq 'org.gnome.Ptyxis'; then
    echo "⚠️  Esquema org.gnome.Ptyxis no visible en gsettings list-schemas"
    echo "   Continuando con dconf (puede funcionar igualmente según sesión de GNOME)."
fi

echo "🔍 PASO 2: Leyendo configuración actual..."
DEFAULT_PROFILE_UUID="$(dconf read /org/gnome/Ptyxis/default-profile-uuid 2>/dev/null | tr -d "'")"

if [ -z "${DEFAULT_PROFILE_UUID}" ]; then
    echo "⚠️  No hay perfil por defecto, creando uno nuevo..."
    if command -v uuidgen >/dev/null 2>&1; then
        DEFAULT_PROFILE_UUID="$(uuidgen)"
    else
        DEFAULT_PROFILE_UUID="$(cat /proc/sys/kernel/random/uuid)"
    fi
    dconf write /org/gnome/Ptyxis/default-profile-uuid "'${DEFAULT_PROFILE_UUID}'"
fi

DEFAULT_PROFILE_UUID="$(dconf read /org/gnome/Ptyxis/default-profile-uuid 2>/dev/null | tr -d "'")"
if [ -z "${DEFAULT_PROFILE_UUID}" ]; then
    echo "❌ ERROR: No se pudo resolver/escribir default-profile-uuid"
    exit 1
fi

echo "✅ UUID del perfil: ${DEFAULT_PROFILE_UUID}"
echo ""

PROFILE_PATH="/org/gnome/Ptyxis/Profiles/${DEFAULT_PROFILE_UUID}/"
PALETTE="['rgb(26, 0, 51)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(119, 0, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(224, 176, 255)', 'rgb(77, 0, 153)', 'rgb(255, 20, 147)', 'rgb(0, 255, 136)', 'rgb(255, 170, 0)', 'rgb(153, 51, 255)', 'rgb(255, 0, 255)', 'rgb(0, 255, 255)', 'rgb(255, 255, 255)']"

FAILURES=0

write_key() {
    local key="$1"
    local value="$2"
    local label="$3"

    if ! dconf write "${PROFILE_PATH}${key}" "${value}" 2>/dev/null; then
        echo "❌ Falló escritura: ${label} (${key})"
        FAILURES=$((FAILURES + 1))
        return
    fi

    local readback
    readback="$(dconf read "${PROFILE_PATH}${key}" 2>/dev/null || true)"
    if [ -z "${readback}" ]; then
        echo "❌ Falló validación: ${label} (${key}) quedó vacío"
        FAILURES=$((FAILURES + 1))
        return
    fi

    echo "✅ ${label}: ${readback}"
}

echo "🎨 PASO 3: Configurando colores del perfil..."
write_key "background-color" "'rgb(10, 0, 20)'" "Fondo"
write_key "foreground-color" "'rgb(224, 176, 255)'" "Texto"
write_key "cursor-background-color" "'rgb(255, 0, 255)'" "Cursor fondo"
write_key "cursor-foreground-color" "'rgb(10, 0, 20)'" "Cursor texto"
write_key "palette" "${PALETTE}" "Paleta"
write_key "bold-color-same-as-fg" "true" "Negrita mismo color"
write_key "bold-is-bright" "true" "Negrita brillante"
echo ""

if [ "${FAILURES}" -gt 0 ]; then
    echo "❌ ERROR: Hubo ${FAILURES} fallos aplicando el tema"
    exit 1
fi

cat > "${PTYXIS_CONFIG}/restart-with-theme.sh" << 'SCRIPT_EOF'
#!/bin/bash
set -euo pipefail
echo "🔄 Reiniciando Ptyxis con tema morado..."
killall -9 ptyxis 2>/dev/null || true
sleep 1
ptyxis &
echo "✅ Ptyxis reiniciado"
SCRIPT_EOF

chmod +x "${PTYXIS_CONFIG}/restart-with-theme.sh"

echo "════════════════════════════════════════════"
echo "✅ INSTALACIÓN COMPLETADA"
echo "════════════════════════════════════════════"
echo ""
echo "🎨 Tema configurado para Ptyxis (${PTYXIS_VERSION_NUM:-desconocido})"
echo "📍 UUID del perfil: ${DEFAULT_PROFILE_UUID}"
echo ""
echo "🎯 PRÓXIMOS PASOS:"
echo ""
echo "Opción 1: Reiniciar Ptyxis (Recomendado)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$ bash ${PTYXIS_CONFIG}/restart-with-theme.sh"
echo ""
echo "Opción 2: Verificar configuración"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$ bash ./verify-ptyxis50.sh"
echo ""
echo "📊 Información del tema:"
echo "   • Tipo: Cyberpunk Morado"
echo "   • Compatible: Ptyxis 5.0+ (con fallback)"
echo "   • Fondo: #0a0014 (Negro morado)"
echo "   • Texto: #e0b0ff (Lavanda)"
echo "   • Cursor: #ff00ff (Magenta)"
echo ""
echo "💜 ¡Tu terminal morada está lista! 💜"
echo ""
