pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris 
import Quickshell.Services.UPower 
import QtQuick
import "json"

Singleton {
  id: root

  // !! folder where u save ur matugen themes json files
  property string matugenThemes: "~/.config/matugen/themes/"
  property var battery: UPower.displayDevice

  JsonReader {id: cfg}
  property alias bar: cfg.bar
  property alias theme: cfg.theme

  // mpris default chain
  property var player: {
      const players = Mpris.players.values;
      return players.find(p => p.identity === "Spotify") ?? 
             players.find(p => p.identity === "mpc" || p.identity === "mpd") ?? 
             (players.length > 0 ? players[0] : null);
  }

  readonly property string time: { Qt.formatDateTime(clock.date, "hh:mm") }
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
      interval: 1000
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
    Quickshell.execDetached([ "bash", "-c", 
      `${swwwCmd} && ${matugenCmd} ${matugenArgs} && qs ipc call colors reload`
    ]);
  }
}
