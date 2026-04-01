import QtQuick
import Quickshell.Services.UPower 
import qs.widgets
import qs.config

Background{
  width: battery.width + 15
  StyledText {
    id: battery
    anchors.horizontalCenter: parent.horizontalCenter
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
    text: batteryIcon + " "+ Config.battery.percentage * 100
  }
}
