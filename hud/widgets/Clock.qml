pragma ComponentBehavior: Bound

import qs.config.tokens.feature
import qs.components
import qs.services as ArcServices
import QtQuick

ArcRectangle {
    id: root

    required property Clock theme

    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth

    color: root.theme.colors.surface

    anchors.bottomMargin: root.theme.padding.bottom
    anchors.leftMargin: root.theme.padding.left
    anchors.rightMargin: root.theme.padding.right
    anchors.topMargin: root.theme.padding.top

    ArcText {
        id: layout

        anchors.fill: parent
        anchors.bottomMargin: 5

        tabularFigures: true
        color: root.theme.colors.content
        style: root.theme.typography
        text: ArcServices.Clock.datetime
    }
}
