// Workspaces.qml
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.config

Background {
    ColumnLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8
        
        Repeater {
            model: Hyprland.workspaces.values.filter(ws => ws.id > 0).sort((a, b) => a.id - b.id)
            delegate: Rectangle {
                property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id
                
                // Swap Width/Height logic for vertical "pill" effect
                Layout.preferredHeight: isActive ? 20 : 12
                Layout.preferredWidth: 12
                Layout.alignment: Qt.AlignHCenter

                radius: 6
                color: isActive ? Colors.primary : Colors.secondary

                Behavior on Layout.preferredHeight { 
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
