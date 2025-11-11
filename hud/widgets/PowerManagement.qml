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
        PowerManagementIcon {}

        AnimatedText {
            id: label

            font.features: {
                "pnum": 1 // Enables proportional figures
            }

            color: root.theme.contentColor
            style: root.theme.typography
            text: `${Math.round(UPower.displayDevice.percentage * 100)}%`
        }
    }
}
