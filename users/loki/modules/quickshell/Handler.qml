pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config
import qs.services
import qs.modules.panel
import qs.modules.settings

Scope {
  id:root
  IpcHandler {
    target: "wallpaper"
    function wallpaper(path:string) {Config.setWallpaper(path)}
  }
  IpcHandler {
    target: "ui"
    function toggleSettings() {settings.visible = !settings.visible}
    function launchLauncher() {panel.visible = !panel.visible}
    function toggleMusicOsd(perc: real) {
      musicOsdLoader.volume = perc * 100
      musicOsdLoader.active = true; 
      hideTimer.restart(); 
    }
  }

  Timer {
    id: hideTimer
    interval: 3000
    onTriggered: { musicOsdLoader.active = false; }
  }

  Settings {id:settings; visible:false}
  LazyLoader {
    id: musicOsdLoader
    active:false
    property int volume: 20
    MusicOsd { volumePerc: musicOsdLoader.volume }
  }

  Panel {
    id:panel
    model: DesktopEntries.applications.values
    visible:false
  }
}
