pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.config
import "left"
import "top"

Variants {
  id: root
  model: Quickshell.screens

  PanelWindow {
    id: bar
    required property var modelData
    screen: modelData
    color: "transparent"
    property string position: Config.bar.pos
    property bool isSide: position === "left"


    implicitHeight: isSide ? 0 : Config.bar.height
    implicitWidth:  isSide ? Config.bar.width : 0
    anchors {
      top: true
      left: true
      right: isSide ? false : true
      bottom: isSide ? true : false
    }

    Loader {
      id: contentLoader
      anchors.fill: parent
      source: bar.position + "/Bar.qml"
    }
  }
}
