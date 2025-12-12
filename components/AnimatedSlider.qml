import qs.config
import QtQuick
import QtQuick.Templates

Slider {
    id: root

    required property string icon
    property real oldValue
    property bool initialized

    orientation: Qt.Vertical

    background: AnimatedRectangle {
        color: Config.theme.hud.osd.slider.inactiveTrackColor
        radius: Config.shapes.cornerFull

        implicitWidth: Config.theme.hud.osd.slider.width
        width: implicitWidth
        x: root.leftPadding + root.availableWidth / 2 - width / 2

        AnimatedRectangle {
            anchors.left: parent.left
            anchors.right: parent.right

            y: root.handle.y
            implicitHeight: parent.height - y

            color: Config.theme.hud.osd.slider.activeTrackColor
            radius: parent.radius
        }
    }

    handle: Item {
        id: handle

        property alias moving: icon.moving

        x: root.leftPadding + root.availableWidth / 2 - width / 2
        y: root.topPadding + root.visualPosition * (root.availableHeight - height)
        implicitWidth: Config.theme.hud.osd.slider.thumbSize
        implicitHeight: Config.theme.hud.osd.slider.thumbSize

        Elevation {
            anchors.fill: parent
            radius: rect.radius
            level: handleInteraction.containsMouse ? 2 : 1
        }

        AnimatedRectangle {
            id: rect

            anchors.fill: parent

            color: Config.theme.hud.osd.slider.thumb.color
            radius: Config.shapes.cornerFull

            MouseArea {
                id: handleInteraction

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.NoButton
            }

            MaterialIcon {
                id: icon

                property bool moving

                function update(): void {
                    binding.when = moving;
                    style = moving ? Config.theme.hud.osd.slider.thumb.textTypography : Config.theme.hud.osd.slider.thumb.iconTypography;
                }

                style: Config.theme.hud.osd.slider.thumb.iconTypography
                text: root.icon
                color: Config.theme.hud.osd.slider.thumb.contentColor
                anchors.centerIn: parent

                onMovingChanged: anim.restart()

                Binding {
                    id: binding

                    target: icon
                    property: "text"
                    value: Math.round(root.value * 100)
                    when: false
                }

                SequentialAnimation {
                    id: anim

                    AnimatedNumber {
                        target: icon
                        property: "scale"
                        to: 0
                        duration: Config.animations.durations.normal / 2
                        easing.bezierCurve: Config.animations.curves.standardAccel
                    }
                    ScriptAction {
                        script: icon.update()
                    }
                    AnimatedNumber {
                        target: icon
                        property: "scale"
                        to: 1
                        duration: Config.animations.durations.normal / 2
                        easing.bezierCurve: Config.animations.curves.standardDecel
                    }
                }
            }
        }
    }

    onPressedChanged: handle.moving = pressed

    onValueChanged: {
        if (!initialized) {
            initialized = true;
            return;
        }
        if (Math.abs(value - oldValue) < 0.01)
            return;
        oldValue = value;
        handle.moving = true;
        stateChangeDelay.restart();
    }

    Timer {
        id: stateChangeDelay

        interval: 500
        onTriggered: {
            if (!root.pressed)
                handle.moving = false;
        }
    }

    Behavior on value {
        AnimatedNumber {
            duration: Config.animations.durations.large
        }
    }
}
