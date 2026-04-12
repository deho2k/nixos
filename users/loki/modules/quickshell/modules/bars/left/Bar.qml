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
  anchors.leftMargin: margins > 0? Math.min( Config.hyprland.gapsOut, 5) : 0
  radius: margins > 0 ? Config.bar.radius : 0

  ColumnLayout {
    anchors.fill: parent

    spacing: 12
    Date {
      id: clock
      Layout.alignment: Qt.AlignHCenter
    }
    Player {
      id: player
      Layout.alignment: Qt.AlignHCenter
    }

    Item { Layout.fillHeight: true }

    Workspaces {
      id: workspaces
      Layout.alignment: Qt.AlignHCenter
    }

    Item { Layout.fillHeight: true }

    Battery {
      visible: Config.battery.percentage != 0
      id: battery
      Layout.alignment: Qt.AlignHCenter
    }
    Ram {
      id: ram
      Layout.alignment: Qt.AlignHCenter
    }
    Cpu {
      id: cpu
      Layout.alignment: Qt.AlignHCenter
    }
  }
}
