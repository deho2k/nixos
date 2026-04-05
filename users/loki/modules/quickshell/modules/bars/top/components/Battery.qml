import QtQuick
import Quickshell.Services.UPower 
import qs.widgets
import qs.config

Background{
  CircleProgress {
    property string batteryIcon: {
      let pct = Config.battery.percentage

      if (Config.battery.state === UPowerDevice.Charging) return " 󰂄"
      if (Config.battery.state === UPowerDevice.PendingCharge) return " 󱉝"
      if (pct >= 0.9) return " 󰁹"
      else if (pct >= 0.7) return " 󰂀"
      else if (pct >= 0.5) return " 󰁿"
      else if (pct >= 0.3) return " 󰁽"
      else if (pct >= 0.1) return " 󰁼"
      else return " 󰂎"
    }
    percentage: Config.battery.percentage * 100
    icon: batteryIcon
    lineWidth: 3
    margin: 10
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: battery.left
  }
  StyledText {
    id: battery
    anchors.centerIn: parent
    text: Config.battery.percentage * 100
  }
}
