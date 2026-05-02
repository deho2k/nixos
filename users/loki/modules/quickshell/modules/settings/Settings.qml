pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.widgets
// needed to be imported for pages to be able to use them for some reason
import "./componenents"

FloatingWindow {
  id: root
  property string activePage: "General"
  visible: false
  implicitWidth: 800
  implicitHeight: 550
  minimumSize: Qt.size(root.implicitWidth, root.implicitHeight)
  title: "Settings"
  color: "transparent"

  Rectangle {
    anchors.fill: parent
    color: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, 0.5)
    border.width: 0
    clip: true

    ColumnLayout {
      anchors.fill: parent
      spacing: 0

      Rectangle {
        Layout.preferredHeight: 50
        Layout.fillWidth: true
        color: "transparent"

        RowLayout {
          anchors.fill: parent
          anchors.topMargin: 6
          anchors.bottomMargin: 0

          Item { implicitHeight: 12; implicitWidth: 1; }

          SidebarItem { label: "󰒓 General"; page:"General" }
          SidebarItem { label: "󰛡 Bar"; page:"Bar"}
          SidebarItem { label: " Hyprland"; page:"Hyprland"}

          Item { Layout.fillHeight: true }

          component SidebarItem: Rectangle {
            id: barItem
            required property string label
            required property string page

            property bool isActive: root.activePage === page
            property color inactiveColor: Qt.rgba(Colors.inverse_surface.r, Colors.inverse_surface.g, Colors.inverse_surface.b, 0.5)

            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 12
            color: isActive ? Qt.rgba(Colors.secondary_container.r, Colors.secondary_container.g, Colors.secondary_container.b, 0.4) : "transparent"
            StyledText {
              text: barItem.label
              color: barItem.isActive ? Colors.secondary : barItem.inactiveColor
              anchors.left: parent.left
              anchors.verticalCenter: parent.verticalCenter
              anchors.leftMargin: 15
              font.pixelSize: 14
              font.weight: barItem.isActive ? Font.Bold : Font.Normal
            }
            TapHandler {
              onTapped: activePage = barItem.page
              cursorShape: Qt.PointingHandCursor
            }
            HoverHandler {
              id: hover
              cursorShape: Qt.PointingHandCursor
            }
            Rectangle {
              anchors.fill: parent
              color: Colors.on_secondary_container
              opacity: hover.hovered && !barItem.isActive ? 0.3 : 0
              radius: 6;
            }
          }
        }
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.margins: 15
        radius: 12
        color: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, 0.6)

        ScrollView {
          anchors.fill: parent
          anchors.topMargin: 20
          clip: true
          contentWidth: availableWidth

          Loader {
            anchors.fill: parent
            anchors.margins: 32
            source: "pages/" + root.activePage + ".qml"
          }
        }
      }
    }
  }
}
