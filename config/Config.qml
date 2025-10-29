pragma Singleton

import qs.config
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property alias theme: adapter.theme

  property alias wayland: adapter.wayland
  property alias measurements: adapter.measurements
  property alias palette: adapter.palette
  property alias shapes: adapter.shapes
  property alias typography: adapter.typography

  FileView {
    path: `${FileSystem.config}/shell.json`
    watchChanges: true
    onFileChanged: {
      reload();
    }
    onLoaded: {
      try {
        JSON.parse(text());
        // Toaster.toast(qsTr("Config hot reload"), qsTr("Config changes now available"), "rule_settings");
      } catch (e) {
        // Toaster.toast(qsTr("Config reload failed"), e.message, "settings_alert", Toast.Error);
      }
    }
    onLoadFailed: err => {
      if (err !== FileViewError.FileNotFound) {
        // Toaster.toast(qStr("Failed to road config"), FileViewError.toString(err), "settings_alert", Toast.Warning);
      }
    }

    JsonAdapter {
      id: adapter

      property ThemeConfig theme: ThemeConfig {}

      property WaylandConfig wayland: WaylandConfig {}
      property MeasurementsConfig measurements: MeasurementsConfig {}
      property PaletteConfig palette: PaletteConfig {}
      property ShapesConfig shapes: ShapesConfig {}
      property TypographyConfig typography: TypographyConfig {}
    }
  }
}
