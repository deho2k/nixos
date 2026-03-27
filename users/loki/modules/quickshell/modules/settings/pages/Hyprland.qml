import QtQuick
import qs.vars
import Quickshell.Io
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.widgets

ColumnLayout {
    spacing: 16

    //name and value for the config update shit
    property string hName
    property string hValue
    Process {
        id: updateConfig
        command: [
          "sh",
          "-c",
          `sed -i 's/^\\$${hName}=.*/\\$${hName}=${hValue}/' ~/.config/hypr/hyprland/runtime.conf`
        ]
    }

    Text {
        text: "Hyprland"
        font.pixelSize: 32
        font.bold: true 
        color: Colors.inverse_surface
    }
    SettingToggle {
        label: "animations"
        checked: cfg.config.hyprland.animations
        onToggled: {
            cfg.config.hyprland.animations = checked
            hName = "animations"
            hValue = cfg.config.hyprland.animations
            updateConfig.running = true
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "rounding"
        sliderValue: cfg.config.hyprland.rounding
        from: 0
        to: 16
        onValueChanged: (value) => {
            cfg.config.hyprland.rounding = value
            hName = "rounding"
            hValue = cfg.config.hyprland.rounding
            updateConfig.running = true
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingDropdown {
        label: "animations type"
        options: ["end4","smooth","high","fast","dynamic","moving"]
        currentValue: cfg.config.hyprland.animationType
        
        onValueChanged: function(index, value) {
            cfg.config.hyprland.animationType = value
            hName = "animationType"
            hValue = cfg.config.hyprland.animationType
            updateConfig.running = true
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "gaps in"
        sliderValue: cfg.config.hyprland.gapsIn
        from: 0
        to: 16
        onValueChanged: (value) => {
            cfg.config.hyprland.gapsIn = value
            hName = "gapsIn"
            hValue = cfg.config.hyprland.gapsIn
            updateConfig.running = true
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "gaps out"
        sliderValue: cfg.config.hyprland.gapsOut
        from: 0
        to: 32
        onValueChanged: (value) => {
            cfg.config.hyprland.gapsOut = value
            hName = "gapsOut"
            hValue = cfg.config.hyprland.gapsOut
            updateConfig.running = true
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
}
