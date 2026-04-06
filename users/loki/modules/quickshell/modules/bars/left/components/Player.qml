// Player.qml
import QtQuick
import qs.widgets
import qs.config

Background {
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
  CircleProgress {
    MouseArea {
      anchors.centerIn: parent
      onClicked: {
        Config.player.togglePlaying()
      }
    }
    anchors.centerIn: parent
    percentage: root.perc
    icon: Config.player.isPlaying ? "" : ""
    lineWidth: 5
  }
}
