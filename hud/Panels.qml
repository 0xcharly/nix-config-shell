import qs.config
import qs.hud.osd as Osd
import Quickshell
import QtQuick

Item {
    id: root

    required property ShellScreen screen
    required property Item bar

    readonly property alias osd: osd

    anchors.fill: parent
    anchors.margins: Config.theme.hud.border.width
    anchors.bottomMargin: bar.implicitHeight

    Osd.Wrapper {
        id: osd

        clip: false
        screen: root.screen

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }
}
