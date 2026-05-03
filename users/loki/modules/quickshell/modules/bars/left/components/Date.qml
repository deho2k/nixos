// Clock.qml
import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.config

Background {
  implicitHeight: childrenRect.height + 10
  ColumnLayout {
    anchors.centerIn: parent
    StyledText {
      id: clockHours
      text: Config.displayHours
      horizontalAlignment: Text.AlignHCenter
    }
    StyledText {
      id: clockMinutes
      text: Config.displayMinutes
      horizontalAlignment: Text.AlignHCenter
    }
  }
}
