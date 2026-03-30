import QtQuick
import qs.widgets
import qs.config

Background{
  width: clock.width
  StyledText {
    id: clock
    text: Config.time
  }
}
