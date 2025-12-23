# Gnome Shell Screenshot Launcher Extension

A minimal GNOME Shell extension that provides a D-Bus interface to launch the GNOME Screenshot UI, with a desktop file for easy access either from your application menu or dock.

<img width="3840" height="2160" alt="Screenshot From 2025-12-23 12-22-06-annotated-dec-23-2025-12_23" src="https://github.com/user-attachments/assets/9284c50f-cb53-4cfd-b494-871291986472" />

<img width="3630" height="2040" alt="Screenshot From 2025-12-23 12-36-29" src="https://github.com/user-attachments/assets/7ddbb4fa-a64c-4901-84bc-0c3d5e529164" />


## Why Not on extensions.gnome.org?

This extension requires a desktop file to be installed to `~/.local/share/applications/`, which is outside the scope of what GNOME Shell extensions can do on their own. The review guidelines for extensions.gnome.org prohibit installation scripts and files that modify the system outside the extension directory. Therefore, this extension is distributed via GitHub with installation scripts instead.

## Features

- Simple D-Bus interface to open GNOME Screenshot UI
- Desktop file integration for launching from application menu
- Lightweight and minimal resource usage
- Compatible with GNOME Shell 45-49

## Why This Extension?

While GNOME Shell already has built-in screenshot functionality (accessible via keyboard shortcuts and the top panel menu), this extension adds:
- A dedicated application launcher in your application menu
- A D-Bus interface for programmatic access
- Easy integration with custom scripts or workflows

## Installation

### Automatic Installation

1. Clone or download this repository
2. Navigate to the repository directory
3. Run the installation script:

```bash
chmod +x install.sh
./install.sh
```

4. Restart GNOME Shell:
   - **X11**: Press `Alt+F2`, type `r`, and press Enter
   - **Wayland**: Log out and log back in

5. The extension will be automatically enabled, and the "Screenshot" app will appear in your application menu

### Manual Installation

1. Copy extension files:
```bash
mkdir -p ~/.local/share/gnome-shell/extensions/screenshot-launcher@simple
cp extension.js metadata.json ~/.local/share/gnome-shell/extensions/screenshot-launcher@simple/
```

2. Copy desktop file:
```bash
cp screenshot-launcher.desktop ~/.local/share/applications/
chmod +x ~/.local/share/applications/screenshot-launcher.desktop
update-desktop-database ~/.local/share/applications/
```

3. Restart GNOME Shell (see instructions above)

4. Enable the extension:
```bash
gnome-extensions enable screenshot-launcher@simple
```

## Uninstallation

Run the uninstall script:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

Or manually remove the files:

```bash
rm -rf ~/.local/share/gnome-shell/extensions/screenshot-launcher@simple
rm ~/.local/share/applications/screenshot-launcher.desktop
update-desktop-database ~/.local/share/applications/
gnome-extensions disable screenshot-launcher@simple
```

## Usage

### From Application Menu
Simply search for "Screenshot" in your application launcher and click to open the GNOME Screenshot UI.

### From Command Line
```bash
gdbus call --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell/Extensions/ScreenshotLauncher \
  --method org.gnome.Shell.Extensions.ScreenshotLauncher.Open
```

### From Scripts
You can integrate this into your own scripts or automation tools using the D-Bus interface shown above.

## D-Bus Interface

- **Bus Name**: org.gnome.Shell
- **Object Path**: /org/gnome/Shell/Extensions/ScreenshotLauncher
- **Interface**: org.gnome.Shell.Extensions.ScreenshotLauncher
- **Method**: Open() → returns boolean (true on success)

## Compatibility

- GNOME Shell 45, 46, 47, 48, 49
- Tested on Wayland 

## Files

- `extension.js` - Main extension code
- `metadata.json` - Extension metadata
- `screenshot-launcher.desktop` - Desktop file for application menu
- `install.sh` - Automated installation script
- `uninstall.sh` - Automated uninstallation script

## Troubleshooting

### Extension not working after installation
- Make sure you've restarted GNOME Shell
- Check if the extension is enabled: `gnome-extensions list --enabled`
- Check for errors: `journalctl -f -o cat /usr/bin/gnome-shell`

### Desktop file not appearing
- Update the desktop database: `update-desktop-database ~/.local/share/applications/`
- Log out and log back in
- Check if the file exists: `ls ~/.local/share/applications/screenshot-launcher.desktop`

### D-Bus method not responding
- Ensure the extension is enabled and GNOME Shell has been restarted
- Check D-Bus availability: `gdbus introspect --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/ScreenshotLauncher`

## License

GPL-2.0-or-later (compatible with GNOME Shell)

## Contributing

Issues and pull requests are welcome on GitHub.


