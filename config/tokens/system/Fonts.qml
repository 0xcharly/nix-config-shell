import Quickshell.Io

JsonObject {
    component Family: JsonObject {
        id: family

        property string icon: "Material Symbols Rounded"
        property string monospace: "monospace"
        property string sansSerif: "sansserif"
        property string serif: "serif"
    }

    component Size: JsonObject {
        id: size

        property real scale: 1
        property Measurements extraSmall: Measurements {
            fontSize: 8 * size.scale
            lineHeight: 12 * size.scale
        }
        property Measurements small: Measurements {
            fontSize: 10 * size.scale
            lineHeight: 14 * size.scale
        }
        property Measurements medium: Measurements {
            fontSize: 12 * size.scale
            lineHeight: 16 * size.scale
        }
        property Measurements large: Measurements {
            fontSize: 16 * size.scale
            lineHeight: 20 * size.scale
        }
        property Measurements extraLarge: Measurements {
            fontSize: 24 * size.scale
            lineHeight: 28 * size.scale
        }
    }

    component Weight: JsonObject {
        readonly property int thin: 100
        readonly property int extraLight: 200
        readonly property int light: 300
        readonly property int normal: 400
        readonly property int medium: 500
        readonly property int demiBold: 600
        readonly property int bold: 700
        readonly property int extraBold: 800
        readonly property int black: 900
    }

    component Measurements: JsonObject {
        property int fontSize
        property int lineHeight
    }

    component Style: JsonObject {
        property string family
        property Measurements size
        property int weight
        property bool italic
        property bool underline
    }
}
