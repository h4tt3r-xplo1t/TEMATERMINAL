#!/bin/bash

# Script de Diagnóstico para Fedora - Tema Morado Ptyxis
# Este script identifica por qué el tema no aparece

echo "🔍 =========================================="
echo "   DIAGNÓSTICO - Tema Morado en Fedora"
echo "🔍 =========================================="
echo ""

# Verificación 1: Sistema operativo
echo "📋 1. INFORMACIÓN DEL SISTEMA"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ -f /etc/os-release ]; then
    PRETTY_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
    echo "✓ Sistema: $PRETTY_NAME"
else
    echo "✗ No se encontró información del sistema"
fi
echo ""

# Verificación 2: Ptyxis instalado
echo "📋 2. VERIFICACIÓN DE PTYXIS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if command -v ptyxis &> /dev/null; then
    PTYXIS_VERSION=$(ptyxis --version 2>/dev/null || echo "desconocida")
    PTYXIS_PATH=$(which ptyxis)
    echo "✓ Ptyxis instalado"
    echo "  Versión: $PTYXIS_VERSION"
    echo "  Ruta: $PTYXIS_PATH"
else
    echo "✗ Ptyxis NO está instalado"
    echo "  Instala con: sudo dnf install -y gnome-ptyxis"
fi
echo ""

# Verificación 3: GNOME Shell
echo "📋 3. VERIFICACIÓN DE GNOME"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if command -v gnome-shell &> /dev/null; then
    GNOME_VERSION=$(gnome-shell --version)
    echo "✓ GNOME Shell instalado"
    echo "  $GNOME_VERSION"
else
    echo "⚠️  GNOME Shell no encontrado"
fi
echo ""

# Verificación 4: gsettings
echo "📋 4. VERIFICACIÓN DE GSETTINGS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if command -v gsettings &> /dev/null; then
    echo "✓ gsettings disponible"
    echo ""
    echo "  Esquemas de Ptyxis disponibles:"
    gsettings list-schemas 2>/dev/null | grep -i ptyxis | while read schema; do
        echo "    • $schema"
    done
else
    echo "✗ gsettings NO está disponible"
    echo "  Instala con: sudo dnf install -y glib2"
fi
echo ""

# Verificación 5: Directorios de configuración
echo "📋 5. DIRECTORIOS DE CONFIGURACIÓN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
CONFIG_DIR="${HOME}/.config/ptyxis"
if [ -d "$CONFIG_DIR" ]; then
    echo "✓ Directorio config existe: $CONFIG_DIR"
    echo "  Contenido:"
    ls -la "$CONFIG_DIR" 2>/dev/null | tail -n +4 | while read line; do
        echo "    $line"
    done
else
    echo "✗ Directorio config NO existe: $CONFIG_DIR"
    echo "  Se creará automáticamente"
fi
echo ""

# Verificación 6: Perfiles de Ptyxis
echo "📋 6. PERFILES DISPONIBLES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if gsettings list-schemas 2>/dev/null | grep -q "org.gnome.Ptyxis"; then
    echo "✓ Esquema Ptyxis encontrado"
    echo ""
    echo "  Intentando listar perfiles..."
    PROFILES=$(gsettings list-keys org.gnome.Ptyxis.Profiles 2>&1)
    
    if echo "$PROFILES" | grep -q "error"; then
        echo "✗ No se pueden listar los perfiles"
        echo "  Razón: $PROFILES"
    else
        echo "✓ Perfiles encontrados:"
        echo "$PROFILES" | while read profile; do
            echo "    • $profile"
        done
    fi
else
    echo "✗ Esquema Ptyxis NO encontrado"
fi
echo ""

# Verificación 7: DConf
echo "📋 7. VERIFICACIÓN DE DCONF"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if command -v dconf &> /dev/null; then
    echo "✓ dconf disponible"
    echo ""
    echo "  Base de datos de Ptyxis:"
    dconf list /org/gnome/Ptyxis/ 2>/dev/null | head -10 || echo "    (no hay datos aún)"
else
    echo "✗ dconf NO está disponible"
fi
echo ""

# Verificación 8: Archivos de tema
echo "📋 8. ARCHIVOS DE TEMA CREADOS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
SCHEMES_DIR="${CONFIG_DIR}/schemes"
if [ -d "$SCHEMES_DIR" ]; then
    echo "✓ Directorio schemes existe"
    echo "  Archivos:"
    ls -la "$SCHEMES_DIR" 2>/dev/null | tail -n +4 | while read line; do
        echo "    $line"
    done
else
    echo "✗ Directorio schemes NO existe: $SCHEMES_DIR"
fi
echo ""

# Diagnóstico final
echo "════════════════════════════════════════════"
echo "🔧 RECOMENDACIONES"
echo "════════════════════════════════════════════"
echo ""

if ! command -v ptyxis &> /dev/null; then
    echo "❌ PROBLEMA PRINCIPAL: Ptyxis no está instalado"
    echo ""
    echo "SOLUCIÓN:"
    echo "$ sudo dnf install -y gnome-ptyxis"
    echo ""
elif ! gsettings list-schemas 2>/dev/null | grep -q "org.gnome.Ptyxis"; then
    echo "❌ PROBLEMA PRINCIPAL: Esquema de Ptyxis no registrado"
    echo ""
    echo "SOLUCIONES:"
    echo "1. Actualizar esquemas:"
    echo "   $ glib-compile-schemas ~/.local/share/glib-2.0/schemas/"
    echo ""
    echo "2. Reconstruir base de datos:"
    echo "   $ dconf update"
    echo ""
    echo "3. Reinstalar Ptyxis:"
    echo "   $ sudo dnf reinstall -y gnome-ptyxis"
    echo ""
else
    echo "✓ La instalación parece estar correcta"
    echo ""
    echo "PASOS A SEGUIR:"
    echo "1. Ejecuta el script de aplicación:"
    echo "   $ bash ~/.config/ptyxis/apply-theme.sh"
    echo ""
    echo "2. Si aún no funciona, reinicia Ptyxis completamente:"
    echo "   $ killall -9 ptyxis"
    echo "   $ ptyxis &"
    echo ""
    echo "3. Verifica que el perfil existe:"
    echo "   $ gsettings list-keys org.gnome.Ptyxis.Profiles:purple-cyberpunk"
    echo ""
fi

echo ""
echo "💜 Diagnóstico completado"
echo ""
