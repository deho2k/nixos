import QtQuick
import qs.vars
import Quickshell.Io
import QtQuick.Layouts
import Quickshell
import qs.widgets

ColumnLayout {
    spacing: 16

    Text {
        text: "Wallpaper"
        font.pixelSize: 32
        font.bold: true 
        color: Colors.inverse_surface
    }
    SettingDropdown {
        label: "Wallpaper Transition"
        options: ["none","simple","wipe","top","left","wave","grow","random"]
        currentValue: cfg.config.wallpaper.swwwTransition
        
        onValueChanged: function(index, value) {
            cfg.config.wallpaper.swwwTransition = value
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
    SettingDropdown {
        label: "color theme"
        options: ["wallpaper","monochrome","red","purple","aqua"]
        currentValue: cfg.config.wallpaper.theme
        
        onValueChanged: function(index, value) {
            cfg.config.wallpaper.theme = value
            setNewWallpaper()
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
}
