import QtQuick
import qs.vars
import QtQuick.Controls

Rectangle {
    property string label
    property bool checked
    signal toggled(bool checked)
    
    implicitHeight: 50
    color: Colors.primary
    radius: 8
    
    Text { 
        text: label
        font.pixelSize: 24
        font.bold: true 
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 20
        color: Colors.background
    }
    
    Switch {
        id: settingSwitch
        checked: parent.checked
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.margins: 20
        onToggled: parent.toggled(checked)
        
        indicator: Rectangle {
            anchors.centerIn: parent
            implicitWidth: 42
            implicitHeight: 22
            radius: height / 2
            color: settingSwitch.checked ? Colors.secondary : Colors.outline
            
            Rectangle {
                width: 18
                height: 18
                radius: 9
                y: 2
                x: settingSwitch.checked ? parent.width - width - 2 : 2
                color: colBg
                
                Behavior on x {
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutQuad
                    }
                }
            }
        }
    }
}
