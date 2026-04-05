import qs.widgets
import qs.config
import QtQuick
import QtQuick.Layouts

RowLayout {
  id: root
  property string label: "Select Option"
  property var options: ["Option 1", "Option 2", "Option 3"]
  property int currentIndex: 0
  property bool opened: false

  StyledText {font.pixelSize: 22; text: root.label; Layout.fillWidth: true }

  Rectangle {
    width: 120; height: 30
    color: "#313244"; radius: 4
    border.color: "#45475a"

    StyledText {
      anchors.centerIn: parent
      text: root.options[root.currentIndex]
      color: "white"
    }

    MouseArea {
      anchors.fill: parent
      onClicked: root.opened = !root.opened
    }

    // The Dropdown List
    Rectangle {
      visible: root.opened
      y: parent.height + 5
      width: parent.width; height: root.options.length * 30
      color: Colors.outline; border.color: Colors.primary; 
      z: 100

      Column {
        anchors.fill: parent
        Repeater {
          model: root.options
          Rectangle {
            width: parent.width; height: 30; color: "transparent"
            StyledText {
              anchors.centerIn: parent; text: modelData; color: "white" 
            }
            MouseArea {
              anchors.fill: parent
              onClicked: {
                root.currentIndex = index
                root.opened = false
              }
            }
          }
        }
      }
    }
  }
}
