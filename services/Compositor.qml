pragma Singleton

import Quickshell
import QtQuick

// https://wiki.hypr.land/Configuring/Dispatchers/
Singleton {
    id: root

    readonly property string name: Quickshell.env("XDG_CURRENT_DESKTOP")
    readonly property var ipc: {
        switch (name) {
        case "Hyprland":
            return IpcHyprland;
        case "none+i3":
        case "sway":
            return IpcI3;
        }
        return undefined;
    }
}
