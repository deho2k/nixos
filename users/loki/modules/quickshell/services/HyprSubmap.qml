import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland 
import qs.config
import qs.widgets

PanelWindow {
  id: submap
  visible: false
  color: "transparent"
  height: bindList.height + header.height + 12 + arcTop.height + arcBottom.height
  width: 300
  Component.onCompleted: {
    if (this.WlrLayershell != null) {
      //used to set custom animation in the hyprlnad config check
      // hyprland/rules.conf
      this.WlrLayershell.namespace = "qs-slide-left"
    }
  }
  exclusionMode: ExclusionMode.Normal
  anchors { left: true}
  property string currentSubmap: ""
  ListModel { id: binds }
  Process {
    id: parseKeybinds
    command: ["sh", "-c", "cat ~/.config/hypr/hyprland/keybinds.conf"]
    property bool isInSubmap: false
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        let parse = data.replace(/ /g,"");
        if(parse.includes("submap=reset")) {parseKeybinds.isInSubmap = false}
        if(parseKeybinds.isInSubmap){ 
          parse = data.split("=")[1].split("#")[0]
          let parts = parse.split(",");
          binds.append({ mods: parts[0], key: parts[1], dispatcher: parts[2], name: parts[3].trim(), description: data.split("#")[1].trim() })
          console.log(data)
        }
        if(parse.includes("submap=" + submap.currentSubmap)) { parseKeybinds.isInSubmap = true } 
      }
    }
  }
  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name === "submap") {
        submap.visible = event.data !== ""
        submap.currentSubmap = event.data
        console.log("======================")
        parseKeybinds.running = false
        parseKeybinds.isInSubmap = false
        binds.clear()
        if (event.data !== "") parseKeybinds.running = true
      }
    }
  }
  mask: Region {}
  property int aw: 20
  property int ah: 30
  Shape {
    id: arcTop
    width: submap.aw
    height: submap.ah
    anchors.bottom: root.top
    anchors.left: root.left

    ShapePath {
      fillColor: Colors.background
      strokeColor: "transparent"

      startX: 0; startY: submap.ah
      PathLine { x: 0; y: 0 }
      PathArc {
        x: submap.aw; y: submap.ah
        radiusX: submap.aw; radiusY: submap.ah
        direction: PathArc.Counterclockwise
      }
    }
  }
  Shape {
    id: arcBottom
    width: submap.aw
    height: submap.ah
    anchors.top: root.bottom
    anchors.left: root.left

    ShapePath {
      fillColor: Colors.background
      strokeColor: "transparent"

      startX: 0; startY: 0
      PathLine { x: submap.aw; y: 0 }
      PathArc {
        x: 0; y: submap.ah
        radiusX: submap.aw; radiusY: submap.ah
        direction: PathArc.Counterclockwise
      }
    }
  }
  Rectangle {
    id: root
    color: Colors.background
    anchors.fill: parent
    radius: 12
    topLeftRadius:0
    bottomLeftRadius:0
    anchors.topMargin: arcTop.height
    anchors.bottomMargin: arcBottom.height
    // Header
    Rectangle {
      id: header
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: 48
      color: "transparent"

      StyledText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 16
        text: "Keybindings"
        font.pixelSize: 13
        opacity: 0.6
      }

      Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        height: 1
        opacity: 0.08
      }
    }

    ListView {
      id: bindList
      anchors.top: header.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      height: contentHeight
      model: binds
      interactive: false
      spacing: 0

      delegate: Rectangle {
        id: row
        required property string key
        required property string mods
        required property string name
        required property string description
        required property string dispatcher

        width: bindList.width
        height: 52
        color: Colors.background

        // Mod + Key badge
        Row {
          id: chordBadge
          anchors.left: parent.left
          anchors.leftMargin: 16
          anchors.verticalCenter: parent.verticalCenter
          spacing: 4

          Rectangle {
            height: 24
            width: keyLabel.implicitWidth + 12
            radius: 5
            color: Qt.rgba(1, 1, 1, 0.06)
            border.color: Qt.rgba(1, 1, 1, 0.10)
            border.width: 1

            StyledText {
              id: keyLabel
              anchors.centerIn: parent
              text: row.key
              font.pixelSize: 11
              font.weight: Font.Medium
              opacity: 0.85
            }
          }
        }

        // description + Name
        Column {
          anchors.left: chordBadge.right
          anchors.leftMargin: 14
          anchors.right: parent.right
          anchors.rightMargin: 16
          anchors.verticalCenter: parent.verticalCenter
          spacing: 2

          StyledText {
            text: row.description
            font.pixelSize: 13
            font.weight: Font.Medium
            opacity: 0.9
          }

          StyledText {
            text: row.name
            font.pixelSize: 11
            opacity: 0.45
            elide: Text.ElideRight
            width: parent.width
          }
        }

        // Divider
        Rectangle {
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.leftMargin: 16
          anchors.rightMargin: 16
          height: 1
          opacity: 0.06
        }
      }
    }
  }
}
