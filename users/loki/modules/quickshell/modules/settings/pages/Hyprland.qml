import QtQuick
import QtQuick.Layouts
import qs.config
import "../componenents"

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
      Config.hyprlandRuntimePush()
    }
  }
  Slider {
    label: "border size"
    from: 0
    to: 12
    value: Config.hyprland.borderSize
    onValueChanged: {
      Config.hyprland.borderSize = value
      Config.hyprlandRuntimePush()
    }
  }
  Slider {
    label: "gaps in"
    from: 0
    to: 64
    value: Config.hyprland.gapsIn
    onValueChanged: {
      Config.hyprland.gapsIn = value
      Config.hyprlandRuntimePush()
    }
  }
  Slider {
    label: "gaps out"
    from: 0
    to: 64
    value: Config.hyprland.gapsOut
    onValueChanged: {
      Config.hyprland.gapsOut = value
      Config.hyprlandRuntimePush()
    }
  }
  Switch {
    label:"animations"
    checked: Config.hyprland.animations
    onCheckedChanged: {
      Config.hyprland.animations = checked
      Config.hyprlandRuntimePush()
    }
  }
  Dropdown {
    Layout.fillWidth: true
    label: "Theme"
    options: ["end4", "fast", "dynamic","high","moving", "smooth"]
    currentIndex: options.indexOf(Config.hyprland.animationType)
    onCurrentIndexChanged: {
      Config.hyprland.animationType = options[currentIndex]
      Config.hyprlandRuntimePush()
    }
  }
}
