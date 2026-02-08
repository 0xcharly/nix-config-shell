import Quickshell.Io
import qs.config

JsonObject {
    property int bottom: Config.tokens.system.measurements.none
    property int left: Config.tokens.system.measurements.none
    property int right: Config.tokens.system.measurements.none
    property int top: Config.tokens.system.measurements.none

    function all(value: int): PaddingValues {
        return {
            bottom: value,
            left: value,
            right: value,
            top: value
        } as PaddingValues;
    }
}
