import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.config

Background {
    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8
        Repeater {
            model: Hyprland.workspaces.values.filter(ws => ws.id > 0).sort((a, b) => a.id - b.id)
            delegate: Rectangle {
                id: dot
                property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id
                Layout.preferredWidth: isActive ? 20 : 12
                Layout.preferredHeight: 12

                radius: 6
                color: isActive ? Colors.primary : Colors.secondary

                Behavior on Layout.preferredWidth { 
                    NumberAnimation { duration: 150; easing.type: Easing.OutCubic } 
                }

                Behavior on color { ColorAnimation { duration: 150 } }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + modelData.id)
                }
            }
        }
    }
}
