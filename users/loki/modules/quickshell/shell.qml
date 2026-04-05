import Quickshell
import QtQuick
import qs.modules.bars
import qs.modules.frame

ShellRoot{
  id:shellRoot
  Handler {}

  Bar{}
  Frame {id: frame}
}

// NOTES
// better bar postioning so it doesnt go -20
// maybe just launch the music eatch time like the wallpaper picker
// add a nice workspace icons ts
// add a player to the sidebar
// add a background for eatch space of the bars
// wallpaper selector make it so it doesnt scroll eatch time its opened
