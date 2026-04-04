import Quickshell.Io
import QtQuick
import Quickshell

FileView {
  id: json
  path: Quickshell.env("HOME") + "/.config/quickshell/config/json/settings.json"

  watchChanges: true
  onFileChanged: reload()
  onAdapterUpdated: writeAdapter()

  property alias bar: adapter.bar
  property alias theme: adapter.theme
  property alias hyprland: adapter.hyprland
  property alias frame: adapter.frame

  JsonAdapter {
    id: adapter
    property JsonObject frame: JsonObject {
      property bool enabled: true
      property int width: 10
      property int radius: 10
    }
    property JsonObject bar: JsonObject {
      //if is side bar
      property int width: 45
      //if is top bar
      property int height: 20
      property int margins: 8
      property int radius: 8
      property bool floating: true
      property string pos: "side"
    }
    property JsonObject theme: JsonObject {
      property int transitionDuration: 1
      property string transition: "wave"
      property string theme: "wallpaper"
    }
    property JsonObject hyprland: JsonObject {
      property int rounding: 8
      property int gapsIn: 8
      property int gapsOut: 8
    }
  }
}
