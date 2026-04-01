import QtQuick
import qs.widgets
import qs.config

Background{
  StyledText {
    id: clock
    anchors.centerIn: parent
    text: "󰥔  " + Config.timeHours + ":" + Config.timeMinutes
  }
}
