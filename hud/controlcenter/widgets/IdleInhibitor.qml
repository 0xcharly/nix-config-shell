pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

ArcRectangle {
    id: root

    // Layout.fillWidth: true
    implicitWidth: 500
    implicitHeight: layout.implicitHeight + (IdleInhibitor.enabled ? activeChip.implicitHeight + activeChip.anchors.topMargin : 0) + root.theme.padding.top + root.theme.padding.bottom

    readonly property ThemeConfig.IdleInhibitor theme: Config.theme.hud.controlCenter.idleInhibitor

    radius: root.theme.surface.shape
    color: root.theme.surface.colors.surface
    clip: true

    RowLayout {
        id: layout

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: root.theme.padding.bottom
        anchors.leftMargin: root.theme.padding.left
        anchors.rightMargin: root.theme.padding.right
        anchors.topMargin: root.theme.padding.top
        spacing: root.theme.verticalSpacing

        // Icon
        ArcRectangle {
            implicitWidth: implicitHeight
            implicitHeight: icon.implicitHeight + root.theme.icon.padding.top + root.theme.padding.bottom

            radius: Config.tokens.system.shapes.cornerFull
            color: IdleInhibitor.enabled ? root.theme.iconChecked.surface : root.theme.icon.colors.surface

            MaterialIcon {
                id: icon

                anchors.centerIn: parent

                text: "coffee"
                style: root.theme.icon.typography
                color: IdleInhibitor.enabled ? root.theme.iconChecked.content : root.theme.icon.colors.content
            }
        }

        // Text status
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 0

            ArcText {
                Layout.fillWidth: true
                text: qsTr("Keep Awake")
                color: root.theme.surface.colors.content
                style: root.theme.titleTypography
                elide: Text.ElideRight
            }

            ArcText {
                Layout.fillWidth: true
                text: IdleInhibitor.enabled ? qsTr("Preventing sleep mode") : qsTr("Normal power management")
                color: root.theme.bodyContentColor
                style: root.theme.bodyTypography
                elide: Text.ElideRight
            }
        }

        ArcSwitch {
            checked: IdleInhibitor.enabled
            onToggled: IdleInhibitor.enabled = checked
        }
    }

    // "Active since" chip
    Loader {
        id: activeChip

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: root.theme.verticalSpacing
        anchors.bottomMargin: IdleInhibitor.enabled ? root.theme.padding.bottom : -implicitHeight
        anchors.leftMargin: root.theme.padding.left

        opacity: IdleInhibitor.enabled ? 1 : 0
        scale: IdleInhibitor.enabled ? 1 : 0.5

        Component.onCompleted: active = Qt.binding(() => opacity > 0)

        sourceComponent: ArcChip {
            text: qsTr("Active since %1").arg(Qt.formatTime(IdleInhibitor.enabledSince, "hh:mm"))
            theme: root.theme.activeChip
        }

        Behavior on anchors.bottomMargin {
            AnimatedNumber {
                duration: root.theme.activeChipAnimation.duration
                easing.bezierCurve: root.theme.activeChipAnimation.curveIn
            }
        }

        Behavior on opacity {
            AnimatedNumber {
                duration: Config.tokens.system.animations.durations.small
            }
        }

        Behavior on scale {
            AnimatedNumber {}
        }
    }

    Behavior on implicitHeight {
        AnimatedNumber {
            duration: root.theme.activeChipAnimation.duration
            easing.bezierCurve: root.theme.activeChipAnimation.curveIn
        }
    }
}
