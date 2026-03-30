import QtQuick
import qs.widgets
import qs.config

Background{
  width: cpu.width
  StyledText {
    id: cpu
    text: "  " + Config.cpuUsage
  }
}
