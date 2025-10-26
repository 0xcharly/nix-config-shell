pragma ComponentBehavior: Bound

import qs.components
import qs.config
import QtQuick
import QtQuick.Effects

Item {
  id: root

  required property Item bar

  anchors.fill: parent

  AnimatedRectangle {
    anchors.fill: parent
    color: Config.theme.hud.border.color

    layer.enabled: true
    layer.effect: MultiEffect {
      maskSource: mask
      maskEnabled: true
      maskInverted: true
      maskThresholdMin: 0.5
      maskSpreadAtMin: 1
    }
  }

  Item {
    id: mask

    anchors.fill: parent
    layer.enabled: true
    visible: false

    Rectangle {
      anchors.fill: parent
      anchors.margins: Config.theme.hud.border.width
      anchors.bottomMargin: root.bar.implicitHeight
      radius: Config.theme.hud.border.shape
    }
  }
}
