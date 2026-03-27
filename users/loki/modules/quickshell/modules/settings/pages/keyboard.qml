import QtQuick
import qs.vars
import QtQuick.Controls
import Quickshell.Io 
import QtQuick.Layouts
import Quickshell
import qs.widgets

ColumnLayout {
    spacing: 16

    Text {
        text: "Keyboard"
        font.pixelSize: 32
        font.bold: true 
        color: Colors.inverse_surface
    }
    SettingSlider {
        label: "brightness"
        sliderValue: Global.executeString("")
        from: 70
        to: 100
        onValueChanged: (value) => {
        }
        Layout.fillWidth: true
        Layout.leftMargin: 50
        Layout.rightMargin: 50
    }
}
