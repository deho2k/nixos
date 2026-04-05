import QtQuick.Shapes
import QtQuick
import qs.config

Shape {
  id: shape
  property int size: 20
  property bool topSide: false
  width: size
  height: size
  visible: !Config.bar.floating

  ShapePath {
    fillColor: Colors.background // Match the bar
    strokeColor: "transparent"
    startX: 0; startY: 0 // top left
    PathLine { x: 0; y: shape.topSide? shape.size : -shape.size } // bottom left
    PathArc {
      x: shape.size; y: 0 // top right
      radiusX: shape.size; radiusY: shape.size //radius control
      direction: shape.topSide? PathArc.Clockwise : PathArc.Counterclockwise
    }
    PathLine { x: 0; y: 0 }
  }
}
