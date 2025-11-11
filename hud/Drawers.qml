import qs.config
import qs.hud.osd as Osd
import QtQuick
import QtQuick.Shapes

Shape {
  id: root

  required property Panels panels
  required property Item bar

  anchors.fill: parent
  anchors.margins: Config.theme.hud.border.width
  anchors.bottomMargin: bar.implicitHeight
  preferredRendererType: Shape.CurveRenderer

  Osd.Drawer {
    bar: root.bar
    wrapper: root.panels.osd

    startX: root.width
    startY: (root.height - wrapper.height) / 2 - rounding
  }
}
