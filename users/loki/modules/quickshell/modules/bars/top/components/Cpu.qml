import QtQuick
import qs.widgets
import qs.config

Background{
  StyledText {
    id: cpu
    anchors.centerIn: parent
    text: "  " + Config.cpuUsage
  }
}
