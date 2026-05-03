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
  Behavior on anchors.topMargin {
    NumberAnimation {
      duration: 100
      easing.type: Easing.Linear
    }
  }
  Behavior on anchors.bottomMargin {
    NumberAnimation {
      duration: 100
      easing.type: Easing.Linear
    }
  }
  clip: true

  Item {
    visible: Config.bar.gradient && !Config.bar.floating
    anchors.fill: parent

    Rectangle {
      anchors.fill: parent
      radius: Config.bar.radius
      opacity: Config.bar.gradientOpacity / 100
      gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { position: 0.0; color: Colors.secondary}
        GradientStop { position: 0.2; color: Colors.shadow}
        GradientStop { position: 0.5; color: Colors.primary}
        GradientStop { position: 0.8; color: Colors.shadow}
        GradientStop { position: 1.0; color: Colors.tertiary}
      }
    }
    Rectangle {
      anchors.fill: parent
      radius: Config.bar.radius
      gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "transparent" }
        GradientStop { position: 0.8; color: Colors.background}
      }
    }
  }
  component Stripe: Rectangle {
    visible: Config.bar.stripes && !Config.bar.floating
    width: background.width * 4
    x: -background.width * 1.5
    rotation: -45
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 12
    Date {
      id: clock
      topRightRadius: Config.bar.margins <= 0? 0:undefined 

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
      id: cpu
      bottomRightRadius: Config.bar.margins <= 0? 0:undefined 
    }
  }
}
