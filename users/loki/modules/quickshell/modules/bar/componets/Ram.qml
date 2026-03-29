
import QtQuick

Background{
  width: clockText.width
  Text {
    anchors.verticalCenter: parent.verticalCenter
    id:clockText
    text: "22:20"

    font.pixelSize: 12
    font.bold: true
  }
}
