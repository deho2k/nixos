import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import QtQuick.Shapes
import qs.config
import qs.widgets

PanelWindow {
  id: playerOsd
  property int volumePerc: 50
  property int radius: 12
  anchors.top: true

  exclusionMode: ExclusionMode.Normal
  implicitWidth: 400 + arcLeft.width + arcRight.width
  color: "transparent"

  property bool floating: Config.bar.floating && Config.bar.pos == "top"

  readonly property int cardRadius: 14
  readonly property int artSize:    110
  readonly property int cardHeight: 120
  Behavior on implicitHeight {
    NumberAnimation {
      duration: 200
      easing.type: Easing.InQuad
    }
  }
  margins.top: floating? 5 : 0
  mask: Region {}

  property int aw: 40
  property real ahPercentage: 0.2
  property real ah: playerOsd.height * ahPercentage

  Shape {
    id: arcRight
    visible: !playerOsd.floating
    width: playerOsd.aw
    height: playerOsd.ah
    anchors.left: root.right
    anchors.top: root.top

    ShapePath {
      fillColor: Colors.background
      strokeColor: "transparent"

      startX: 0; startY: 0
      PathLine { x: 0; y: playerOsd.ah }
      PathArc {
        x: playerOsd.aw; y: 0
        radiusX: playerOsd.aw; radiusY: playerOsd.ah
        direction: PathArc.Clockwise
      }
    }
  }
  Shape {
    id: arcLeft
    visible: !playerOsd.floating
    width: playerOsd.aw
    height: playerOsd.ah
    anchors.right: root.left
    anchors.top: root.top

    ShapePath {
      fillColor: Colors.background
      strokeColor: "transparent"

      startX: playerOsd.aw; startY: 0
      PathLine { x: 0; y: 0 }
      PathArc {
        x: playerOsd.aw; y: playerOsd.ah
        radiusX: playerOsd.aw; radiusY: playerOsd.ah
        direction: PathArc.Clockwise
      }
    }
  }
    property real trackPosition: 0
    property real trackLength:   1

    Timer {
        interval: 1000
        running:  true
        repeat:   true
        onTriggered: {
            if (Config.player) {
                trackPosition = Config.player.position
                trackLength   = Config.player.length > 0 ? Config.player.length : 1
            }
        }
    }
  readonly property real trackProgress: trackPosition / trackLength

  function formatDuration(totalSeconds) {
    let s    = Math.max(0, Math.floor(totalSeconds))
    let mins = Math.floor(s / 60)
    let secs = s % 60
    return mins + ":" + (secs < 10 ? "0" + secs : secs)
  }
  Rectangle {
    id: root
    anchors {
      top:    parent.top
      left:   parent.left
      right:  parent.right
      leftMargin: arcLeft.width
      rightMargin: arcRight.width
    }
    implicitHeight: playerOsd.cardHeight

    color:  Colors.background
    radius: playerOsd.cardRadius; topLeftRadius: playerOsd.floating? playerOsd.cardRadius : 0   ; topRightRadius: playerOsd.floating? playerOsd.cardRadius : 0

    ClippingWrapperRectangle {
      id: albumArtFrame
      anchors {
        left:   parent.left
        top:    parent.top
        bottom: parent.bottom
      }
      color: "transparent"
      width:  playerOsd.artSize
      radius: 12
      anchors.margins: 5


      TrackArt { }

    }
    ColumnLayout {
      anchors {
        left:          albumArtFrame.right
        right:         parent.right
        top:           parent.top
        bottom:        parent.bottom
        leftMargin:    12
        rightMargin:   18
        topMargin:     14
        bottomMargin:  12
      }
      spacing: 0
      RowLayout {
        Layout.fillWidth: true
        spacing: 8

        StyledText {
          Layout.fillWidth: true
          text:  Config.player ? Config.player.trackTitle : "Nothing playing"
          font.pixelSize: 17
          font.weight:    Font.Bold
          color:          Colors.on_surface
          elide:          Text.ElideRight
          textAnimateX: true
        }

        // Spotify  or generic music icon, top-right corner
        StyledText {
          text: Config.player
          ? (Config.player.identity === "Spotify" ? "" : "󰎆")
          : ""
          font.pixelSize: 13
          color:          Colors.primary
        }
      }

      StyledText {
        Layout.fillWidth: true
        Layout.topMargin: 2
        text:  Config.player ? Config.player.trackArtist : ""
        font.pixelSize: 13
        font.weight:    Font.Light
        color:          Colors.on_surface
        opacity:        0.55
        elide:          Text.ElideRight
        textAnimateX: true
      }

      Item { Layout.fillHeight: true }

      Item {
        Layout.fillWidth: true
        implicitHeight: 4
        Rectangle {
          anchors.fill: parent
          radius: 2
          color:  Colors.outline_variant
        }

        Rectangle {
          id: progressFill
          anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
          width:  Math.max(radius * 2,
          parent.width * playerOsd.trackProgress)
          radius: 2
          color:  Colors.primary
          Behavior on width {
            NumberAnimation { duration: 950; easing.type: Easing.Linear }
          }
          Behavior on color { ColorAnimation { duration: 500 } }
        }

      }

      RowLayout {
        Layout.fillWidth: true
        Layout.topMargin: 6
        spacing: 8

        Text {
          text:           playerOsd.formatDuration(playerOsd.trackPosition)
          font.pixelSize: 11
          color:          Colors.on_surface
          opacity:        0.40
        }

        Text {
          text:           "/ " + playerOsd.formatDuration(playerOsd.trackLength)
          font.pixelSize: 11
          color:          Colors.on_surface
          opacity:        0.25
        }

        Item { Layout.fillWidth: true }

        Text {
          text: Config.player
          ? (Config.player.isPlaying ? "" : "")
          : ""
          font.pixelSize: 14
          color:          Colors.primary
          opacity:        0.80
        }

        //volume indicator
        RowLayout {
          spacing: 6
          Text {
            text: {
              let v = playerOsd.volumePerc
              if (v === 0)   return "󰖁"
              if (v < 35)    return "󰕿"
              if (v < 70)    return "󰖀"
              return "󰕾"
            }
            font.pixelSize: 13
            color:          Colors.secondary
            opacity:        0.70
          }

          // Compact volume bar
          Item {
            implicitWidth:  64
            implicitHeight: 4

            Rectangle {
              anchors.fill: parent
              radius: 2
              color:  Colors.outline_variant
            }
            Rectangle {
              anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
              width:  Math.max(radius * 2,
              parent.width * (playerOsd.volumePerc / 100))
              radius: 2
              color:  Colors.secondary
              opacity: 0.80
              Behavior on width {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
              }
              Behavior on color { ColorAnimation { duration: 500 } }
            }
          }

          // Percentage label
          Text {
            text:           playerOsd.volumePerc + "%"
            font.pixelSize: 11
            color:          Colors.on_surface
            opacity:        0.40
          }
        }
      }
    }
  }
}
