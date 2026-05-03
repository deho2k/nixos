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
  color: "transparent"
  height: bindList.height + header.height + 12 + arcTop.height + arcBottom.height
  width: 0
  property bool floating: Config.bar.floating && Config.bar.pos == "left"
  margins.left: floating? 15: 0
  Component.onCompleted: {
    if (this.WlrLayershell != null) {
      //used to set custom animation in the hyprlnad config check
      // hyprland/rules.conf
      this.WlrLayershell.namespace = "qs-no-animation"
    }
  }
  Behavior on height {
    NumberAnimation {
      duration: 1000
      easing.type: Easing.OutElastic
    }
  }
  Behavior on width {
    NumberAnimation {
      duration: 2000
      easing.type: Easing.OutElastic
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
          binds.append({ mods: parts[0], key: parts[1].trim(), dispatcher: parts[2], name: parts[3].trim(), description: data.split("#")[1].trim() })
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
        if (event.data !== "") {
          binds.clear()
          submap.width = 300
        }else {submap.width = 0}
        submap.currentSubmap = event.data
        console.log("======================")
        parseKeybinds.running = false
        parseKeybinds.isInSubmap = false
        if (event.data !== "") parseKeybinds.running = true
      }
    }
  }
  mask: Region {}
  property real awPercentage: 0.1
  property real aw: submap.width * awPercentage
  property int ah: 20
  Shape {
    id: arcTop
    visible: !submap.floating
    width: submap.aw
    height: submap.ah
    anchors.top: parent.top
    anchors.left: parent.left

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
    visible: !submap.floating
    width: submap.aw
    height: submap.ah
    anchors.bottom: parent.bottom
    anchors.left: parent.left

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
    anchors.bottom: arcBottom.top
    anchors.top: arcTop.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    radius: 12
    topLeftRadius: submap.floating? 12 : 0
    bottomLeftRadius: submap.floating? 12 : 0

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

        // Mod
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
