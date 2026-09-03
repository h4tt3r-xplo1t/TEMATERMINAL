#!/bin/bash

# Script de verificación para Ptyxis 50.x
# Verifica si los colores se aplicaron correctamente

echo "🔍 VERIFICANDO CONFIGURACIÓN DE PTYXIS 50.x"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Obtener el UUID del perfil default
DEFAULT_PROFILE_UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid 2>/dev/null | tr -d "'")

echo "UUID del perfil: $DEFAULT_PROFILE_UUID"
echo ""

if [ -z "$DEFAULT_PROFILE_UUID" ]; then
    echo "❌ No hay perfil configurado"
    exit 1
fi

# Verificar cada propiedad
PROFILE_PATH="/org/gnome/Ptyxis/Profiles/${DEFAULT_PROFILE_UUID}"

echo "Leyendo configuración actual:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Background:"
dconf read "${PROFILE_PATH}/background-color" || echo "  (no configurado)"
echo ""

echo "Foreground:"
dconf read "${PROFILE_PATH}/foreground-color" || echo "  (no configurado)"
echo ""

echo "Cursor background:"
dconf read "${PROFILE_PATH}/cursor-background-color" || echo "  (no configurado)"
echo ""

echo "Cursor foreground:"
dconf read "${PROFILE_PATH}/cursor-foreground-color" || echo "  (no configurado)"
echo ""

echo "Paleta:"
dconf read "${PROFILE_PATH}/palette" || echo "  (no configurado)"
echo ""

echo "Bold color same as fg:"
dconf read "${PROFILE_PATH}/bold-color-same-as-fg" || echo "  (no configurado)"
echo ""

echo "Bold is bright:"
dconf read "${PROFILE_PATH}/bold-is-bright" || echo "  (no configurado)"
echo ""

# Mostrar todas las claves disponibles
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Todas las claves disponibles en el perfil:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
dconf list "${PROFILE_PATH}/" || echo "No se pudo listar"
