import QtQuick
import qs.widgets
import qs.config

Background{
  StyledText {
    id:ram
    anchors.centerIn: parent
    text: "  " + Config.memUsage
  }
}
