pragma ComponentBehavior: Bound

import qs.config
import QtQuick

Text {
    id: root

    property ThemeConfig.FontStyle style: Config.theme.typography.body
    property bool animate: false
    property string animateProp: "scale"
    property real animateFrom: 0
    property real animateTo: 1
    property int animateDuration: Config.animations.durations.normal

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

    Behavior on text {
        enabled: root.animate

        SequentialAnimation {
            Anim {
                to: root.animateFrom
                easing.bezierCurve: Config.animations.curves.standardAccel
            }
            PropertyAction {}
            Anim {
                to: root.animateTo
                easing.bezierCurve: Config.animations.curves.standardDecel
            }
        }
    }

    component Anim: AnimatedNumber {
        target: root
        property: root.animateProp
        duration: root.animateDuration / 2
        easing.type: Easing.BezierSpline
    }
}
