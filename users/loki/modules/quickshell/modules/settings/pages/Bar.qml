import QtQuick
import qs.vars
import QtQuick.Layouts
import Quickshell
import qs.widgets

ColumnLayout {
    spacing: 16
    Text {
        text: "Bar"
        font.pixelSize: 32
        font.bold: true 
        color: Colors.inverse_surface
    }
    SettingToggle {
        label: "floating"
        checked: cfg.config.bar.floating
        onToggled: cfg.config.bar.floating = checked
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "radius"
        sliderValue: cfg.config.bar.radius
        from: 0
        to: 32
        onValueChanged: (value) => {
            cfg.config.bar.radius = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "height"
        sliderValue: cfg.config.bar.height
        from: 25
        to: 50
        onValueChanged: (value) => {
            cfg.config.bar.height = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "opacity"
        sliderValue: cfg.config.bar.opacity
        from: 0
        to: 100
        onValueChanged: (value) => {
            cfg.config.bar.opacity = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "border width"
        sliderValue: cfg.config.bar.borderWidth
        from: 0
        to: 2
        onValueChanged: (value) => {
            cfg.config.bar.borderWidth = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "margins"
        sliderValue: cfg.config.bar.sideMargin
        from: 0
        to: 500
        onValueChanged: (value) => {
            cfg.config.bar.sideMargin = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingDropdown {
        label: "Postioning"
        options: ["Dev", "Normal"]
        currentValue: cfg.config.bar.layout
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
        
        onValueChanged: function(index, value) {
            cfg.config.bar.layout = value
        }
    }
}
