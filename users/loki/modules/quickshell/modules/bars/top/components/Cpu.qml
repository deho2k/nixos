import QtQuick
import qs.widgets
import qs.config

Background{
  Row {
    anchors.centerIn: parent
    CircleProgressWrapper {
      percentage: Config.cpuUsage
      icon: ""
    }
    StyledText {
      id: cpu
      text: Config.cpuUsage
    }
  }
}
