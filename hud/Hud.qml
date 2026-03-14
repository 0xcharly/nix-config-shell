pragma ComponentBehavior: Bound

import qs.config
import qs.components
import qs.services
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland

Variants {
    model: Quickshell.screens

    Scope {
        id: screen
        required property ShellScreen modelData

        property HyprlandWorkspace workspace: Hypr.monitorFor(modelData).activeWorkspace
        property bool hasFullscreen: workspace?.hasFullscreen ?? false

        HudExclusiveZones {
            screen: screen.modelData
            bar: bar
        }

        ArcWindow {
            id: win

            name: "hud"
            screen: screen.modelData
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

            property bool dimmed: false

            mask: Region {
                x: Config.theme.hud.border.width
                y: Config.theme.hud.border.width
                width: win.width - Config.theme.hud.border.width * 2
                height: win.height - bar.implicitHeight - Config.theme.hud.border.width
                intersection: Intersection.Xor

                regions: regions.instances
            }

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            Variants {
                id: regions

                model: panels.children

                Region {
                    required property Item modelData

                    x: modelData.x + Config.theme.hud.border.width
                    y: modelData.y + Config.theme.hud.border.width
                    width: modelData.width
                    height: modelData.height
                    intersection: Intersection.Subtract
                }
            }

            // HyprlandFocusGrab {
            //     id: focusGrab
            //
            //     active: false
            //     windows: [win]
            // }

            ArcRectangle {
                anchors.fill: parent
                opacity: win.dimmed ? 0.5 : 0
                color: Config.theme.hud.scrim

                Behavior on opacity {
                    AnimatedNumber {}
                }
            }

            Item {
                anchors.fill: parent
                opacity: Config.theme.hud.opacity

                // HUD colored inner shadow.
                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    blurMax: 64
                    shadowBlur: 0.3
                    shadowColor: screen.hasFullscreen ? Config.theme.hud.innerBorderFullscreen.shadow : Config.theme.hud.innerBorder.shadow
                }

                // HUD colored inner border.
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: Config.theme.hud.border.width
                    anchors.bottomMargin: bar.implicitHeight
                    color: "transparent"
                    border.color: screen.hasFullscreen ? Config.theme.hud.innerBorderFullscreen.color : Config.theme.hud.innerBorder.color
                    border.width: 1
                    radius: Config.theme.hud.border.shape
                }

                Drawers {
                    bar: bar
                    panels: panels
                    hasFullscreen: screen.hasFullscreen
                }

                HudBorder {
                    bar: bar
                }
            }

            Interactions {
                screen: screen.modelData
                panels: panels
                bar: bar

                Panels {
                    id: panels

                    screen: screen.modelData
                    bar: bar
                }

                Bar {
                    id: bar
                    screen: screen.modelData

                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
        }
    }
}
