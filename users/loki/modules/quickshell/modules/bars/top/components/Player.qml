import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

Background{
  id: root
  visible: Config.player
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
    CircleProgressWrapper {
      MouseArea {
        anchors.fill: parent
        onClicked: {
          Config.player.togglePlaying()
        }
      }
      Layout.preferredHeight: root.height
      Layout.preferredWidth: root.height
      percentage: root.perc
      icon: Config.player ? Config.player.identity == "Spotify"? "": "󰎆" : ""
    }
    StyledText {
      id: tracktitle
      Layout.maximumWidth: 200
      text: Config.player ? Config.player.trackTitle : ""
    }
  }
}
