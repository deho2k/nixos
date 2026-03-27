import Quickshell
import Quickshell.Services.Mpris 
import QtQuick
import qs.vars
import qs.widgets
import qs.modules.osd
import qs.modules.bar
import Quickshell.Io

ShellRoot{
  // !! folder where u save ur matugen themes json files
  property string matugenThemes: "~/.config/matugen/themes/"

  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: Global.fontSize
  property var player: Mpris.players.values.find(p => p.identity === "Spotify") ?? null

  IpcHandler {
    target: "wallpaper"
    function setWallpaper(path: string) {
      setNewWallpaper(path)
    } 
  }
  IpcHandler {
    target: "ui"
    function settingsToggle() { Global.settingsVisible = !Global.settingsVisible }
    function launchLauncher() { Global.panelSource = "launcher"; Global.bigPanelVisible = !Global.bigPanelVisible; }
    function osdSong() { Global.osdPlayerVisible = true;hideTimer.running = true }
    function osdVolume(percentage: real) { 
      Global.osdVolumeVisible = true;
      Global.volume = percentage;
      hideTimer.running = true 
    }
  }
  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: {
      Global.osdVolumeVisible = false
      Global.osdPlayerVisible = false
    }
  }

  function setNewWallpaper(path = "") { 
    // holy slop
    const swwwCmd = path == ""? 
    `echo "no path"` :
    `swww img "${path}" --transition-type ${cfg.config.wallpaper.swwwTransition} --transition-duration 1`;

    const matugenCmd = `matugen image "${path == ""? Colors.image: path}" --source-color-index 0`

    const isWallpaperTheme = cfg.config.wallpaper.theme == "wallpaper";

    const matugenArgs = isWallpaperTheme 
      ? "" 
      : `--import-json ${matugenThemes}${cfg.config.wallpaper.theme}.json`;

    Quickshell.execDetached([
      "bash", "-c", 
      `${swwwCmd} && ${matugenCmd} ${matugenArgs} && qs ipc call colors reload`
    ]);
  }
  JsonReader {id: cfg}
  //OldBar{}
  Bar{}
  //Clock {}
  OsdVolume {}
  OsdPlayer {}
  //Profile {}
  Loader{source: "modules/bigPanel/panel.qml"; active: Global.bigPanelVisible}
  Loader{source: "modules/settings/Settings.qml"; active: Global.settingsVisible}
  Component.onCompleted: {
  }
}
