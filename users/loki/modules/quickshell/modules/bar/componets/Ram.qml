import QtQuick
import qs.widgets
import qs.config

Background{
  width: ram.width + 20
  StyledText {
    id:ram
  anchors.horizontalCenter: parent.horizontalCenter
    text: "  " + Config.memUsage
  }
}
