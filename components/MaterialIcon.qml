pragma ComponentBehavior: Bound

import qs.config

AnimatedText {
    property real fill
    property int grade: 0

    style: Config.theme.typography.icon
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: grade,
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })
}
