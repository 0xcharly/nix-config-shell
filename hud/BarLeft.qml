pragma ComponentBehavior: Bound

import qs.config
import qs.hud.widgets
import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: layout

    required property ShellScreen screen

    spacing: Config.theme.hud.widgets.horizontalSpacing

    Workspaces {
      screen: layout.screen
    }
}
