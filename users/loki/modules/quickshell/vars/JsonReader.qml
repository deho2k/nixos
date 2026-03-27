import Quickshell.Io
import QtQuick
import Quickshell

FileView {
    id: json
    path: Quickshell.env("HOME") + "/.config/quickshell/vars/settings.json"

    property alias config: adapter

    JsonAdapter {
        id: adapter

        property JsonObject hyprland: JsonObject {
            property bool animations: true
            property int batteryMax: 80
            property int gapsIn: 5
            property int gapsOut: 10
            property int rounding: 10
            property string animationType: "end4"
        }
        property JsonObject wallpaper: JsonObject {
            property bool changeBacklight: true
            property string swwwTransition: "wave"
            property string theme: "wallpaper"
        }

        property JsonObject bar: JsonObject {
            property int radius: 8
            property int sideMargin: 0
            property int opacity: 100
            property int borderWidth: 0
            property int height: 30
            property bool margins: false
            property bool floating: false
            property string layout: "Dev"
        }

        property JsonObject bigPanel: JsonObject {
            property bool visible: false
            property bool anchorCenter: true
            property bool anchorBottom: true
            property bool anchorLeft: true
            property int margins: 0
            property JsonObject services: JsonObject {
                property int launcherWidth: 500
                property int wallpaperWidth: 1000
            }
        }
        property list<string> favWallpaper: [ ]
        property list<string> todoTasks: [ ]

    }
    onAdapterUpdated: writeAdapter()
}
