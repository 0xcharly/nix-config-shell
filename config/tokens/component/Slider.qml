import QtQuick
import Quickshell.Io
import qs.config
import qs.config.tokens.types

JsonObject {
    property int width: 10
    property int height: 150
    property int thumbSize: 28
    property color inactiveTrackColor: Config.tokens.system.colors.slider_inactive_track
    property color activeTrackColor: Config.tokens.system.colors.slider_active_track

    property SliderThumb thumb: SliderThumb {}

    component SliderThumb: JsonObject {
        property color color: Config.tokens.system.colors.slider_thumb
        property color contentColor: Config.tokens.system.colors.surface
        property TypographyValues iconTypography: Config.tokens.system.typography.icon
        property TypographyValues textTypography: Config.tokens.system.typography.smallLabel
    }
}
