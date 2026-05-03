import QtQuick
import qs.widgets
import qs.config

Background{
  CircleProgressWrapper {
    percentage: Config.memUsage
    icon: ""
    anchors.right: ram.left
  }
  StyledText {
    id:ram
    anchors.centerIn: parent
    text: Config.memUsage
  }
}
