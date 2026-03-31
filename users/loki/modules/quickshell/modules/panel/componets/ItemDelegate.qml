import QtQuick
import qs.widgets
import qs.config

Rectangle {
  required property var modelData
  width: parent.width
  height: 48
  radius: 4
  color: ListView.isCurrentItem ? Colors.outline_variant : "transparent"

  Image {
    id: appIcon
    cache: true
    source: parent.modelData.icon ? "image://icon/" + parent.modelData.icon : ""
    width: 32
    height: 32
    fillMode: Image.PreserveAspectFit
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
  }
  StyledText {
    text: parent.modelData.name
    font.pixelSize: 16
    anchors.left: appIcon.right
  }
}
