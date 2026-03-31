import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.config

Background{
  width: icon.width + tracktitle.width +  25
  RowLayout {
    spacing: 5
    anchors.centerIn: parent
    StyledText {
      id:icon
      text: Config.player.identity == "spotify"? "": "󰎆"
    }
    StyledText {
      id: tracktitle
      text: Config.player.trackTitle
    }
  }
}
