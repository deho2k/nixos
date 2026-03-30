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

    JsonAdapter {
        id: adapter
        property JsonObject bar: JsonObject {
            property int radius: 8
        }
    }
}
