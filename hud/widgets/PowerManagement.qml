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

    ColumnLayout {
        id: layout
        spacing: root.theme.spacedBy

        anchors.fill: parent

        PowerManagementIcon {
            theme: root.theme.icon
            Layout.alignment: Qt.AlignHCenter
        }

        ArcText {
            id: label
            Layout.alignment: Qt.AlignHCenter

            tabularFigures: true
            color: root.theme.colors.content
            style: root.theme.typography
            text: UPower.displayDevice.state === UPowerDeviceState.FullyCharged ? "∞" : `${Math.ceil(UPower.displayDevice.percentage * 100)}%`
        }
    }
}
