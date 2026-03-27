import Quickshell
import Quickshell.Widgets 
import Quickshell.Io
import qs.vars
import qs.widgets
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel

Rectangle {
    id: root
    
    // Properties required from the model
    required property bool isHighlighted
    required property string fileName
    required property int index
    
    // External properties (passed in or accessed via globals)
    property color highlightColor: Colors.outline_variant
    property color textColor: Colors.inverse_surface
    
    width: ListView.view.width
    height: 48
    radius: 4
    color: ListView.isCurrentItem ? isHighlighted? Colors.outline : Colors.outline_variant : "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        spacing: 10

        Image {
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            fillMode: Image.PreserveAspectFit
            source: "music-icon-placeholder.png"
        }

        Text {
            text: root.fileName
            color: root.textColor
            font.pixelSize: 16
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.ListView.view.currentIndex = index
        }
    }
}
