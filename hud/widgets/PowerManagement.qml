pragma ComponentBehavior: Bound

import qs.config
import qs.components
import qs.services as Services
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Widget {
    id: root
    theme: Config.theme.hud.widgets.powerManagement

    implicitHeight: layout.implicitHeight + 2 * border.width
    implicitWidth: layout.implicitWidth + 2 * border.width

    RowLayout {
        id: layout
        spacing: root.theme.spacedBy

        anchors.fill: parent
        PowerManagementIcon {
            bottomPadding: root.theme.padding.bottom
            leftPadding: root.theme.padding.left
            topPadding: root.theme.padding.top
        }

        AnimatedText {
            id: label

            bottomPadding: root.theme.padding.bottom
            rightPadding: root.theme.padding.right
            topPadding: root.theme.padding.top

            font.features: {
                "tnum": 1 // Enables tabular figures
            }

            color: root.theme.contentColor
            style: root.theme.typography
            text: `${Math.round(UPower.displayDevice.percentage * 100)}%`
        }
    }
}
