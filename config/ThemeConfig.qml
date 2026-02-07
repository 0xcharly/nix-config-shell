import qs.config
import Quickshell.Io
import QtQuick

JsonObject {
    property ComponentDefaults defaults: ComponentDefaults {}
    property Hud hud: Hud {}
    property Typography typography: Typography {}

    component Hud: JsonObject {
        property Border border: Border {
            width: Config.measurements.small
            color: Config.palette.surface
            shape: Config.shapes.cornerSmall
        }
        property Widgets widgets: Widgets {}
        property ControlCenter controlCenter: ControlCenter {}
        property Osd osd: Osd {}
        property color scrim: Qt.alpha(border.color, 0.2)
        property color innerBorderShadow: Config.palette.inner_border_shadow
        property color innerBorderColor: Config.palette.inner_border
        property real opacity: 1
        property int barHeight: 32
    }

    component Border: JsonObject {
        property int width: 0
        property color color: Config.palette.surface
        property int shape: 0
    }

    component Widgets: JsonObject {
        property int horizontalSpacing: Config.measurements.extraSmall
        property Widget base: Widget {}
        property PowerManagement powerManagement: PowerManagement {}
        property Clock clock: Clock {}
        property Workspaces workspaces: Workspaces {}
    }

    component Widget: JsonObject {
        property bool enable: true
        property color color: Config.theme.hud.border.color
        property color contentColor: Config.palette.on_surface_variant
        property FontStyle typography: Config.theme.typography.mediumLabel
        property int spacedBy: Config.measurements.small
        property PaddingValues padding: PaddingValues {}
        property Border border: Border {}
    }

    component PowerManagement: Widget {
        enable: false
        spacedBy: Config.measurements.extraSmall
        color: Config.theme.hud.border.color
        property color warningColor: Config.palette.surface_attention
        property color warningContentColor: Config.palette.on_surface_attention
        property color criticalColor: Config.palette.surface_danger
        property color criticalContentColor: Config.palette.on_surface_danger
        padding: PaddingValues {
            bottom: Config.measurements.extraSmall
            left: Config.measurements.small
            right: Config.measurements.small
            top: Config.measurements.extraSmall
        }
    }

    component Clock: Widget {
        color: Config.theme.hud.border.color
        padding: PaddingValues {
            bottom: Config.measurements.extraSmall
            left: Config.measurements.small
            right: Config.measurements.small
            top: Config.measurements.extraSmall
        }
    }

    component Workspaces: Widget {
        spacedBy: Config.measurements.none

        property Workspace inactive: Workspace {
            color: Config.theme.hud.border.color
            contentColor: Config.palette.on_surface_variant
        }

        property Workspace active: Workspace {
            color: Config.palette.surface_accent
            contentColor: Config.palette.on_surface_accent
        }

        property Workspace hovered: Workspace {
            color: Config.palette.surface_done
            contentColor: Config.palette.on_surface_done
        }

        property Workspace needsAttention: Workspace {
            color: Config.palette.surface_danger
            contentColor: Config.palette.on_surface_danger
        }
    }

    component Workspace: JsonObject {
        property color color
        property color contentColor
        property Border border: Border {
            shape: Config.shapes.cornerSmall
        }
        property FontStyle typography: Config.theme.typography.mediumLabel
        property PaddingValues padding: PaddingValues {
            bottom: Config.measurements.extraSmall
            left: Config.measurements.small
            right: Config.measurements.small
            top: Config.measurements.extraSmall
        }
    }

    component ControlCenter: JsonObject {
        property int hideDelay: 2000
        property PaddingValues padding: PaddingValues {
            bottom: Config.measurements.extraSmall
            left: Config.measurements.medium
            right: Config.measurements.small
            top: Config.measurements.medium
        }
        property int spacedBy: Config.measurements.medium

        property IdleInhibitor idleInhibitor: IdleInhibitor {}
    }

    component IdleInhibitor: JsonObject {
        property int verticalSpacing: Config.measurements.medium
        property PaddingValues padding: PaddingValues {
            bottom: Config.measurements.medium
            left: Config.measurements.medium
            right: Config.measurements.medium
            top: Config.measurements.medium
        }
        property SurfaceTokens icon: SurfaceTokens {
            colors: SurfaceColorValues {
                surface: Config.palette.surface_accent
                content: Config.palette.on_surface_accent
            }
            property PaddingValues padding: PaddingValues {
                bottom: Config.measurements.small
                left: Config.measurements.small
                right: Config.measurements.small
                top: Config.measurements.small
            }
            property int shape: Config.shapes.cornerFull
            property FontStyle typography: Config.theme.typography.icon
        }
        property SurfaceColorValues iconChecked: SurfaceColorValues {
            surface: Config.palette.surface_done
            content: Config.palette.on_surface_done
        }
        property FontStyle titleTypography: Config.theme.typography.title
        property FontStyle bodyTypography: Config.theme.typography.body
        property color bodyContentColor: Config.palette.on_surface_variant
        property SurfaceTokens surface: Config.theme.defaults.cards
        property SwitchTokens switch_: SwitchTokens {}
        property SurfaceTokens activeChip: Config.theme.defaults.chips
        property AnimationValues activeChipAnimation: AnimationValues {
            duration: Config.animations.durations.expressiveDefaultSpatial
            curve: Config.animations.curves.expressiveDefaultSpatial
        }
    }

    component Osd: JsonObject {
        property int hideDelay: 2000
        property Slider slider: Slider {}
        property PaddingValues padding: PaddingValues {
            bottom: Config.measurements.large
            left: Config.measurements.medium
            right: Config.measurements.medium
            top: Config.measurements.large
        }
        property int spacedBy: Config.measurements.medium
    }

    component Slider: JsonObject {
        property int width: 10
        property int height: 150
        property int thumbSize: 28
        property color inactiveTrackColor: Config.palette.slider_inactive_track
        property color activeTrackColor: Config.palette.slider_active_track
        property SliderThumb thumb: SliderThumb {}
    }

    component SliderThumb: JsonObject {
        property color color: Config.palette.slider_thumb
        property color contentColor: Config.palette.surface
        property FontStyle iconTypography: Config.theme.typography.icon
        property FontStyle textTypography: Config.theme.typography.smallLabel
    }

    component ComponentDefaults: JsonObject {
        property SwitchTokens switches: SwitchTokens {}
        property SurfaceTokens cards: SurfaceTokens {
            colors: SurfaceColorValues {
                content: Config.palette.on_surface
                surface: Config.palette.surface_backdrop
            }
            padding: PaddingValues {
                bottom: Config.measurements.large
                left: Config.measurements.large
                right: Config.measurements.large
                top: Config.measurements.large
            }
            shape: Config.shapes.cornerLarge
            typography: Config.theme.typography.body
        }
        property SurfaceTokens chips: SurfaceTokens {
            colors: SurfaceColorValues {
                content: Config.palette.on_surface_accent
                surface: Config.palette.surface_accent
            }
            padding: PaddingValues {
                bottom: Config.measurements.small
                left: Config.measurements.medium
                right: Config.measurements.medium
                top: Config.measurements.small
            }
            shape: Config.shapes.cornerFull
            typography: Config.theme.typography.smallLabel
        }
    }

    component SurfaceTokens: JsonObject {
        property SurfaceColorValues colors: SurfaceColorValues {}
        property PaddingValues padding: PaddingValues {}
        property int shape: Config.shapes.cornerSquare
        property FontStyle typography: Config.theme.typography.body
    }

    component SwitchTokens: JsonObject {
        property color trackColorRest: Config.palette.surface_control_track_rest
        property color trackColorChecked: Config.palette.surface_control_track_checked

        property SurfaceColorValues thumbColorRest: SurfaceColorValues {
            surface: Config.palette.surface_control_thumb_rest
            content: Config.palette.on_surface_control_thumb_rest
        }
        property SurfaceColorValues thumbColorActive: SurfaceColorValues {
            surface: Config.palette.surface_control_thumb_active
            content: Config.theme.defaults.switches.thumbColorRest.content
        }
        property SurfaceColorValues thumbColorHover: SurfaceColorValues {
            surface: Config.palette.surface_control_thumb_hover
            content: Config.theme.defaults.switches.thumbColorRest.content
        }
        property SurfaceColorValues thumbColorChecked: SurfaceColorValues {
            surface: Config.palette.surface_control_thumb_checked
            content: Config.palette.on_surface_control_thumb_checked
        }
        property SurfaceColorValues thumbColorCheckedActive: SurfaceColorValues {
            surface: Config.palette.surface_control_thumb_checked_active
            content: Config.theme.defaults.switches.thumbColorChecked.content
        }
        property SurfaceColorValues thumbColorCheckedHover: SurfaceColorValues {
            surface: Config.palette.surface_control_thumb_checked_hover
            content: Config.theme.defaults.switches.thumbColorChecked.content
        }

        property int thumbSize: 22
        property PaddingValues thumbPadding: PaddingValues {
            bottom: Config.measurements.extraSmall
            left: Config.measurements.extraSmall
            right: Config.measurements.extraSmall
            top: Config.measurements.extraSmall
        }

        property real iconStrokeWidth: 2.25
        property PaddingValues iconPadding: PaddingValues {
            bottom: Config.measurements.extraSmall
            left: Config.measurements.extraSmall
            right: Config.measurements.extraSmall
            top: Config.measurements.extraSmall
        }

        property AnimationValues animation: AnimationValues {}
    }

    component SurfaceColorValues: JsonObject {
        property color content: Config.palette.on_surface
        property color surface: Config.palette.surface
    }

    component AnimationValues: JsonObject {
        property list<real> curve: Config.animations.curves.standard
        property int duration: Config.animations.durations.normal
    }

    component PaddingValues: JsonObject {
        property int bottom: Config.measurements.none
        property int left: Config.measurements.none
        property int right: Config.measurements.none
        property int top: Config.measurements.none
    }

    component Typography: JsonObject {
        property FontStyle icon: FontStyle {
            family: Config.typography.family.icon
            size: Config.typography.size.large
        }
        property FontStyle smallLabel: FontStyle {
            family: Config.typography.family.sansSerif
            size: Config.typography.size.extraSmall
            weight: FontWeight.medium
        }
        property FontStyle mediumLabel: FontStyle {
            family: Config.typography.family.sansSerif
            size: Config.typography.size.small
            weight: FontWeight.medium
        }
        property FontStyle body: FontStyle {
            family: Config.typography.family.sansSerif
            size: Config.typography.size.medium
        }
        property FontStyle title: FontStyle {
            family: Config.typography.family.sansSerif
            size: Config.typography.size.large
        }
        property FontStyle display: FontStyle {
            family: Config.typography.family.sansSerif
            size: Config.typography.size.extraLarge
        }
    }

    component FontStyle: JsonObject {
        property string family
        property TypographyConfig.FontMeasurements size
        property int weight: FontWeight.normal
        property bool italic: false
        property bool underline: false
    }
}
