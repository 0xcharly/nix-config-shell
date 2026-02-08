import QtQuick
import Quickshell.Io

// Defaults from https://primer.style/primitives/storybook/
JsonObject {
    property color on_surface: "#f0f6fc" // fgColor-default
    property color on_surface_variant: "#9198a1" // fgColor-muted
    property color surface: "#0d1117" // bgColor-default

    property color surface_danger: "#1af85149" // bgColor-danger-muted
    property color on_surface_danger: "#f85149" // fgColor-danger

    property color surface_attention: "#26bb8009" // bgColor-attention-muted
    property color on_surface_attention: "#d29922" // fgColor-attention

    property color surface_accent: "#1a388bfd" // bgColor-accent-muted
    property color on_surface_accent: "#4493f8" // fgColor-accent

    property color surface_done: "#26ab7df8" // bgColor-done-muted
    property color on_surface_done: "#ab7df8" // fgColor-done

    property color surface_backdrop: "#66212830" // overlay-backdrop-bgColor

    property color surface_control_active: "#2a313c" // control-bgColor-active
    property color surface_control_disabled: "#212830" // control-bgColor-disabled
    property color surface_control_hover: "#262c36" // control-bgColor-hover
    property color surface_control_rest: "#212830" // control-bgColor-rest

    // TODO: probably don't need
    property color on_surface_icon_control_rest: "#9198a1" // control-iconColor-rest

    property color surface_control_track_active: "#2f3742" // controlTrack-bgColor-active

    property color on_surface_control_placeholder: "#9198a1" // control-fgColor-placeholder
    property color surface_control_track_hover: "#2a313c" // controlTrack-bgColor-hover

    property color on_surface_control_disabled: "#656c76" // control-fgColor-disabled
    property color surface_control_track_disabled: "#656c76" // controlTrack-bgColor-disabled

    property color on_surface_control_rest: "#f0f6fc" // control-fgColor-rest
    property color surface_control_track_rest: "#262c36" // controlTrack-bgColor-rest

    property color on_surface_control_track_checked: "#3fb950" // fgColor-success
    property color surface_control_track_checked: "#262ea043" // bgColor-success-muted

    property color on_surface_control_thumb_rest: "#262c36" // bgColor-neutral-muted
    property color surface_control_thumb_rest: "#656c76" // bgColor-neutral-emphasis
    property color surface_control_thumb_checked: "#238636" // bgColor-success-emphasis
    property color on_surface_control_thumb_checked: "#1e3226" // bgColor-success-muted

    property color surface_control_thumb_active: "#332a313c" // control-bgColor-active
    property color surface_control_thumb_hover: "#26262c36" // control-bgColor-hover
    property color surface_control_thumb_checked_active: "#332ea043"
    property color surface_control_thumb_checked_hover: "#262ea043" // bgColor-success-muted

    property color inner_border: "#8250df" // borderColor-done-emphasis
    property color inner_border_shadow: "#c297ff" // borderColor-done-muted

    property color slider_active_track: "#203147"
    property color slider_inactive_track: "#7a8490"
    property color slider_thumb: "#f1b48e"
}
