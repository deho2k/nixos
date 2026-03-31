import Quickshell.Io
import QtQuick
import Quickshell

FileView {
    id: json
    path: Quickshell.env("HOME") + "/.config/quickshell/config/json/settings.json"

    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()

    property alias config: adapter
    property alias bar: adapter.bar
    property alias theme: adapter.theme

    JsonAdapter {
        id: adapter
        property JsonObject bar: JsonObject {
            property int margins: 8
            property int radius: 8
            property bool floating: true
        }
        property JsonObject theme: JsonObject {
            property int transitionDuration: 1
            property string transition: "wave"
            property string theme: "wallpaper"
        }
    }
}
