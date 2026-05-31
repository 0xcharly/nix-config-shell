pragma ComponentBehavior: Bound

import qs.config.tokens.feature
import qs.components
import qs.services as ArcServices
import QtQuick
import QtQuick.Layouts

ArcRectangle {
    id: root

    required property Clock theme

    implicitHeight: layout.implicitHeight + root.theme.padding.top + root.theme.padding.bottom
    implicitWidth: layout.implicitWidth + root.theme.padding.left + root.theme.padding.right

    color: root.theme.colors.surface
    anchors.bottomMargin: root.theme.padding.bottom
    anchors.leftMargin: root.theme.padding.left
    anchors.rightMargin: root.theme.padding.right
    anchors.topMargin: root.theme.padding.top

    ColumnLayout {
        id: layout

        Layout.alignment: Qt.AlignHCenter
        spacing: root.theme.spacing

        ColumnLayout {
            id: time
            Layout.alignment: Qt.AlignHCenter

            ArcText {
                Layout.alignment: Qt.AlignHCenter
                tabularFigures: true
                color: root.theme.colors.content
                style: root.theme.typography
                text: ArcServices.Clock.timeHours
            }
            ArcText {
                Layout.alignment: Qt.AlignHCenter
                tabularFigures: true
                color: root.theme.colors.content
                style: root.theme.typography
                text: ArcServices.Clock.timeMinutes
            }
        }

        ColumnLayout {
            id: date
            Layout.alignment: Qt.AlignHCenter

            ArcText {
                Layout.alignment: Qt.AlignHCenter
                tabularFigures: true
                color: root.theme.colors.content
                style: root.theme.typography
                text: ArcServices.Clock.dayMonth
            }
            ArcText {
                Layout.alignment: Qt.AlignHCenter
                color: root.theme.colors.content
                style: root.theme.typography
                text: ArcServices.Clock.dayWeek
            }
        }
    }
}
