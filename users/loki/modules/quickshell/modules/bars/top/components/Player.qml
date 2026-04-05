import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

Background{
  visible: Config.player
  id: root
  property int perc: Config.player 
      ? (Config.player.position / Config.player.length * 100) 
      : 0

  Timer {
    interval: 3000
    running: true
    repeat: true
    onTriggered: { root.perc = Config.player.position / Config.player.length * 100 }
  }
  RowLayout {
    id: layout
    spacing: 5
    anchors.centerIn: parent
    CircleProgress {
      percentage: root.perc
      icon: Config.player ? Config.player.identity == "Spotify"? "": "󰎆" : ""
      lineWidth: 3
      margin: 12
    }
    StyledText {
      id: tracktitle
      Layout.maximumWidth: 200
      text: Config.player ? Config.player.trackTitle : ""
    }
  }
}
