import QtQuick
import qs.widgets
import qs.config

Background{
  CircleProgress {
    percentage: Config.cpuUsage
    icon: ""
    lineWidth: 3
    margin: 10
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: cpu.left
  }
  StyledText {
    id: cpu
    anchors.centerIn: parent
    text: Config.cpuUsage
  }
}
