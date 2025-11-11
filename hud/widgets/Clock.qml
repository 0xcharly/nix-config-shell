pragma ComponentBehavior: Bound

import qs.config
import qs.components
import qs.services as Services
import QtQuick

Widget {
    id: root
    theme: Config.theme.hud.widgets.clock

    implicitHeight: layout.implicitHeight + 2 * border.width
    implicitWidth: layout.implicitWidth + 2 * border.width

    AnimatedText {
        id: layout

        anchors.fill: parent
        bottomPadding: root.theme.padding.bottom
        leftPadding: root.theme.padding.left
        rightPadding: root.theme.padding.right
        topPadding: root.theme.padding.top

        // NOTE: workaround to Japanese characters taller than ASCII.
        anchors.topMargin: -5

        font.features: {
            "tnum": 1 // Enables tabular figures
        }

        color: root.theme.contentColor
        style: root.theme.typography
        text: Services.Clock.datetime
    }
}
