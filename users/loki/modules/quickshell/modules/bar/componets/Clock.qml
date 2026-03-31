import QtQuick
import qs.widgets
import qs.config

Background{
  width: clock.width + 15
  StyledText {
    id: clock
    anchors.horizontalCenter: parent.horizontalCenter
    text: Config.time
  }
}
