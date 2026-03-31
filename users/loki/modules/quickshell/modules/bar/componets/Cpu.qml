import QtQuick
import qs.widgets
import qs.config

Background{
  width: cpu.width + 15
  StyledText {
    id: cpu
    anchors.horizontalCenter: parent.horizontalCenter
    text: "  " + Config.cpuUsage
  }
}
