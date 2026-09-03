#!/bin/bash

# Script de verificación para Ptyxis 5.0+
# Verifica si los colores se aplicaron correctamente

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS_COUNT=0
FAIL_COUNT=0

pass() {
    echo -e "${GREEN}✅ $1${NC}"
    PASS_COUNT=$((PASS_COUNT + 1))
}

warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

fail() {
    echo -e "${RED}❌ $1${NC}"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

echo -e "${BLUE}🔍 VERIFICANDO CONFIGURACIÓN DE PTYXIS 5.0+${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if ! command -v ptyxis >/dev/null 2>&1; then
    fail "Ptyxis no está instalado (comando 'ptyxis' no encontrado)"
fi

if ! command -v dconf >/dev/null 2>&1; then
    fail "dconf no está disponible"
fi

if ! command -v gsettings >/dev/null 2>&1; then
    fail "gsettings no está disponible"
fi

if [ "${FAIL_COUNT}" -gt 0 ]; then
    echo ""
    echo "Resultado: ${FAIL_COUNT} fallo(s) crítico(s)"
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

echo "Ptyxis detectado: ${PTYXIS_VERSION_RAW:-versión desconocida}"
if [ "${PTYXIS_MAJOR}" -ge 50 ]; then
    pass "Versión compatible con flujo 5.0+"
else
    warn "Versión menor a 5.0 detectada, usando chequeos retrocompatibles"
fi

if gsettings list-schemas | grep -Fxq 'org.gnome.Ptyxis'; then
    pass "Esquema org.gnome.Ptyxis detectado"
else
    fail "No se encontró el esquema org.gnome.Ptyxis"
fi

DEFAULT_PROFILE_UUID="$(dconf read /org/gnome/Ptyxis/default-profile-uuid 2>/dev/null | tr -d "'")"
if [ -z "${DEFAULT_PROFILE_UUID}" ]; then
    fail "No hay default-profile-uuid en /org/gnome/Ptyxis"
    echo ""
    echo "Diagnóstico: ejecuta primero ./install-ptyxis50.sh"
    exit 1
fi

pass "UUID por defecto detectado: ${DEFAULT_PROFILE_UUID}"
PROFILE_PATH="/org/gnome/Ptyxis/Profiles/${DEFAULT_PROFILE_UUID}/"

read_key() {
    local key="$1"
    local label="$2"
    local value
    value="$(dconf read "${PROFILE_PATH}${key}" 2>/dev/null || true)"
    if [ -z "${value}" ]; then
        fail "${label}: no configurado (${PROFILE_PATH}${key})"
    else
        pass "${label}: ${value}"
    fi
}

echo ""
echo "Leyendo configuración actual:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
read_key "background-color" "Background"
read_key "foreground-color" "Foreground"
read_key "cursor-background-color" "Cursor background"
read_key "cursor-foreground-color" "Cursor foreground"
read_key "palette" "Paleta"
read_key "bold-color-same-as-fg" "Bold color same as fg"
read_key "bold-is-bright" "Bold is bright"

echo ""
echo "Claves disponibles en el perfil:"
if dconf list "${PROFILE_PATH}" >/dev/null 2>&1; then
    dconf list "${PROFILE_PATH}" | sed 's/^/  - /'
    pass "Lectura de claves del perfil OK"
else
    fail "No se pudo listar el perfil (${PROFILE_PATH})"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Resumen: ${PASS_COUNT} OK, ${FAIL_COUNT} con problema"

if [ "${FAIL_COUNT}" -gt 0 ]; then
    exit 1
fi

exit 0
