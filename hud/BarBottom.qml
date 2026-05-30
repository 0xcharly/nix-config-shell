pragma ComponentBehavior: Bound

import qs.config
import qs.hud.widgets
import Quickshell
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: layout

    required property ShellScreen screen

    spacing: Config.theme.hud.bar.spacedBy

    Loader {
        asynchronous: true
        visible: Config.theme.hud.bar.power.enable

        sourceComponent: PowerManagement {
            theme: Config.theme.hud.bar.power
            Layout.alignment: Qt.AlignHCenter
        }
    }

    Clock {
        theme: Config.theme.hud.bar.clock
        Layout.alignment: Qt.AlignHCenter
    }
}
