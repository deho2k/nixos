import Quickshell
import QtQuick
import qs.config
import qs.modules.bars.side
import qs.modules.bars.top
import qs.modules.frame

ShellRoot{
  id:shellRoot
  Handler {}



  Frame {id: frame}
  Loader {source:"modules/bars/"+ Config.bar.pos +"/Bar.qml"}

}

// NOTES
// make the playerosd come out of the frame nicely intergrated also add animations
// better bar postioning so it doesnt go -20
// maybe just launch the music eatch time like the wallpaper picker
// add a nice workspace icons ts
// learn how to use canvas
// add a player to the sidebar
// add a background for eatch space of the bars
// wallpaper selector make it so it doesnt scroll eatch time its opened
