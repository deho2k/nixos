pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import "components"

Rectangle {
  anchors.fill: parent

  property var margins: Config.bar.margins
  // logic for floating and margins
  color: Config.bar.floating? "transparent": Colors.background
  anchors.leftMargin: margins
  anchors.rightMargin: margins
  anchors.topMargin: margins > 0? 5: 0
  radius: margins > 0? Config.bar.radius: 0

  RowLayout {
    anchors.fill: parent
    spacing: 20
    Clock {
      id: clock
      Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    }
    Player {
      id: spotify
      Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    }
    Item { Layout.fillWidth: true }
    Workspaces {
      id: workspaces
      Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    }
    Item { Layout.fillWidth: true }
    Battery {
      visible: Config.battery.percentage != 0
      id:battery
      Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }
    Ram {
      id: ram
      Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }
    Cpu{
      id: cpu
      Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }
  }
}
