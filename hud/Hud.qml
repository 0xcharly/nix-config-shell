pragma ComponentBehavior: Bound

import qs.config
import qs.components
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Effects

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        HudExclusiveZones {
            screen: scope.modelData
            bar: bar
        }

        ArcWindow {
            id: win

            name: "hud"
            screen: scope.modelData
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

            property bool dimmed: false

            mask: Region {
                x: Config.theme.hud.border.width
                y: Config.theme.hud.border.width
                width: win.width - Config.theme.hud.border.width * 2
                height: win.height - bar.implicitHeight - Config.theme.hud.border.width
                intersection: Intersection.Xor

                // regions: regions.instances
            }

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            HyprlandFocusGrab {
                id: focusGrab

                active: false
                windows: [win]
            }

            AnimatedRectangle {
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
                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    blurMax: 15
                    shadowColor: Config.theme.hud.shadow
                }

                HudBorder {
                    bar: bar
                }

                Bar {
                    id: bar
                    screen: scope.modelData
                }
            }
        }
    }
}
