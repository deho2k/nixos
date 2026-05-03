import QtQuick
import qs.widgets
import qs.config

Background{
  CircleProgressWrapper {
    percentage: Config.cpuUsage
    icon: ""
    anchors.right: cpu.left
  }
  StyledText {
    id: cpu
    anchors.centerIn: parent
    text: Config.cpuUsage
  }
}
