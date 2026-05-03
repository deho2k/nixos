import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

Background {
  id: root
  implicitHeight: childrenRect.height + 20
  property bool showIcons: Config.bar.workspaceIcons

  property real activeRadius:   3
  property real inactiveRadius: 2

  // --- glow config ---
  property color  glowColor:   Colors.secondary
  property real   glowRadius:  12
  property real   glowOpacity: 0.1

  readonly property var wsIcons: ({
    1: "一",
    2: "二",
    3: "三",
    4: "四",
    5: "五",
    6: "六",
    7: "七",
    8: "八",
    9: "九",
  })

  ColumnLayout {
    id: layout
    anchors.centerIn: parent
    spacing: 8

    Repeater {
      model: Hyprland.workspaces.values
      .filter(ws => ws.id > 0)
      .sort((a, b) => a.id - b.id)

      delegate: Item {
        id: wrapper
        property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id

        Layout.preferredWidth: isActive ? 20 : 12
        Layout.preferredHeight: 12

        Behavior on Layout.preferredWidth {
          NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }

        Rectangle {
          id: glow
          anchors.centerIn: parent
          width:  parent.width  + root.glowRadius * 2
          height: parent.height + root.glowRadius * 2
          radius: (root.showIcons ? 6 : (wrapper.isActive ? root.activeRadius : root.inactiveRadius))
          + root.glowRadius
          color:  "transparent"
          Rectangle {
            anchors.centerIn: parent
            width:  parent.width
            height: parent.height
            radius: parent.radius
            color:  root.glowColor
            opacity: root.glowOpacity * 0.25
          }
          Rectangle {
            anchors.centerIn: parent
            width:  parent.width  * 0.75
            height: parent.height * 0.75
            radius: parent.radius * 0.75
            color:  root.glowColor
            opacity: root.glowOpacity * 0.45
          }
          Rectangle {
            anchors.centerIn: parent
            width:  parent.width  * 0.5
            height: parent.height * 0.5
            radius: parent.radius * 0.5
            color:  root.glowColor
            opacity: root.glowOpacity * 0.7
          }

          opacity: wrapper.isActive ? 1 : 0
          Behavior on opacity {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
          }

          Behavior on width  { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
          Behavior on height { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
        }

        Rectangle {
          id: indicator
          anchors.centerIn: parent
          width:  parent.width
          height: parent.height
          radius: wrapper.isActive ? root.activeRadius : root.inactiveRadius
          color:  root.showIcons? "transparent" : wrapper.isActive ? Colors.primary : Colors.secondary 

          Behavior on radius { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
          Behavior on color  { ColorAnimation   { duration: 150 } }

          StyledText {
            anchors.centerIn: parent
            visible: root.showIcons
            text: root.wsIcons[modelData.id] ?? String(modelData.id)
            font.pixelSize: 14
            color: Colors.primary
            Behavior on opacity { NumberAnimation { duration: 100 } }
          }
        }

        MouseArea {
          anchors.fill: parent
          anchors.margins: -root.glowRadius
          onClicked: Hyprland.dispatch("workspace " + modelData.id)
        }
      }
    }
  }
}
