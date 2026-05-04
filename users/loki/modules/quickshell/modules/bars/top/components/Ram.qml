import QtQuick
import qs.widgets
import qs.config

Background{
  Row {
    anchors.centerIn: parent
    CircleProgressWrapper {
      percentage: Config.memUsage
      icon: ""
    }
    StyledText {
      id:ram
      text: Config.memUsage
    }
  }
}
