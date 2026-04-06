import Quickshell
import QtQuick
import qs.services
import qs.modules.bars
import qs.modules.frame

ShellRoot{
  id:shellRoot
  Handler {}

  Bar{}
  Frame {id: frame}
  HyprSubmap {}
}

// NOTES
// better bar postioning so it doesnt go -20
// add a nice workspace icons ts
// add a player to the sidebar
// add a background for eatch space of the bars
// wallpaper selector make it so it doesnt scroll eatch time its opened
