import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.vars
import qs.widgets

    
PanelWindow {
    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: ExclusionMode.Ignore
    focusable: true
    implicitWidth: loader.width
    implicitHeight: loader.height
    color: "transparent"

    onVisibleChanged: {
        if (loader.item) {
            loader.item.focusInput()
        }
        if (Global.panelSource == "launcher" && loader.item) {
            loader.item.searchText = ""
        }
    }
    Loader {
        id: loader

        anchors.margins: cfg.config.bigPanel.margins
        anchors.centerIn: cfg.config.bigPanel.anchorCenter ? parent : undefined
        anchors.bottom: cfg.config.bigPanel.anchorBottom ? parent.bottom : undefined
        anchors.left: cfg.config.bigPanel.anchorLeft ? parent.left : undefined

        active: Global.bigPanelVisible

        source: "services/" + Global.panelSource + ".qml"
        focus: false
        
        onLoaded: {
            if (item && parent.visible) {
                item.focusInput();
            }
        }
    }
    
}
