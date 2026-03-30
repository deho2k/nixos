import QtQuick
import qs.widgets
import qs.config

Background{
  width: ram.width
  StyledText {
    id:ram
    text: "  " + Config.memUsage
  }
}
