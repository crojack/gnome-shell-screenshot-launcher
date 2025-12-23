// Minimal Screenshot Launcher Extension
import Gio from 'gi://Gio';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';

const ScreenshotLauncherIface = `
<node>
  <interface name="org.gnome.Shell.Extensions.ScreenshotLauncher">
    <method name="Open">
      <arg type="b" direction="out" name="success"/>
    </method>
  </interface>
</node>`;

export default class ScreenshotLauncherExtension extends Extension {
    enable() {
        try {
            const implementationObj = {
                Open() {
                    try {
                        if (Main.screenshotUI) {
                            Main.screenshotUI.open();
                            return [true];
                        } else {
                            console.error('Screenshot UI not available');
                            return [false];
                        }
                    } catch (e) {
                        console.error('Error opening screenshot UI:', e);
                        return [false];
                    }
                }
            };

            this._dbusImpl = Gio.DBusExportedObject.wrapJSObject(
                ScreenshotLauncherIface,
                implementationObj
            );
            this._dbusImpl.export(Gio.DBus.session, '/org/gnome/Shell/Extensions/ScreenshotLauncher');
            
            console.log('Screenshot Launcher extension enabled successfully');
        } catch (e) {
            console.error('Error enabling Screenshot Launcher extension:', e);
        }
    }

    disable() {
        try {
            if (this._dbusImpl) {
                this._dbusImpl.unexport();
                this._dbusImpl = null;
            }
            console.log('Screenshot Launcher extension disabled');
        } catch (e) {
            console.error('Error disabling Screenshot Launcher extension:', e);
        }
    }
}
