import Quickshell
import QtQuick
import qs.modules.bar

ShellRoot{
  // handler has everything that isnt static such as any ipcHandlers, osd or launcher
  Handler {}

  Bar {}
}
