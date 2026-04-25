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
  anchors.leftMargin: margins > 0 ? 5 : 0
  radius: margins > 0 ? Config.bar.radius : 0
  clip: true

  Item {
    anchors.fill: parent

    Rectangle {
      anchors.fill: parent
      opacity: 0.1
      gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { position: 0.0; color: Colors.secondary }
        GradientStop { position: 0.2; color: Colors.shadow } 
        GradientStop { position: 0.8; color: Colors.shadow } 
        GradientStop { position: 1.0; color: Colors.primary } 
      }
    }
    Rectangle {
      anchors.fill: parent
      gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "transparent" }
        GradientStop { position: 0.8; color: Colors.background}
      }
    }
  }
  component Stripe: Rectangle {
    visible: Config.bar.stripes
    width: background.width * 4
    x: -background.width * 1.5
    rotation: -45
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 12
    Date {
      Layout.topMargin: 10
      id: clock
    }
    Player { id: player }
    Item { 
      Layout.fillHeight: true 
      Column {
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0.65
        spacing: 15

        Stripe { height: 30; color: Colors.primary }
        Stripe { height: 30; color: Colors.secondary }
        Stripe { height: 30; color: Colors.tertiary }
      }
    }
    Workspaces { id: workspaces }
    Item { 
      Layout.fillHeight: true 
      Column {
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0.65
        spacing: 15

        Stripe { height: 30; color: Colors.tertiary }
        Stripe { height: 30; color: Colors.secondary }
        Stripe { height: 30; color: Colors.primary }
      }
    }
    Battery {
      visible: Config.battery.percentage != 0
      id: battery
    }
    Ram { id: ram }
    Cpu {
      Layout.bottomMargin: 10
      id: cpu
    }
  }
}
