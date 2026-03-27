import QtQuick
import qs.vars
import QtQuick.Controls
import Quickshell.Io 
import QtQuick.Layouts
import Quickshell
import qs.widgets

ColumnLayout {
    spacing: 16

    property int currentBrightness
    property int maxBrightness
    Process {
        id: setBatteryMax
        // u have to add a udev rule to allow edditing to this file without sudo
        command: ["sh", "-c", "echo " + cfg.config.hyprland.batteryMax + " > /sys/class/power_supply/BAT1/charge_control_end_threshold"]
    }
    Process {
        id: getBrighnessMax
        running: true
        command: ["sh", "-c", "brightnessctl m"]
        stdout: SplitParser {
            onRead: data => {
                maxBrightness = data
            }
        }
    }
    Process {
        id: getBrighness
        running: true
        command: ["sh", "-c", "brightnessctl g"]
        stdout: SplitParser {
            onRead: data => {
                currentBrightness = data
            }
        }
    }
    Process {
        id: setBrighness
        command: ["sh", "-c", "brightnessctl s " + currentBrightness]
        stdout: SplitParser {
            onRead: data => {
                currentBrightness = data
            }
        }
    }
    Text {
        text: "General"
        font.pixelSize: 32
        font.bold: true 
        color: Colors.inverse_surface
    }
    Text {
        text: "cumpoter"
        font.pixelSize: 24
        color: Colors.inverse_surface
    }
    SettingSlider {
        label: "brightness"
        sliderValue: currentBrightness / maxBrightness * 100
        from: 0
        to: 100
        onValueChanged: (value) => {
            currentBrightness = value / 100 * maxBrightness
            setBrighness.running = true
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "Max Battery"
        sliderValue: cfg.config.hyprland.batteryMax
        from: 70
        to: 100
        onValueChanged: (value) => {
            cfg.config.hyprland.batteryMax = value
            setBatteryMax.running = true
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    Text {
        text: "quickshell"
        font.pixelSize: 24
        color: Colors.inverse_surface
    }
    SettingSlider {
        label: "opacity"
        sliderValue: cfg.config.ui.opacity
        from: 0
        to: 100
        onValueChanged: (value) => {
            cfg.config.ui.opacity = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "radius"
        sliderValue: cfg.config.ui.radius
        from: 0
        to: 32
        onValueChanged: (value) => {
            cfg.config.ui.radius = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    Text {
        text: "borders"
        font.pixelSize: 24
        color: Colors.inverse_surface
    }
    SettingSlider {
        label: "Border width"
        sliderValue: cfg.config.ui.border.width
        from: 0
        to: 2
        onValueChanged: (value) => {
            cfg.config.ui.border.width = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
}
