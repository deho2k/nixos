// Player.qml
import QtQuick
import qs.widgets
import qs.config

Background {
  id: root
  CircleProgressWrapper {
    MouseArea {
      anchors.centerIn: parent
      onClicked: {
        Config.player.togglePlaying()
      }
    }
    percentage: Config.trackPosition / Config.trackLength * 100
    icon: Config.player ? Config.player.identity == "Spotify"? "": "󰎆" : ""
  }
}
