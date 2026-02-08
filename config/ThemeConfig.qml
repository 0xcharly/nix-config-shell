import QtQuick

import Quickshell.Io
import qs.config
import qs.config.tokens.component as ComponentTokens
import qs.config.tokens.types

JsonObject {
    property ComponentDefaults defaults: ComponentDefaults {}
    property Hud hud: Hud {}

    component Hud: JsonObject {
        property Border border: Border {
            color: Config.tokens.system.colors.surface
            shape: Config.tokens.system.shapes.cornerSmall
            width: Config.tokens.system.measurements.small
        }
        property Widgets widgets: Widgets {}
        property ControlCenter controlCenter: ControlCenter {}
        property Osd osd: Osd {}
        property color scrim: Qt.alpha(border.color, 0.2)
        property color innerBorderShadow: Config.tokens.system.colors.inner_border_shadow
        property color innerBorderColor: Config.tokens.system.colors.inner_border
        property real opacity: 1
        property int barHeight: 32
    }

    component Border: JsonObject {
        property int width: 0
        property color color: Config.tokens.system.colors.surface
        property int shape: 0
    }

    component Widgets: JsonObject {
        property int horizontalSpacing: Config.tokens.system.measurements.extraSmall
        property Widget base: Widget {}
        property PowerManagement powerManagement: PowerManagement {}
        property Clock clock: Clock {}
        property Workspaces workspaces: Workspaces {}
    }

    component Widget: JsonObject {
        property bool enable: true
        property color color: Config.theme.hud.border.color
        property color contentColor: Config.tokens.system.colors.on_surface_variant
        property TypographyValues typography: Config.tokens.system.typography.mediumLabel
        property int spacedBy: Config.tokens.system.measurements.small
        property PaddingValues padding: PaddingValues {}
        property Border border: Border {}
    }

    component PowerManagement: Widget {
        enable: false
        spacedBy: Config.tokens.system.measurements.extraSmall
        color: Config.theme.hud.border.color
        property color warningColor: Config.tokens.system.colors.surface_attention
        property color warningContentColor: Config.tokens.system.colors.on_surface_attention
        property color criticalColor: Config.tokens.system.colors.surface_danger
        property color criticalContentColor: Config.tokens.system.colors.on_surface_danger
        padding: PaddingValues {
            bottom: Config.tokens.system.measurements.extraSmall
            left: Config.tokens.system.measurements.small
            right: Config.tokens.system.measurements.small
            top: Config.tokens.system.measurements.extraSmall
        }
    }

    component Clock: Widget {
        color: Config.theme.hud.border.color
        padding: PaddingValues {
            bottom: Config.tokens.system.measurements.extraSmall
            left: Config.tokens.system.measurements.small
            right: Config.tokens.system.measurements.small
            top: Config.tokens.system.measurements.extraSmall
        }
    }

    component Workspaces: Widget {
        spacedBy: Config.tokens.system.measurements.none

        property Workspace inactive: Workspace {
            color: Config.theme.hud.border.color
            contentColor: Config.tokens.system.colors.on_surface_variant
        }

        property Workspace active: Workspace {
            color: Config.tokens.system.colors.surface_accent
            contentColor: Config.tokens.system.colors.on_surface_accent
        }

        property Workspace hovered: Workspace {
            color: Config.tokens.system.colors.surface_done
            contentColor: Config.tokens.system.colors.on_surface_done
        }

        property Workspace needsAttention: Workspace {
            color: Config.tokens.system.colors.surface_danger
            contentColor: Config.tokens.system.colors.on_surface_danger
        }
    }

    component Workspace: JsonObject {
        property color color
        property color contentColor
        property Border border: Border {
            shape: Config.tokens.system.shapes.cornerSmall
        }
        property TypographyValues typography: Config.tokens.system.typography.mediumLabel
        property PaddingValues padding: PaddingValues {
            bottom: Config.tokens.system.measurements.extraSmall
            left: Config.tokens.system.measurements.small
            right: Config.tokens.system.measurements.small
            top: Config.tokens.system.measurements.extraSmall
        }
    }

    component ControlCenter: JsonObject {
        property int hideDelay: 2000
        property PaddingValues padding: PaddingValues {
            bottom: Config.tokens.system.measurements.extraSmall
            left: Config.tokens.system.measurements.medium
            right: Config.tokens.system.measurements.small
            top: Config.tokens.system.measurements.medium
        }
        property int spacedBy: Config.tokens.system.measurements.medium

        property IdleInhibitor idleInhibitor: IdleInhibitor {}
    }

    component IdleInhibitor: JsonObject {
        property int verticalSpacing: Config.tokens.system.measurements.medium
        property PaddingValues padding: PaddingValues {
            bottom: Config.tokens.system.measurements.medium
            left: Config.tokens.system.measurements.medium
            right: Config.tokens.system.measurements.medium
            top: Config.tokens.system.measurements.medium
        }
        property SurfaceTokens icon: SurfaceTokens {
            colors: SurfaceColorValues {
                surface: Config.tokens.system.colors.surface_accent
                content: Config.tokens.system.colors.on_surface_accent
            }
            property PaddingValues padding: PaddingValues {
                bottom: Config.tokens.system.measurements.small
                left: Config.tokens.system.measurements.small
                right: Config.tokens.system.measurements.small
                top: Config.tokens.system.measurements.small
            }
            property int shape: Config.tokens.system.shapes.cornerFull
            property TypographyValues typography: Config.tokens.system.typography.icon
        }
        property SurfaceColorValues iconChecked: SurfaceColorValues {
            surface: Config.tokens.system.colors.surface_done
            content: Config.tokens.system.colors.on_surface_done
        }
        property TypographyValues titleTypography: Config.tokens.system.typography.title
        property TypographyValues bodyTypography: Config.tokens.system.typography.body
        property color bodyContentColor: Config.tokens.system.colors.on_surface_variant
        property SurfaceTokens surface: Config.theme.defaults.cards
        property ComponentTokens.Switch switch_: ComponentTokens.Switch {}
        property SurfaceTokens activeChip: Config.theme.defaults.chips
        property AnimationValues activeChipAnimation: AnimationValues {
            duration: Config.tokens.system.animations.durations.expressiveDefaultSpatial
            curve: Config.tokens.system.animations.curves.expressiveDefaultSpatial
        }
    }

    component Osd: JsonObject {
        property int hideDelay: 2000
        property ComponentTokens.Slider slider: ComponentTokens.Slider {}
        property PaddingValues padding: PaddingValues {
            bottom: Config.tokens.system.measurements.large
            left: Config.tokens.system.measurements.medium
            right: Config.tokens.system.measurements.medium
            top: Config.tokens.system.measurements.large
        }
        property int spacedBy: Config.tokens.system.measurements.medium
    }

    component ComponentDefaults: JsonObject {
        property ComponentTokens.Switch switches: ComponentTokens.Switch {}
        property SurfaceTokens cards: SurfaceTokens {
            colors: SurfaceColorValues {
                content: Config.tokens.system.colors.on_surface
                surface: Config.tokens.system.colors.surface_backdrop
            }
            padding: PaddingValues {
                bottom: Config.tokens.system.measurements.large
                left: Config.tokens.system.measurements.large
                right: Config.tokens.system.measurements.large
                top: Config.tokens.system.measurements.large
            }
            shape: Config.tokens.system.shapes.cornerLarge
            typography: Config.tokens.system.typography.body
        }
        property SurfaceTokens chips: SurfaceTokens {
            colors: SurfaceColorValues {
                content: Config.tokens.system.colors.on_surface_accent
                surface: Config.tokens.system.colors.surface_accent
            }
            padding: PaddingValues {
                bottom: Config.tokens.system.measurements.small
                left: Config.tokens.system.measurements.medium
                right: Config.tokens.system.measurements.medium
                top: Config.tokens.system.measurements.small
            }
            shape: Config.tokens.system.shapes.cornerFull
            typography: Config.tokens.system.typography.smallLabel
        }
    }

    component SurfaceTokens: JsonObject {
        property SurfaceColorValues colors: SurfaceColorValues {}
        property PaddingValues padding: PaddingValues {}
        property int shape: Config.tokens.system.shapes.cornerSquare
        property TypographyValues typography: Config.tokens.system.typography.body
    }
}
