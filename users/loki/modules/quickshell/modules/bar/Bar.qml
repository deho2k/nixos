import Quickshell
import QtQuick.Layouts
import QtQuick
import "componets"

Variants {
  model: Quickshell.screens

  PanelWindow {
    id: root
    property var modelData
    screen: modelData
    implicitHeight: 30
    anchors {
      top:true
      left:true
      right:true
    }
    Rectangle {
      anchors.fill: parent
      color: "blue"
      anchors.margins: 2
      radius: 5

      Clock {
        id: clock
        anchors.left: parent.left
      anchors.margins: 2
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
