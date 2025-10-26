pragma ComponentBehavior: Bound

import qs.config
import qs.hud.widgets
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: layout
    spacing: Config.theme.hud.widgets.horizontalSpacing

    Workspaces {}
}
