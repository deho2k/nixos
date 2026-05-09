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
  Background {}
}
