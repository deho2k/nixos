import QtQuick
import qs.widgets
import qs.config

Background{
  CircleProgress {
    percentage: Config.memUsage
    icon: ""
    lineWidth: 4
    margin: 10
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: ram.left
  }
  StyledText {
    id:ram
    anchors.centerIn: parent
    text: Config.memUsage
  }
}
