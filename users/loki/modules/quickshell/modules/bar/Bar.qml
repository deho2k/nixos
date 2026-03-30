pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.config
import "componets"

Variants {
  id: root
  model: Quickshell.screens
  PanelWindow {
    id: bar
    required property var modelData
    screen: modelData
    color: "transparent"
    implicitHeight: 30
    anchors {
      top:true
      left:true
      right:true
    }
    Rectangle {
      anchors.fill: parent
      color: Colors.background
      anchors.margins: 2
      radius: Config.bar.radius

      Clock {
        id: clock
        anchors.left: parent.left
      }
      Workspaces {
        id: workspaces
        anchors.centerIn: parent
      }
      Cpu{
        id: cpu
        anchors.right: parent.right
      }
      Ram {
        id: ram
        anchors.right: cpu.left
      }
    }
  }
}
