import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config
import QtQuick.Shapes

PanelWindow {
  id: playerOsd
  property int volumePerc: 50
  property int radius: 12
  anchors.top: true

  exclusionMode: ExclusionMode.Normal
  implicitWidth: 400 + arcLeft.width + arcRight.width
  color: "transparent"

  readonly property int cardRadius: 14
  readonly property int artSize:    110
  readonly property int cardHeight: 120
  Behavior on implicitHeight {
    NumberAnimation {
      duration: 1000
      easing.type: Easing.OutElastic
    }
  }
  mask: Region {}

  property int aw: 40
  property real ahPercentage: 0.2
  property real ah: playerOsd.height * ahPercentage

  Shape {
    id: arcRight
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
  Rectangle {
    id: root
    anchors {
      top:    parent.top
      left:   parent.left
      right:  parent.right
      leftMargin:    arcLeft.width
      rightMargin: arcRight.width
    }
    implicitHeight: playerOsd.cardHeight

    color:  Colors.background
    radius: playerOsd.cardRadius; topLeftRadius:    0; topRightRadius: 0

    ClippingWrapperRectangle {
      id: albumArtFrame
      anchors {
        left:   parent.left
        top:    parent.top
        bottom: parent.bottom
      }
      width:  playerOsd.artSize
      radius: 12
      anchors.margins: 5


      Image {
        anchors.fill: parent
        source:       Config.player.trackArtUrl
        fillMode:     Image.PreserveAspectCrop
        asynchronous: true

        Behavior on source {
          // Brief fade when the track (and therefore art) changes
        }
      }

    }

    // ── Info area (everything to the right of the album art) ─────────────
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

      // Row 1: title + source icon
      RowLayout {
        Layout.fillWidth: true
        spacing: 8

        Text {
          Layout.fillWidth: true
          text:  Config.player ? Config.player.trackTitle : "Nothing playing"
          font.pixelSize: 17
          font.weight:    Font.Bold
          color:          Colors.on_surface
          elide:          Text.ElideRight
        }

        // Spotify  or generic music icon, top-right corner
        Text {
          text: Config.player
          ? (Config.player.identity === "Spotify" ? "" : "󰎆")
          : ""
          font.pixelSize: 13
          color:          Colors.primary
          opacity:        0.55
        }
      }

      // Row 2: artist name
      Text {
        Layout.fillWidth: true
        Layout.topMargin: 2
        text:  Config.player ? Config.player.trackArtist : ""
        font.pixelSize: 13
        font.weight:    Font.Light
        color:          Colors.on_surface
        opacity:        0.55
        elide:          Text.ElideRight
      }

      Item { Layout.fillHeight: true }

      // Row 3: progress bar
      Item {
        Layout.fillWidth: true
        implicitHeight: 4

        // Rail
        Rectangle {
          anchors.fill: parent
          radius: 2
          color:  Colors.outline_variant
        }

        // Fill
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

        // Playhead dot
        Rectangle {
          x: progressFill.width - (width / 2)
          anchors.verticalCenter: parent.verticalCenter
          width: 10; height: 10; radius: 5
          color: "white"
          opacity: 0.9
          Behavior on x {
            NumberAnimation { duration: 950; easing.type: Easing.Linear }
          }
        }
      }

      // Row 4: timestamps + play/pause + volume
      RowLayout {
        Layout.fillWidth: true
        Layout.topMargin: 6
        spacing: 8

        // Current position
        Text {
          text:           playerOsd.formatDuration(playerOsd.trackPosition)
          font.pixelSize: 11
          color:          Colors.on_surface
          opacity:        0.40
        }

        // Total length
        Text {
          text:           "/ " + playerOsd.formatDuration(playerOsd.trackLength)
          font.pixelSize: 11
          color:          Colors.on_surface
          opacity:        0.25
        }

        Item { Layout.fillWidth: true }

        // Play / pause state icon
        Text {
          text: Config.player
          ? (Config.player.isPlaying ? "" : "")
          : ""
          font.pixelSize: 14
          color:          Colors.primary
          opacity:        0.80
        }

        // ── Volume indicator ──────────────────────────────────────────
        // Speaker icon + compact horizontal bar + percentage
        RowLayout {
          spacing: 6

          // Speaker icon scales with volume level
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
