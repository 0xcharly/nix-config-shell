pragma ComponentBehavior: Bound

import qs.config
import QtQuick

Text {
    id: root

    property ThemeConfig.FontStyle style: Config.theme.typography.body

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    font.family: style.family
    font.pointSize: style.size.fontSize
    font.weight: style.weight
    font.underline: style.underline
    font.italic: style.italic
    fontSizeMode: Text.Fit
    lineHeight: style.size.lineHeight
    lineHeightMode: Text.FixedHeight
    verticalAlignment: Text.AlignVCenter

    Behavior on color {
        AnimatedColor {}
    }
}
