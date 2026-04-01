import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

Background{
  RowLayout {
    spacing: 5
    anchors.centerIn: parent
    StyledText {
      id:icon
      text: Config.player ? Config.player.identity == "Spotify"? "": "󰎆" : ""
    }
    StyledText {
      id: tracktitle
      Layout.maximumWidth: 200
      text: Config.player ? Config.player.trackTitle : ""
    }
  }
}
