pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import "components"

Rectangle {
  id: background
  anchors.fill: parent
  color: Config.bar.floating ? "transparent" : Colors.background

  property var margins: Config.bar.margins

  anchors.topMargin: margins
  anchors.bottomMargin: margins
  anchors.leftMargin: margins > 0? 5: 0
  radius: margins > 0 ? Config.bar.radius : 0

  ColumnLayout {
    anchors.fill: parent

    Date {
      id: clock
      Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
    }
    Player {
      id: player
      Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
    }

    Item { Layout.fillHeight: true }

    Workspaces {
      id: workspaces
      Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    }

    Item { Layout.fillHeight: true }

    Battery {
      visible: Config.battery.percentage != 0
      id: battery
      Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
    }
    Ram {
      id: ram
      Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
    }
    Cpu {
      id: cpu
      Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
    }
  }
}
