pragma ComponentBehavior: Bound

import qs.config.tokens.feature as FeatureTokens
import qs.components
import Quickshell
import Quickshell.Wayland
import QtQuick

Variants {
    id: root

    required property FeatureTokens.Desktop theme

    model: Quickshell.screens

    ArcWindow {
        id: win

        required property ShellScreen modelData

        name: "desktop"
        screen: modelData

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background

        color: root.theme.colors.surface

        anchors.top: true
        anchors.bottom: true
        anchors.left: true
        anchors.right: true

        Wallpaper {
            id: wallpaper

            anchors.fill: parent
            wallpaperAnimationEnabled: root.theme.animateWallpaper
        }

        DesktopClock {
            id: clock
            theme: root.theme.clock

            absX: clock.x
            absY: clock.y
            wallpaper: wallpaper

            anchors.right: parent.right
            anchors.top: parent.top
        }
    }
}
