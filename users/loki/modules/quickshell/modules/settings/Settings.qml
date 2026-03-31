pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.config
// needed to be imported for pages to be able to use them for some reason
import "./componenets"

FloatingWindow {
  id: root
  property string activePage: "General"
  implicitWidth: 800
  implicitHeight: 550
  minimumSize: Qt.size(root.implicitWidth, root.implicitHeight)
  title: "Settings"
  color: "transparent"

  Rectangle {
    anchors.fill: parent
    color: Colors.surface
    border.width: 0
    clip: true

    RowLayout {
      anchors.fill: parent
      spacing: 0

      Rectangle {
        Layout.preferredWidth: 150
        Layout.fillHeight: true
        color: Colors.background

        ColumnLayout {
          anchors.fill: parent
          anchors.margins: 20
          spacing: 12


          Item { implicitHeight: 12; implicitWidth: 1; }

          SidebarItem { label: "󰒓  General"; page:"General" }
          SidebarItem { label: "󰛡  Bar"; page:"Bar"}
          SidebarItem { label: "  Hyprland"; page:"Hyprland"}
          SidebarItem { label: "󰸉  Themes"; page:"Themes"}

          Item { Layout.fillHeight: true }

          component SidebarItem: Rectangle {
            id: barItem
            rotation: 12
            required property string label
            required property string page

            property bool isActive: root.activePage === page
            property color inactiveColor: Qt.rgba(Colors.inverse_surface.r, Colors.inverse_surface.g, Colors.inverse_surface.b, 0.5)

            Layout.fillWidth: true
            Layout.preferredHeight: 44
            radius: 12
            color: isActive ? Qt.rgba(Colors.secondary_container.r, Colors.secondary_container.g, Colors.secondary_container.b, 0.8) : "transparent"

            Text {
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
              radius: 12
            }

          }

        }
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: "transparent"

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
