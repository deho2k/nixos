pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris 
import QtQuick
import "json"

Singleton {
  id: root

  JsonReader {id: cfg}
  property alias bar: cfg.bar

  // mpris default chain
  property var player: {
      const players = Mpris.players.values;
      return players.find(p => p.identity === "Spotify") ?? 
             players.find(p => p.identity === "mpc" || p.identity === "mpd") ?? 
             (players.length > 0 ? players[0] : null);
  }

  function setWallpaper(path = "") { 
    const swwwCmd = path == ""? 
    `echo "no path"` :
    `swww img "${path}" --transition-type wave --transition-duration 1`;

    const matugenCmd = `matugen image "${path == ""? Colors.image: path}" --source-color-index 0`

    Quickshell.execDetached([
      "bash", "-c", 
      `${swwwCmd} && ${matugenCmd} && qs ipc call colors reload`
    ]);
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
}
