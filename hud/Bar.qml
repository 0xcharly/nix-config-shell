pragma ComponentBehavior: Bound

import qs.config
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    required property ShellScreen screen

    readonly property int exclusiveZone: implicitHeight

    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right

    implicitHeight: Config.theme.hud.barHeight

    RowLayout {
        id: layout
        anchors.fill: parent

        BarLeft {
            screen: root.screen
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: Config.theme.hud.border.width
        }
        BarRight {
            screen: root.screen
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.rightMargin: Config.theme.hud.border.width
        }
    }
}
