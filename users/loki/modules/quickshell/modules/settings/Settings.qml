pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.config
FloatingWindow {
    id: root
    property string activePage: "General"
    implicitWidth: 1200
    implicitHeight: 550
    minimumSize: Qt.size(1200, 700)
    title: "Settings"
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Colors.background
        border.width: 0
        clip: true

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.preferredWidth: 240
                Layout.fillHeight: true
                color: Qt.rgba(0, 0, 0, 0.3)

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 12


                    Item { implicitHeight: 12; implicitWidth: 1; }

                    SidebarItem { label: "General"; icon: "󰒓"; }
                    SidebarItem { label: "Bar"; icon: "󰛡"; }
                    SidebarItem { label: "Hyprland"; icon: ""; }
                    SidebarItem { label: "Wallpaper"; icon: "󰸉"; }
                    SidebarItem { label: "keyboard";  icon: ""; }
                    SidebarItem { label: "Big Panel"; page: "BigPanel"; icon: ""; }

                    Item { Layout.fillHeight: true }

                    component SidebarItem: Rectangle {
                      id: barItem
                        property string label
                        property string icon
                        property string page: label
                        property bool isActive: root.activePage === page
                        property color inactiveColor: Qt.rgba(Colors.inverse_surface.r, Colors.inverse_surface.g, Colors.inverse_surface.b, 0.5)

                        Layout.fillWidth: true
                        Layout.preferredHeight: 44
                        radius: 12
                        color: isActive ? Qt.rgba(Colors.secondary_container.r, Colors.secondary_container.g, Colors.secondary_container.b, 0.8) : "transparent"

                        RowLayout {
                            anchors.fill: parent
                            spacing: 12

                            Text {
                                text: barItem.icon
                                font.family: "Symbols Nerd Font"
                                font.pixelSize: 18
                                color: barItem.isActive ? Colors.secondary : barItem.inactiveColor
                                Layout.alignment: Qt.AlignLeft
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Text {
                                text: barItem.label
                                color: barItem.isActive ? Colors.secondary : barItem.inactiveColor
                                font.pixelSize: 14
                                font.weight: barItem.isActive ? Font.Bold : Font.Normal
                            }
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
