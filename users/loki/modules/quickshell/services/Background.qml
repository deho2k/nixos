pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.config

// Desktop background widget — renders below all windows, above the wallpaper.
// Shows clock (time / day / date) and the active music player when one exists.
// All colors are driven by the matugen Colors singleton and update live.
Variants {
  id: root
  model: Quickshell.screens
  PanelWindow {
    id: backgroundWidget
    required property var modelData
    screen: modelData
    aboveWindows: false
    exclusionMode: ExclusionMode.Ignore

    anchors.top: true
    margins { top: 70; bottom: 70; right: 70; left: 70; }

    color: "transparent"

    // Fixed width keeps layout stable when track titles change length
    implicitWidth: 390
    implicitHeight: mainColumn.implicitHeight + 40

    // ── Clock (seconds-precision so the colon blinks and seconds update) ──────
    SystemClock {
      id: wallClock
      precision: SystemClock.Minutes
    }

    readonly property string displayHours:   Qt.formatDateTime(wallClock.date, "hh")
    readonly property string displayMinutes: Qt.formatDateTime(wallClock.date, "mm")
    readonly property string displaySeconds: Qt.formatDateTime(wallClock.date, "ss")
    readonly property string displayDay:     Qt.formatDateTime(wallClock.date, "dddd").toUpperCase()
    readonly property string displayMonth:   Qt.formatDateTime(wallClock.date, "MMMM")
    readonly property string displayDate:    Qt.formatDateTime(wallClock.date, "d")
    readonly property string displayYear:    Qt.formatDateTime(wallClock.date, "yyyy")

    readonly property bool colonVisible: parseInt(displaySeconds) % 2 === 0

    property real trackPosition: 0   // current playback position (in seconds)
    property real trackLength:   1   // total track duration — default 1 avoids ÷0

    onDisplaySecondsChanged: {
      if (Config.player) {
        trackPosition = Config.player.position
        trackLength   = Config.player.length > 0 ? Config.player.length : 1
      }
    }

    // Fraction through the track (0.0 – 1.0) used by the progress bar
    readonly property real trackProgress: trackPosition / trackLength

    readonly property string playerIcon: {
      if (!Config.player) return ""
      return Config.player.identity === "Spotify" ? "" : "󰎆"
    }

    function formatDuration(totalSeconds) {
      let s    = Math.max(0, Math.floor(totalSeconds))
      let mins = Math.floor(s / 60)
      let secs = s % 60
      return mins + ":" + (secs < 10 ? "0" + secs : secs)
    }

    ColumnLayout {
      id: mainColumn
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      anchors.rightMargin: 20
      anchors.bottomMargin: 20
      spacing: 6

      Text {
        Layout.alignment: Qt.AlignRight
        text: backgroundWidget.displayDay
        font.pixelSize: 13
        font.letterSpacing: 5
        font.weight: Font.Medium
        color: Colors.primary
        opacity: 0.65
        style: Text.Raised
        styleColor: Qt.rgba(0, 0, 0, 0.6)
      }

      RowLayout {
        Layout.alignment: Qt.AlignRight
        spacing: 0

        Text {
          text: backgroundWidget.displayHours
          font.pixelSize: 100
          font.weight: Font.Bold
          color: Colors.on_surface
          style: Text.Raised
          styleColor: Qt.rgba(0, 0, 0, 0.7)
          Behavior on color { ColorAnimation { duration: 400 } }
        }

        Text {
          text: ":"
          font.pixelSize: 100
          font.weight: Font.Thin
          color: Colors.primary
          style: Text.Raised
          styleColor: Qt.rgba(0, 0, 0, 0.7)
          opacity: backgroundWidget.colonVisible ? 0.9 : 0.15
          Behavior on opacity {
            NumberAnimation { duration: 180; easing.type: Easing.InOutQuad }
          }
        }

        Text {
          text: backgroundWidget.displayMinutes
          font.pixelSize: 100
          font.weight: Font.Bold
          color: Colors.on_surface
          style: Text.Raised
          styleColor: Qt.rgba(0, 0, 0, 0.7)
          Behavior on color { ColorAnimation { duration: 400 } }
        }

        Text {
          Layout.alignment: Qt.AlignBottom
          bottomPadding: 14
          leftPadding: 8
          text: backgroundWidget.displaySeconds
          font.pixelSize: 22
          font.weight: Font.Light
          color: Colors.primary
          opacity: 0.70
          style: Text.Raised
          styleColor: Qt.rgba(0, 0, 0, 0.6)
        }
      }

      Item {
        Layout.fillWidth: true
        implicitHeight: 10

        Rectangle {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          width: parent.width
          height: 1
          color: Colors.outline
          opacity: 0.25
        }
        Rectangle {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          width: parent.width * 0.35
          height: 2
          radius: 1
          color: Colors.primary
          opacity: 0.55
          Behavior on color { ColorAnimation { duration: 600 } }
        }
      }

      RowLayout {
        Layout.alignment: Qt.AlignRight
        spacing: 8

        Text {
          text: backgroundWidget.displayMonth
          font.pixelSize: 15
          font.letterSpacing: 2
          font.weight: Font.Light
          color: Colors.on_surface
          opacity: 0.55
          style: Text.Raised
          styleColor: Qt.rgba(0, 0, 0, 0.6)
        }
        Text {
          text: backgroundWidget.displayDate
          font.pixelSize: 15
          font.weight: Font.Bold
          color: Colors.primary
          opacity: 0.80
          style: Text.Raised
          styleColor: Qt.rgba(0, 0, 0, 0.6)
          Behavior on color { ColorAnimation { duration: 400 } }
        }
        Text {
          text: "·"
          font.pixelSize: 15
          color: Colors.outline
          opacity: 0.50
        }
        Text {
          text: backgroundWidget.displayYear
          font.pixelSize: 15
          font.letterSpacing: 2
          font.weight: Font.Light
          color: Colors.on_surface
          opacity: 0.45
          style: Text.Raised
          styleColor: Qt.rgba(0, 0, 0, 0.6)
        }
      }

      // ════════════════════════════════════════════════════════════════════
      //  MUSIC PLAYER SECTION
      // ════════════════════════════════════════════════════════════════════
      Item {
        Layout.fillWidth: true
        implicitHeight: Config.player ? playerColumn.implicitHeight + 16 : 0
        opacity:        Config.player ? 1.0 : 0.0
        clip:           true
        visible:        opacity > 0.0

        Behavior on opacity {
          NumberAnimation { duration: 450; easing.type: Easing.InOutQuad }
        }
        Behavior on implicitHeight {
          NumberAnimation { duration: 450; easing.type: Easing.InOutQuad }
        }

        ColumnLayout {
          id: playerColumn
          anchors.right: parent.right
          anchors.left:  parent.left
          anchors.top:   parent.top
          anchors.topMargin: 8
          spacing: 10
          RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Rectangle {
              Layout.fillWidth: true
              height: 1
              color: Colors.outline
              opacity: 0.20
            }
            Text {
              text: backgroundWidget.playerIcon
              font.pixelSize: 22
              color: Colors.primary
              opacity: 0.45
              style: Text.Raised
              styleColor: Qt.rgba(0, 0, 0, 0.6)
            }
          }
          RowLayout {
            Layout.fillWidth: true
            spacing: 14
            ClippingWrapperRectangle {
              radius: 12; topLeftRadius: 4; bottomRightRadius: 4
              implicitWidth:  56
              implicitHeight: 56
              Image {
                anchors.fill: parent
                source:   Config.player.trackArtUrl
                fillMode: Image.PreserveAspectCrop
                visible:  Config.player ? Config.player.trackArtUrl !== "" : false
                asynchronous: true
              }
            }
            ColumnLayout {
              Layout.fillWidth: true
              spacing: 3

              Text {
                Layout.fillWidth: true
                text: Config.player ? Config.player.trackTitle : ""
                font.pixelSize: 15
                font.weight: Font.Medium
                color: Colors.on_surface
                opacity: 0.90
                elide: Text.ElideRight
                style: Text.Raised
                styleColor: Qt.rgba(0, 0, 0, 0.65)
              }

              Text {
                Layout.fillWidth: true
                text: Config.player ? Config.player.trackArtist : ""
                font.pixelSize: 13
                font.weight: Font.Light
                color: Colors.on_surface
                opacity: 0.50
                elide: Text.ElideRight
                style: Text.Raised
                styleColor: Qt.rgba(0, 0, 0, 0.6)
              }
              Text {
                text: Config.player
                ? (Config.player.isPlaying ? "Playing" : "Paused")
                : ""
                font.pixelSize: 11
                font.letterSpacing: 1
                color: Colors.primary
                opacity: 0.50
                style: Text.Raised
                styleColor: Qt.rgba(0, 0, 0, 0.6)
              }
            }
          }

          ColumnLayout {
            Layout.fillWidth: true
            spacing: 5

            //the bar itself
            Item {
              Layout.fillWidth: true
              implicitHeight: 4
              Rectangle {
                anchors.fill: parent
                radius: 2
                color: Colors.outline
                opacity: 0.20
              }
              Rectangle {
                id: progressFill
                anchors.left:   parent.left
                anchors.top:    parent.top
                anchors.bottom: parent.bottom
                width: parent.width * backgroundWidget.trackProgress
                radius: 2
                color:  Colors.primary
                opacity: 0.70
                Behavior on width {
                  NumberAnimation { duration: 950; easing.type: Easing.Linear }
                }
                Behavior on color { ColorAnimation { duration: 600 } }
              }
            }

            RowLayout {
              Layout.fillWidth: true

              Text {
                text: backgroundWidget.formatDuration(backgroundWidget.trackPosition)
                font.pixelSize: 11
                font.letterSpacing: 0.5
                color: Colors.on_surface
                opacity: 0.38
                style: Text.Raised
                styleColor: Qt.rgba(0, 0, 0, 0.6)
              }

              Item { Layout.fillWidth: true }

              Text {
                text: backgroundWidget.formatDuration(backgroundWidget.trackLength)
                font.pixelSize: 11
                font.letterSpacing: 0.5
                color: Colors.on_surface
                opacity: 0.38
                style: Text.Raised
                styleColor: Qt.rgba(0, 0, 0, 0.6)
              }
            }
          }
        }
      }
    }
  }
}
