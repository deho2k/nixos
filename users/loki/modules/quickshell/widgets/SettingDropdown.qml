import QtQuick
import qs.vars
import QtQuick.Controls

Rectangle {
    id: root
    property string label
    property var options: []
    property int currentIndex: 0
    property string currentValue: options[currentIndex] || ""
    signal valueChanged(int index, string value)
    
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
    
    Rectangle {
        id: dropdownButton
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 20
        width: 130
        height: 35
        radius: 6
        color: Colors.secondary_container
        border.color: Colors.primary
        border.width: 2
        
        Row {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10
            
            Text {
                text: root.currentValue
                color: Colors.inverse_surface
                font.pixelSize: 14
                font.family: fontFamily
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 30
                elide: Text.ElideRight
            }
            
            Text {
                text: popup.visible ? "󰅃" : "󰅀"
                color: Colors.primary
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
                
                Behavior on rotation {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutQuad
                    }
                }
            }
        }
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (popup.visible) {
                    popup.close()
                } else {
                    popup.open()
                }
            }
        }
    }
    
    Popup {
        id: popup
        x: dropdownButton.x
        y: dropdownButton.y + dropdownButton.height + 5
        width: dropdownButton.width
        height: Math.min(optionsList.contentHeight + 4, 200)
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        
        background: Rectangle {
            radius: 6
            color: Colors.primary_container
            border.color: Colors.primary
            border.width: 2
        }
        
        contentItem: ListView {
            id: optionsList
            clip: true
            model: root.options
            
            delegate: Rectangle {
                width: optionsList.width
                height: 35
                color: mouseArea.containsMouse ? Colors.secondary : "transparent"
                radius: 4
                
                Text {
                    text: modelData
                    color: Colors.primary
                    font.pixelSize: 14
                    font.family: fontFamily
                    font.bold: index === root.currentIndex
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: 10
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.currentIndex = index
                        root.currentValue = modelData
                        popup.close()
                        root.valueChanged(index, modelData)
                    }
                }
                
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
                width: 0
                
                contentItem: Rectangle {
                    implicitWidth: 6
                    radius: 3
                }
            }
        }
    }
}
