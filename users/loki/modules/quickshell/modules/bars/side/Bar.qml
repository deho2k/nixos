pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
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
    width: 50 

    anchors {
      left: true
      top: true
      bottom: true
    }

    Rectangle {
      id: background
      anchors.fill: parent
      color: Config.bar.floating ? "transparent" : Colors.background

      anchors.topMargin: bar.margins
      anchors.bottomMargin: bar.margins
      anchors.leftMargin: bar.margins > 0? 5: 0
      radius: bar.margins > 0 ? Config.bar.radius : 0

      ColumnLayout {
        anchors.fill: parent

        Date {
          id: clock
          Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }

        Workspaces {
          id: workspaces
          Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }

        Battery {
          visible: Config.battery.percentage != 0
          id:battery
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
  }
}
