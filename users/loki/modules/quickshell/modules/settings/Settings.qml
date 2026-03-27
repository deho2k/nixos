import QtQuick
import qs.vars
import QtQuick.Controls
import Quickshell.Io
import QtQuick.Layouts
import Quickshell
import qs.widgets
FloatingWindow {
    id: root

    property string activePage: "General"
    property bool sidebarCollapsed: false
    onVisibleChanged: {
        if (!visible) cfg.config.settings.settingsVisible = false;
    }
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
                Layout.preferredWidth: sidebarCollapsed ? 80 : 240
                Layout.fillHeight: true
                color: Qt.rgba(0, 0, 0, 0.3)

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 12

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 32
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: "󰅁"
                            font.family: "Symbols Nerd Font"
                            font.pixelSize: 20
                            color: Colors.primary
                            rotation: sidebarCollapsed ? -90 : 90

                            Behavior on rotation {
                                NumberAnimation {
                                    duration: 200
                                }
                            }

                        }
                        TapHandler {
                            onTapped: sidebarCollapsed = !sidebarCollapsed
                            cursorShape: Qt.PointingHandCursor
                        }
                    }

                    Item { height: 12; width: 1; }

                    SidebarItem { label: "General"; icon: "󰒓"; }
                    SidebarItem { label: "Bar"; icon: "󰛡"; }
                    SidebarItem { label: "Hyprland"; icon: ""; }
                    SidebarItem { label: "Wallpaper"; icon: "󰸉"; }
                    SidebarItem { label: "keyboard";  icon: ""; }
                    SidebarItem { label: "Big Panel"; page: "BigPanel"; icon: ""; }

                    Item { Layout.fillHeight: true }

                    component SidebarItem: Rectangle {
                        property string label
                        property string icon
                        property string page: label
                        property bool isActive: activePage === page
                        property color inactiveColor: Qt.rgba(Colors.inverse_surface.r, Colors.inverse_surface.g, Colors.inverse_surface.b, 0.5)

                        Layout.fillWidth: true
                        Layout.preferredHeight: 44
                        radius: 12
                        color: isActive ? Qt.rgba(Colors.secondary_container.r, Colors.secondary_container.g, Colors.secondary_container.b, 0.8) : "transparent"

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: sidebarCollapsed ? 0 : 16
                            spacing: sidebarCollapsed ? 0 : 16

                            Text {
                                text: icon
                                font.family: "Symbols Nerd Font"
                                font.pixelSize: 18
                                color: isActive ? Colors.secondary : inactiveColor
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillWidth: sidebarCollapsed
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Text {
                                text: label
                                color: isActive ? Colors.secondary : inactiveColor
                                font.pixelSize: 14
                                font.weight: isActive ? Font.Bold : Font.Normal
                                visible: !sidebarCollapsed
                                opacity: sidebarCollapsed ? 0 : 1
                            }
                        }

                        TapHandler {
                            onTapped: activePage = page
                            cursorShape: Qt.PointingHandCursor
                        }

                        HoverHandler {
                            id: hover
                            cursorShape: Qt.PointingHandCursor
                        }

                        Rectangle {
                            anchors.fill: parent
                            color: Colors.on_secondary_container
                            opacity: hover.hovered && !isActive ? 0.3 : 0
                            radius: 12
                        }

                    }

                }

                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
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
                        source: "pages/" + activePage + ".qml"
                    }
                }
            }
        }
    }
}
