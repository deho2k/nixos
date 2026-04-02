import Quickshell
import QtQuick
import qs.modules.bars.side
import qs.modules.bars.top

// NOTES
// add a good way to swtich between side and top bar
// add a nice curve to the side bar 
// check out qmlformat 
// learn how to use canvas 
// add a player to the sidebar
// add a background for eatch space of the bars
// wallpaper selector make it so it doesnt scroll eatch time its opened
ShellRoot{
  id:shellRoot
  // handler has everything that isnt static such as any ipcHandlers, osd or launcher
  Handler {}

  property string barType: "side"
  Loader {source:"modules/bars/"+ shellRoot.barType +"/Bar.qml"}
}
