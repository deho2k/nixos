import Quickshell
import Quickshell.Io
import qs.vars
import qs.widgets
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: launcherRoot
    radius: 2
    bottomLeftRadius: cfg.config.bigPanel.margins > 0 || cfg.config.bigPanel.anchorCenter ? cfg.config.ui.radius :0
    bottomRightRadius: cfg.config.bigPanel.margins > 0 || cfg.config.bigPanel.anchorCenter ?  cfg.config.ui.radius :0
    color: Colors.background

    height: launcherContent.height
    width: cfg.config.bigPanel.services.launcherWidth
    focus: true
    border.width : 2
    border.color: Colors.primary
    
    property var appModel: DesktopEntries.applications.values
    
    function filterApps(query) {
        if (query === "") {
            appModel = DesktopEntries.applications.values;
            return;
        }
        let results = [];
        let allApps = DesktopEntries.applications.values;
        let lowerQuery = query.toLowerCase();
        for (let i = 0; i < allApps.length; i++) {
            if (allApps[i].name.toLowerCase().indexOf(lowerQuery) !== -1) {
                results.push(allApps[i]);
            }
        }
        appModel = results;
        list.currentIndex = 0;
    }
    
    
    function focusInput() {searchBox.focusInput() }
    
    ColumnLayout {
        id: launcherContent
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
        height: 500
        
        InputRectangle {
            id: searchBox
            onFilterChanged: (text) => launcherRoot.filterApps(text)
            onNavigateDown: list.incrementCurrentIndex()
            onNavigateUp: list.decrementCurrentIndex()
            onEscapePressed: Global.bigPanelVisible = false
            onEnterPressed: (text) => {
                if(text.startsWith(Global.leader)){
                    Global.executeString(text.slice(1))
                }
                else if (list.currentItem && list.currentItem.entry) {
                    list.currentItem.entry.execute();
                    text = ""
                    Global.bigPanelVisible = false;
                }
            }
        }
        
        ListView {
            id: list
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: launcherRoot.appModel
            spacing: 2
            
            delegate: Rectangle {
                property var entry: modelData
                width: list.width
                height: 48
                radius: 4
                color: ListView.isCurrentItem ? Colors.outline_variant : "transparent"
                
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    spacing: 10
                    
                    Image {
                        cache: true
                        source: modelData.icon ? "image://icon/" + modelData.icon : ""
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Text {
                        text: modelData.name
                        color: Colors.inverse_surface
                        font.pixelSize: 16
                        font.family: fontFamily
                        Layout.fillWidth: true
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        list.currentIndex = index
                        modelData.execute()
                        Global.bigPanelVisible = false
                    }
                }
            }
        }
    }
}
