pragma ComponentBehavior: Bound

import qs.config
import Quickshell.Widgets
import QtQuick

ClippingRectangle {
    id: root

    property ThemeConfig.Widget theme: Config.theme.hud.widgets.base

    color: theme.color
    radius: theme.border.shape
    border.color: theme.border.color
    border.width: theme.border.width
}
