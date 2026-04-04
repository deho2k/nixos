import QtQuick
import QtQuick.Layouts
import qs.config
import "../componenets"

ColumnLayout {
  spacing: 16
  Text {
    text: "Hyprland"
    font.pixelSize: 32
    font.bold: true 
    color: Colors.inverse_surface
  }

  Slider {
    label: "rounding"
    from: 0
    to: 32
    value: Config.hyprland.rounding
    onValueChanged: {
      Config.hyprland.rounding = value
      Config.hyprlandRuntimePush("rounding", value)
    }
  }
  Slider {
    label: "gaps in"
    from: 0
    to: 64
    step: 2
    value: Config.hyprland.gapsIn
    onValueChanged: {
      Config.hyprland.gapsIn = value
      Config.hyprlandRuntimePush("gapsIn", value)
    }
  }
  Slider {
    label: "gaps out"
    from: 0
    to: 64
    step: 2
    value: Config.hyprland.gapsOut
    onValueChanged: {
      Config.hyprland.gapsOut = value
      Config.hyprlandRuntimePush("gapsOut", value)
    }  
  }
}
