import QtQuick
import qs.vars
import QtQuick.Layouts
import Quickshell
import qs.widgets

ColumnLayout {
    spacing: 16
    Text {
        text: "Big Panel"
        font.pixelSize: 32
        font.bold: true 
        color: Colors.inverse_surface
    }
    SettingSlider {
        label: "margins"
        sliderValue: cfg.config.bigPanel.margins
        from: 0
        to: 100
        onValueChanged: (value) => {
            cfg.config.bigPanel.margins = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingToggle {
        label: "anchor center"
        checked: cfg.config.bigPanel.anchorCenter
        onToggled: cfg.config.bigPanel.anchorCenter = checked
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingToggle {
        label: "anchor bottom"
        checked: cfg.config.bigPanel.anchorBottom
        onToggled: cfg.config.bigPanel.anchorBottom = checked
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingToggle {
        label: "anchor left"
        checked: cfg.config.bigPanel.anchorLeft
        onToggled: cfg.config.bigPanel.anchorLeft = checked
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "launcher width"
        sliderValue: cfg.config.bigPanel.services.launcherWidth
        from: 200
        to: 1000
        onValueChanged: (value) => {
            cfg.config.bigPanel.services.launcherWidth = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingSlider {
        label: "wallpaper selector width"
        sliderValue: cfg.config.bigPanel.services.wallpaperWidth
        from: 400
        to: 2000
        onValueChanged: (value) => {
            cfg.config.bigPanel.services.wallpaperWidth = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
}
