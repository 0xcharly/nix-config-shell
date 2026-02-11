pragma ComponentBehavior: Bound

import QtQuick

Item {
    id: root

    property bool wallpaperAnimationEnabled: false

    ShaderEffect {
        anchors.fill: parent

        property real time: 0
        property vector2d resolution: Qt.vector2d(width, height)

        fragmentShader: "wallpaper.frag.qsb"

        NumberAnimation on time {
            running: root.wallpaperAnimationEnabled
            from: 0
            to: 1_000
            duration: 1_000_000
            loops: Animation.Infinite
        }
    }
}
