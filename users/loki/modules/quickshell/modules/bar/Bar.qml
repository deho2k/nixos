import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs.vars
Variants {
  model: Quickshell.screens

  PanelWindow {
    id: root
    property var modelData
    screen: modelData

    property int sideMargin: cfg.config.bar.sideMargin
    property int barRadius: sideMargin > 0?cfg.config.bar.radius: 0
    property int borderWidth: cfg.config.bar.borderWidth
    property real barOpacity: cfg.config.bar.opacity / 100
    property bool floating: cfg.config.bar.floating
    property color borderColor: Colors.primary
    property color fgColor: Colors.primary

    color:"transparent"
    implicitHeight: cfg.config.bar.height
    anchors {
      top: true
      left: true
      right: true
    }

    margins {
      top: sideMargin > 0? 5: 0
      bottom: sideMargin > 0? 10: 0
      left:  sideMargin
      right:  sideMargin
    }

    Rectangle {
      visible: true
      anchors.fill: parent
      color: floating? "transparent" : Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, barOpacity)
      radius: barRadius
      height: parent.height

      border.width: floating? 0 : borderWidth
      border.color: borderColor

      RowLayout {
        id:leftContent
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: sideMargin > 0? 5 : 0

        BackgroundBorder {
          rightRadius: cfg.config.ui.radius
          leftRadius: 0
        }
        Item{ width: 1}
        Repeater {
          model: Hyprland.workspaces.values.filter(ws => ws.id > 0)
          Rectangle {
            color: "transparent"
            property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id
            width: isActive ? 28 : 18
            Rectangle {
              id: circle
              radius: 4
              width: parent.width
              height: 16
              color: parent.isActive ? fgColor : Colors.outline
              anchors.centerIn: parent
            }
            MouseArea { anchors.fill: parent; onClicked: Hyprland.dispatch("workspace " + modelData.id); cursorShape: Qt.PointingHandCursor; }
          }
        }
        Text {
          text: " " + player.trackTitle
          elide: Text.ElideRight
          Layout.maximumWidth: 250
          color: fgColor
          font.pixelSize: fontSize
          font.family: fontFamily
          font.bold: true

          Layout.leftMargin: 8
          Layout.rightMargin: 8
        }
      }
      RowLayout {
        id:centerContent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        BackgroundBorder {
          rightRadius: cfg.config.ui.radius
          leftRadius: cfg.config.ui.radius
        }

        Text {
          text: Global.clockHours + ":" + Global.clockMinutes 
          color: fgColor
          font.pixelSize: fontSize
          font.family: fontFamily
          font.bold: true

          Layout.leftMargin: 8
          Layout.rightMargin: 12
        }


      }
      RowLayout {
        id:rightContent
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: sideMargin > 0? 5 : 0

        BackgroundBorder {
          rightRadius: 0
          leftRadius: cfg.config.ui.radius
        }

        Text {
          text: Global.cpuUsage + " "
          color: fgColor
          font.pixelSize: fontSize
          font.family: fontFamily
          font.bold: true

          Layout.rightMargin: 8
        }

        Text {
          text: Global.memUsage + " "
          color: fgColor
          font.pixelSize: fontSize
          font.family: fontFamily
          font.bold: true

          Layout.rightMargin: 8
        }

        Text {
          visible: UPower.displayDevice.percentage != 0
          property string batteryIcon: {
            let pct = UPower.displayDevice.percentage

            if (UPower.displayDevice.state === UPowerDevice.Charging) return " 󰂄"
            if (UPower.displayDevice.state === UPowerDevice.PendingCharge) return " 󱉝"
            if (pct >= 0.9) return " 󰁹"
            else if (pct >= 0.7) return " 󰂀"
            else if (pct >= 0.5) return " 󰁿"
            else if (pct >= 0.3) return " 󰁽"
            else if (pct >= 0.1) return " 󰁼"
            else return " 󰂎"
          }

          text: Math.round(UPower.displayDevice.percentage * 100) + batteryIcon
          color: fgColor
          font.pixelSize: fontSize
          font.family: fontFamily
          font.bold: true

          Layout.rightMargin: 8
        }

      }

      component BackgroundBorder: Rectangle {
        property int rightRadius
        property int leftRadius

        anchors.fill: parent
        color: floating? Colors.background : "transparent"
        z: -1

        radius: barRadius
        bottomRightRadius: rightRadius
        bottomLeftRadius: leftRadius
        Rectangle {
          id: border
          z: -2
          color: floating? borderColor : "transparent"
          anchors.fill: parent
          anchors.margins: -borderWidth

          radius: parent.radius + 2 
          bottomRightRadius: parent.bottomRightRadius + 2
          bottomLeftRadius: parent.bottomLeftRadius + 2
        }
      }
    }

  }
}
