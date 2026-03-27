import Quickshell
import Quickshell.Widgets 
import Quickshell.Io
import qs.vars
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel

Rectangle {
    id: root
    Layout.fillWidth: true
    Layout.preferredHeight: 45
    color: Qt.rgba(0, 0, 0, 0.2)
    radius: 5
    
    signal filterChanged(string text)
    signal navigateDown()
    signal navigateUp()
    signal enterPressed(string text)
    signal escapePressed()
    
    property alias text: searchInput.text
    
    function focusInput() { searchInput.forceActiveFocus(); }

    TextInput {
        id: searchInput
        anchors.fill: parent
        anchors.margins: 10
        color: Colors.inverse_surface
        font.pixelSize: 18
        font.family: fontFamily
        verticalAlignment: Text.AlignVCenter
        focus: true
        activeFocusOnTab: true
        onTextChanged: root.filterChanged(text)
        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Down) {
                root.navigateDown();
                event.accepted = true;
            } 
            else if (event.key === Qt.Key_Up) {
                root.navigateUp();
                event.accepted = true;
            }
            else if (event.key === Qt.Key_Escape) {
                root.escapePressed();
                event.accepted = true;
            }
        }
        
        Keys.onReturnPressed: {
            root.enterPressed(text);
        }
    }
}
