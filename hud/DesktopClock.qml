pragma ComponentBehavior: Bound

import qs.config.tokens.feature as FeatureTokens
import qs.components
import qs.services as ArcServices
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

ArcRectangle {
    id: root

    property int absX
    property int absY
    property Item wallpaper
    property FeatureTokens.DesktopClock theme

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    anchors.rightMargin: root.theme.relativeX
    anchors.topMargin: root.theme.relativeY

    Loader {
        anchors.fill: parent
        active: root.theme.blurBackground

        sourceComponent: MultiEffect {
            source: ShaderEffectSource {
                sourceItem: root.wallpaper
                sourceRect: Qt.rect(root.absX, root.absY, root.width, root.height)
            }
            maskSource: background
            maskEnabled: true
            blurEnabled: true
            blur: 1
            blurMax: 64
            autoPaddingEnabled: false
        }
    }

    RowLayout {
        id: layout

        spacing: 0

        implicitWidth: contentLayout.implicitWidth
        implicitHeight: contentLayout.implicitHeight

        ArcRectangle {
            implicitWidth: root.theme.borders.width
            implicitHeight: contentLayout.implicitHeight

            color: root.theme.borders.color
        }

        ArcRectangle {
            id: background

            implicitWidth: contentLayout.implicitWidth
            implicitHeight: contentLayout.implicitHeight

            color: root.theme.colors.surface

            ColumnLayout {
                id: contentLayout

                spacing: root.theme.spacedBy

                ArcText {
                    id: time

                    Layout.minimumWidth: root.theme.width
                    Layout.leftMargin: root.theme.padding.left
                    Layout.rightMargin: root.theme.padding.right
                    Layout.topMargin: root.theme.padding.top

                    horizontalAlignment: Text.AlignRight

                    tabularFigures: true
                    color: root.theme.colors.content
                    style: root.theme.timeTypography
                    text: ArcServices.Clock.time
                }

                ArcText {
                    id: date

                    Layout.minimumWidth: root.theme.width
                    Layout.bottomMargin: root.theme.padding.bottom
                    Layout.leftMargin: root.theme.padding.left
                    Layout.rightMargin: root.theme.padding.right

                    horizontalAlignment: Text.AlignRight

                    tabularFigures: true
                    color: root.theme.dateContentColor
                    style: root.theme.dateTypography
                    text: ArcServices.Clock.date
                }
            }
        }

        ArcRectangle {
            implicitWidth: root.theme.borders.width
            implicitHeight: contentLayout.implicitHeight

            color: root.theme.borders.color
        }
    }
}
