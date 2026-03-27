import QtQuick
import QtQuick.Layouts
import qs.vars
import Quickshell.Wayland
import Quickshell

PanelWindow {
    color: "transparent"       
    width: content.width
    height: content.height

    anchors {
        right: true
        top: true
    }

    margins {
        right: 100
    }

    Component.onCompleted: {
        if (WlrLayershell) {
            WlrLayershell.layer = WlrLayer.Bottom
        }
    }
    ColumnLayout {
        id: content
        spacing: 0

        Text {
            text: Global.clockHours
            font.pixelSize: 100
            font.bold: true
            color: Colors.primary
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: Global.clockMinutes
            font.pixelSize: 100
            font.bold: true
            color: Colors.secondary
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: Qt.formatDateTime(new Date(), "MM dd")
            font.pixelSize: 40
            font.bold: true
            color: Colors.tertiary
            Layout.alignment: Qt.AlignHCenter
        }
    }

}
