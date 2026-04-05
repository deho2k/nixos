// Clock.qml
import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.config

Background {
  ColumnLayout {
    anchors.centerIn: parent
    StyledText {
        id: clockHours
        text: Config.timeHours
        horizontalAlignment: Text.AlignHCenter
    }
    StyledText {
        id: clockMinutes
        text: Config.timeMinutes
        horizontalAlignment: Text.AlignHCenter
    }
  }
}
