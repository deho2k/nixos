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
  property bool testActive: false
  property bool musicOsdActive: false
  IpcHandler {
    target: "wallpaper"
    function wallpaper(path:string) {Config.setWallpaper(path)}
  }
  IpcHandler {
    target: "ui"
    function toggleSettings() {settings.visible = !settings.visible}
    function launchLauncher() {panel.active = !panel.active}
    function toggleMusicOsd(perc: real) {
      musicOsdLoader.volume = perc * 100
      root.musicOsdActive = true
      hideTimer.restart(); 
    }
  }
  Timer {
    id: hideTimer
    interval: 3000
    onTriggered: { root.musicOsdActive = false; }
  }

  Settings {id:settings; visible:false}
  LazyLoader {
    id: musicOsdLoader
    active: true
    property int volume: 20
    MusicOsd { 
      volumePerc: musicOsdLoader.volume 
      implicitHeight: root.musicOsdActive? 180: 0
    }
  }

  Panel {
    id:panel
    model: DesktopEntries.applications.values
    active: false
  }
}
