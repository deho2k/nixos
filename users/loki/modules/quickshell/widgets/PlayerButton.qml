import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: root

    property string label
    property int fontSize
    signal click()

    Layout.fillWidth: true
    Layout.fillHeight: true

    implicitWidth: 40
    implicitHeight: 40

    text: label
    font.pixelSize: fontSize
    palette.buttonText: Colors.primary_container

    background: Rectangle {
        radius: 8
        color: "transparent"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: click()
        cursorShape: Qt.PointingHandCursor
    }
}
