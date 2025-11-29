pragma ComponentBehavior: Bound

import qs.config
import qs.components
import Quickshell
import Quickshell.Wayland
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
                    blurMax: 64
                    shadowBlur: 0.3
                    shadowColor: Config.theme.hud.shadowBlur
                }

                HudBorder {
                    bar: bar
                }

                Drawers {
                    bar: bar
                    panels: panels
                }
            }

            Interactions {
                screen: scope.modelData
                panels: panels
                bar: bar

                Panels {
                    id: panels

                    screen: scope.modelData
                    bar: bar
                }

                Bar {
                    id: bar
                    screen: scope.modelData

                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
        }
    }
}
