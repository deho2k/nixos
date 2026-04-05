pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris 
import Quickshell.Services.UPower 
import QtQuick

// everytime u se Config.somethingsomething it is indeed refering to functions
// and variables from this section
Singleton {
  id: root


  // !! folder where u save ur matugen themes json files
  property string matugenThemes: "~/.config/matugen/themes/"

  // mpris default chain
  property var player: {
    const players = Mpris.players.values;
    return players.find(p => p.identity === "Spotify") ?? 
    players.find(p => p.identity === "mpc" || p.identity === "mpd") ?? 
    (players.length > 0 ? players[0] : null);
  }

  property var battery: UPower.displayDevice

  // be carefull there json
  // just for ease access alias the things in adapter
  property alias bar: adapter.bar
  property alias theme: adapter.theme
  property alias hyprland: adapter.hyprland
  property alias frame: adapter.frame
  FileView {
    path: Quickshell.env("HOME") + "/.config/quickshell/config/json/settings.json"
    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: adapter
      property JsonObject frame: JsonObject {
        property bool enabled: false
        property int width: 10
        property int radius: 10
      }
      property JsonObject bar: JsonObject {
        property int width: 45 // for the side bar
        property int height: 20 // for the top bar
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

  property string barLayout: "side"

  readonly property string timeHours: { Qt.formatDateTime(clock.date, "hh") }
  readonly property string timeMinutes: { Qt.formatDateTime(clock.date, "mm") }
  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
  property int memUsage: 0

  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        root.memUsage = Math.round(100 * used / total)
      }
    }
    Component.onCompleted: running = true
  }
  property int cpuUsage
  Process {
    id: cpuProc
    command: ["sh", "-c", `top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}'`]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        root.cpuUsage = data
      }
    }
    Component.onCompleted: running = true
  }
  Timer {
    interval: 3000
    running: true
    repeat: true
    onTriggered: {
      cpuProc.running = true
      memProc.running = true
    }
  }

  // FUNCTIONS
  function setWallpaper(path = "") { 
    const transition = Config.theme.transition
    const theme = Config.theme.theme
    const duration = Config.theme.transitionDuration
    const imagePath = path == ""? Colors.image : path

    const swwwCmd = path == ""? 
    `echo "no path cuz maybe we switching to a theme"` :
    `swww img "${path}" --transition-type ${transition} --transition-duration ${duration}`;

    const matugenCmd = `matugen image "${imagePath}" --source-color-index 0`

    const matugenArgs = theme == "wallpaper" ?
    "" :
    `--import-json ${matugenThemes}${theme}.json`;
    // execute previous commands
    Quickshell.execDetached([ "bash", "-c", `${swwwCmd} && ${matugenCmd} ${matugenArgs} && qs ipc call colors reload` ]);
  }
  // in the hyprland runtime file there are variables and i change them here
  function hyprlandRuntimePush(name, value) {
    Quickshell.execDetached(["bash", "-c", `sed -i 's/^\\$${name}=.*/\\$${name}=${value}/' ~/.config/hypr/hyprland/runtime.conf`])
  }
}
