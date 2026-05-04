pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import "components"

Rectangle {
  id: background
  anchors.fill: parent

  property var margins: Config.bar.margins
  // logic for floating and margins
  color: Config.bar.floating? "transparent": Colors.background
  anchors.leftMargin: margins
  anchors.rightMargin: margins
  anchors.topMargin: margins > 0? 5: 0
  radius: margins > 0? Config.bar.radius: 0

  Row {
    anchors.fill: parent
    Clock {
      id: clock
      anchors.left: parent.left
    }
    Player {
      id: spotify
      anchors.left: clock.right
      anchors.leftMargin: 20
    }
    Workspaces {
      id: workspaces
      anchors.centerIn: parent
    }
    Battery {
      id:battery
      visible: Config.battery.percentage != 0
      anchors.right: ram.left
    }
    Ram {
      id: ram
      anchors.right: cpu.left
      anchors.rightMargin: 20
    }
    Cpu{
      id: cpu
      anchors.right: parent.right
    }
  }
}
