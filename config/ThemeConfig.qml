import qs.config
import Quickshell.Io
import QtQuick

JsonObject {
    property Hud hud: Hud {}
    property Typography typography: Typography {}

    component Hud: JsonObject {
        property Border border: Border {
            width: Config.measurements.small
            color: Config.palette.crust
            shape: Config.shapes.cornerSmall
        }
        property Widgets widgets: Widgets {}
        property color scrim: Qt.alpha(border.color, 0.2)
        property color shadow: Qt.alpha(border.color, 0.1)
        property real opacity: 1
        property int barHeight: 32
    }

    component Border: JsonObject {
        property int width: 0
        property color color: Config.palette.base
        property int shape: 0
    }

    component Widgets: JsonObject {
        property int horizontalSpacing: Config.measurements.extraSmall
        property Widget base: Widget {}
        property Clock clock: Clock {}
        property Workspaces workspaces: Workspaces {}
    }

    component Widget: JsonObject {
        property color color: Config.theme.hud.border.color
        property color contentColor: Config.palette.text
        property FontStyle typography: Config.theme.typography.label
        property int spacedBy: Config.measurements.small
        property PaddingValues padding: PaddingValues {}
        property Border border: Border {}
    }

    component Clock: Widget {
        color: Config.theme.hud.border.color
        contentColor: Config.palette.subtext0
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
            contentColor: Config.palette.subtext0
        }

        property Workspace active: Workspace {
            color: Config.palette.surface_blue
            contentColor: Config.palette.on_surface_blue
        }

        property Workspace hovered: Workspace {
            color: Config.palette.surface_purple
            contentColor: Config.palette.on_surface_purple
        }

        property Workspace needsAttention: Workspace {
            color: Config.palette.surface_red
            contentColor: Config.palette.on_surface_red
        }
    }

    component Workspace: JsonObject {
        property color color
        property color contentColor
        property Border border: Border {
            shape: Config.shapes.cornerSmall
        }
        property FontStyle typography: Config.theme.typography.label
        property PaddingValues padding: PaddingValues {
            bottom: Config.measurements.extraSmall
            left: Config.measurements.small
            right: Config.measurements.small
            top: Config.measurements.extraSmall
        }
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
        property FontStyle label: FontStyle {
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
