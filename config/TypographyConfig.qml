import Quickshell.Io

JsonObject {
    property FontFamily family: FontFamily {}
    property FontSize size: FontSize {}

    component FontFamily: JsonObject {
        id: family

        property string monospace: "monospace"
        property string sansSerif: "sansserif"
        property string serif: "serif"
    }

    component FontSize: JsonObject {
        id: size

        property real scale: 1
        property FontMeasurements small: FontMeasurements {
            fontSize: 10 * size.scale
            lineHeight: 14 * size.scale
        }
        property FontMeasurements medium: FontMeasurements {
            fontSize: 12 * size.scale
            lineHeight: 16 * size.scale
        }
        property FontMeasurements large: FontMeasurements {
            fontSize: 14 * size.scale
            lineHeight: 18 * size.scale
        }
        property FontMeasurements extraLarge: FontMeasurements {
            fontSize: 24 * size.scale
            lineHeight: 28 * size.scale
        }
    }

    component FontMeasurements: JsonObject {
        property int fontSize
        property int lineHeight
    }
}
