import qs.widgets
import qs.config
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    property string label: "Toggle Me"
    property bool checked: false
    spacing: 10

    StyledText {
        text: root.label
        font.pixelSize: 22
        Layout.fillWidth: true
    }

    Rectangle {
        id: track
        width: 40; height: 20
        radius: 10
        color: root.checked ? Colors.primary : Colors.outline

        Rectangle {
            id: thumb
            x: root.checked ? 22 : 2
            y: 2; width: 16; height: 16
            radius: 8; color: "white"
            Behavior on x { NumberAnimation { duration: 150 } }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.checked = !root.checked
        }
    }
}
