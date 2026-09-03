#!/bin/bash

# Script de instalación del Tema Morado Futurista para Ptyxis en FEDORA
# Optimizado para Fedora 40+
# Basado en estética Cyberpunk - h4tt3r-xplo1t

set -euo pipefail

echo "🚀 ==========================================="
echo "   Instalador Tema Morado - FEDORA"
echo "   Para Terminal Ptyxis 5.0+ (con fallback)"
echo "🚀 ==========================================="
echo ""

echo "🔍 Verificando dependencias..."
if ! command -v ptyxis >/dev/null 2>&1; then
    echo "⚠️  Ptyxis no está instalado"
    if command -v sudo >/dev/null 2>&1; then
        echo "📦 Instalando gnome-ptyxis..."
        sudo dnf install -y gnome-ptyxis
    else
        echo "❌ ERROR: se requiere instalar Ptyxis manualmente"
        echo "   sudo dnf install -y gnome-ptyxis"
        exit 1
    fi
fi

if ! command -v gsettings >/dev/null 2>&1; then
    echo "⚠️  gsettings no encontrado"
    if command -v sudo >/dev/null 2>&1; then
        sudo dnf install -y glib2
    else
        echo "❌ ERROR: instala glib2 para usar gsettings"
        exit 1
    fi
fi

if ! command -v dconf >/dev/null 2>&1; then
    echo "⚠️  dconf no encontrado"
    if command -v sudo >/dev/null 2>&1; then
        sudo dnf install -y dconf
    else
        echo "❌ ERROR: instala dconf manualmente"
        exit 1
    fi
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

echo "✅ Dependencias verificadas"
echo "🔎 Ptyxis detectado: ${PTYXIS_VERSION_RAW:-versión desconocida}"
if [ "${PTYXIS_MAJOR}" -ge 50 ]; then
    echo "✅ Se aplicará flujo recomendado para Ptyxis 5.0+"
else
    echo "⚠️  Se aplicará flujo retrocompatible para versiones anteriores"
fi
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPT="${SCRIPT_DIR}/install-ptyxis50.sh"
VERIFY_SCRIPT="${SCRIPT_DIR}/verify-ptyxis50.sh"

if [ ! -f "${INSTALL_SCRIPT}" ]; then
    echo "❌ ERROR: No se encontró ${INSTALL_SCRIPT}"
    exit 1
fi

echo "🎨 PASO 1: Aplicando tema..."
bash "${INSTALL_SCRIPT}"
echo ""

echo "✔️  PASO 2: Verificando configuración..."
if [ -f "${VERIFY_SCRIPT}" ]; then
    bash "${VERIFY_SCRIPT}"
else
    echo "⚠️  No se encontró verify-ptyxis50.sh, omitiendo verificación"
fi

echo ""
echo "════════════════════════════════════════════"
echo "✅ INSTALACIÓN COMPLETADA EN FEDORA"
echo "════════════════════════════════════════════"
echo ""
echo "Siguiente paso recomendado: reinicia Ptyxis"
echo "  bash ~/.config/ptyxis/restart-with-theme.sh"
echo ""
