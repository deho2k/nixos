import Quickshell
import QtQuick
import qs.modules.bars.side
import qs.modules.bars.top

ShellRoot{
  id:shellRoot
  // handler has everything that isnt static such as any ipcHandlers, osd or launcher
  Handler {}

  property string barType: "side"
  Loader {source:"modules/bars/"+ shellRoot.barType +"/Bar.qml"}
}
