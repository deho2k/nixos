pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
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

  Clock {
    id: clock
    anchors.left: parent.left
  }
  Player {
    id: spotify
    anchors.left: clock.right
  }
  Workspaces {
    id: workspaces
    anchors.centerIn: parent
  }
  Battery {
    visible: Config.battery.percentage != 0
    id:battery
    anchors.right: ram.left
  }
  Ram {
    id: ram
    anchors.right: cpu.left
  }
  Cpu{
    id: cpu
    anchors.right: parent.right
  }
}
