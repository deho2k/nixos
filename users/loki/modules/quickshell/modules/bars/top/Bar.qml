pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.config
import "components"

Variants {
  id: root
  model: Quickshell.screens
  PanelWindow {
    id: bar
    required property var modelData
    property var margins: Config.bar.margins
    screen: modelData
    color: "transparent"
    implicitHeight: Config.bar.height
    anchors {
      top:true
      left:true
      right:true
    }
    Rectangle {
      anchors.fill: parent

      // logic for floating and margins
      color: Config.bar.floating? "transparent": Colors.background
      anchors.leftMargin: bar.margins
      anchors.rightMargin: bar.margins
      anchors.topMargin: bar.margins > 0? 5: 0
      radius: bar.margins > 0? Config.bar.radius: 0

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
  }
}
