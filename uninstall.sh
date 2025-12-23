#!/bin/bash

# Uninstallation script for Screenshot Launcher Extension
# This script removes the GNOME Shell extension and desktop file

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Extension details
EXTENSION_UUID="screenshot-launcher@simple"
EXTENSION_DIR="$HOME/.local/share/gnome-shell/extensions/$EXTENSION_UUID"
DESKTOP_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="screenshot-launcher.desktop"

echo -e "${RED}Screenshot Launcher Extension Uninstaller${NC}"
echo "============================================"
echo ""

# Check if extension is installed
if [ ! -d "$EXTENSION_DIR" ] && [ ! -f "$DESKTOP_DIR/$DESKTOP_FILE" ]; then
    echo -e "${YELLOW}Extension and desktop file are not installed${NC}"
    exit 0
fi

# Disable extension if enabled
if command -v gnome-extensions &> /dev/null; then
    if gnome-extensions list | grep -q "$EXTENSION_UUID"; then
        echo "Disabling extension..."
        gnome-extensions disable "$EXTENSION_UUID" 2>/dev/null || true
        echo -e "${GREEN}✓${NC} Extension disabled"
    fi
fi

# Remove extension directory
if [ -d "$EXTENSION_DIR" ]; then
    echo "Removing extension files..."
    rm -rf "$EXTENSION_DIR"
    echo -e "${GREEN}✓${NC} Extension files removed from $EXTENSION_DIR"
else
    echo -e "${YELLOW}!${NC} Extension directory not found"
fi

# Remove desktop file
if [ -f "$DESKTOP_DIR/$DESKTOP_FILE" ]; then
    echo "Removing desktop file..."
    rm -f "$DESKTOP_DIR/$DESKTOP_FILE"
    echo -e "${GREEN}✓${NC} Desktop file removed from $DESKTOP_DIR"
else
    echo -e "${YELLOW}!${NC} Desktop file not found"
fi

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    echo "Updating desktop database..."
    update-desktop-database "$DESKTOP_DIR"
    echo -e "${GREEN}✓${NC} Desktop database updated"
fi

echo ""
echo -e "${GREEN}Uninstallation completed successfully!${NC}"
echo ""
echo "Note: You may need to restart GNOME Shell to see the changes:"
echo "  - On X11: Press Alt+F2, type 'r', and press Enter"
echo "  - On Wayland: Log out and log back in"
echo ""

exit 0
