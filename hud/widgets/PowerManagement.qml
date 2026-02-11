pragma ComponentBehavior: Bound

import qs.config.tokens.feature as FeatureTokens
import qs.components
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

ArcRectangle {
    id: root

    required property FeatureTokens.PowerManagement theme

    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth

    color: root.theme.colors.surface

    anchors.bottomMargin: root.theme.padding.bottom
    anchors.leftMargin: root.theme.padding.left
    anchors.rightMargin: root.theme.padding.right
    anchors.topMargin: root.theme.padding.top

    RowLayout {
        id: layout
        spacing: root.theme.spacedBy

        anchors.fill: parent

        PowerManagementIcon {
            theme: root.theme.icon
        }

        ArcText {
            id: label

            tabularFigures: true
            color: root.theme.colors.content
            style: root.theme.typography
            text: `${Math.round(UPower.displayDevice.percentage * 100)}%`
        }
    }
}
