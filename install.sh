#!/bin/bash

# Installation script for Screenshot Launcher Extension
# This script installs the GNOME Shell extension and desktop file

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

echo -e "${GREEN}Screenshot Launcher Extension Installer${NC}"
echo "=========================================="
echo ""

# Check if running on a GNOME system
if [ -z "$GNOME_SHELL_SESSION_MODE" ] && [ -z "$XDG_CURRENT_DESKTOP" ]; then
    echo -e "${YELLOW}Warning: GNOME Shell may not be running${NC}"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create directories if they don't exist
echo "Creating directories..."
mkdir -p "$EXTENSION_DIR"
mkdir -p "$DESKTOP_DIR"

# Install extension files
echo "Installing extension files..."
cp extension.js "$EXTENSION_DIR/"
cp metadata.json "$EXTENSION_DIR/"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Extension files installed to $EXTENSION_DIR"
else
    echo -e "${RED}✗${NC} Failed to install extension files"
    exit 1
fi

# Install desktop file
echo "Installing desktop file..."
cp screenshot-launcher.desktop "$DESKTOP_DIR/$DESKTOP_FILE"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Desktop file installed to $DESKTOP_DIR"
else
    echo -e "${RED}✗${NC} Failed to install desktop file"
    exit 1
fi

# Make desktop file executable (optional but recommended)
chmod +x "$DESKTOP_DIR/$DESKTOP_FILE"

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    echo "Updating desktop database..."
    update-desktop-database "$DESKTOP_DIR"
    echo -e "${GREEN}✓${NC} Desktop database updated"
else
    echo -e "${YELLOW}!${NC} update-desktop-database not found, skipping"
fi

echo ""
echo -e "${GREEN}Installation completed successfully!${NC}"
echo ""
echo "Next steps:"
echo "1. Restart GNOME Shell:"
echo "   - On X11: Press Alt+F2, type 'r', and press Enter"
echo "   - On Wayland: Log out and log back in"
echo "2. Enable the extension:"
echo "   - Run: gnome-extensions enable $EXTENSION_UUID"
echo "   - Or use GNOME Extensions app"
echo "3. The 'Screenshot' application will appear in your application menu"
echo ""
echo "To enable the extension now (requires GNOME Shell restart), run:"
echo "  gnome-extensions enable $EXTENSION_UUID"
echo ""

# Ask if user wants to enable the extension
read -p "Would you like to enable the extension now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v gnome-extensions &> /dev/null; then
        gnome-extensions enable "$EXTENSION_UUID"
        echo -e "${GREEN}✓${NC} Extension enabled"
        echo -e "${YELLOW}Note: You still need to restart GNOME Shell for changes to take effect${NC}"
    else
        echo -e "${RED}✗${NC} gnome-extensions command not found"
        echo "Please enable manually after restarting GNOME Shell"
    fi
fi

exit 0
