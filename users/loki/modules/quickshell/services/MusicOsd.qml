import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.widgets
import QtQuick.Shapes

PanelWindow {
  id: playerOsd
  property int volumePerc: 50
  property int radius: 12
  anchors.left: true
  anchors.top: true

  margins.top: 80
  margins.left: Config.frame.enabled?  0: 60

  exclusionMode: ExclusionMode.Normal
  implicitWidth: 400
  implicitHeight: 150 + arcTop.height + arcBottom.height
  color: "transparent"

  property int aw: 30
  property int ah: 40
  mask: Region {}
  Shape {
    id: arcTop
    width: playerOsd.aw
    height: playerOsd.ah
    anchors.bottom: root.top
    anchors.left: root.left

    ShapePath {
      fillColor: Colors.background
      strokeColor: "transparent"

      startX: 0; startY: playerOsd.ah
      PathLine { x: 0; y: 0 }
      PathArc {
        x: playerOsd.aw; y: playerOsd.ah
        radiusX: playerOsd.aw; radiusY: playerOsd.ah
        direction: PathArc.Counterclockwise
      }
    }
  }
  Shape {
    id: arcBottom
    width: playerOsd.aw
    height: playerOsd.ah
    anchors.top: root.bottom
    anchors.left: root.left

    ShapePath {
      fillColor: Colors.background
      strokeColor: "transparent"

      startX: 0; startY: 0
      PathLine { x: playerOsd.aw; y: 0 }
      PathArc {
        x: 0; y: playerOsd.ah
        radiusX: playerOsd.aw; radiusY: playerOsd.ah
        direction: PathArc.Counterclockwise
      }
    }
  }
  RowLayout {
    id: root
    anchors.fill: parent
    anchors.topMargin: arcTop.height
    anchors.bottomMargin: arcBottom.height
    // music
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      implicitWidth: 15
      radius: playerOsd.radius
      bottomLeftRadius: Config.frame.enabled? 0 : playerOsd.radius
      topLeftRadius: Config.frame.enabled? 0 : playerOsd.radius
      color: Colors.background

      RowLayout {
        anchors {
          fill: parent
          margins: 8
        }

        ClippingWrapperRectangle {
          id: artImage
          radius: 12
          implicitWidth: 130
          Layout.fillHeight: true
          Image {
            source: Config.player.trackArtUrl
            fillMode: Image.PreserveAspectCrop
          }
        }
        ColumnLayout {
          StyledText {
            text: Config.player.trackTitle
            font.pixelSize: 20
            Layout.maximumWidth: playerOsd.width - artImage.width - 40
            Layout.minimumWidth: 230
          }
          StyledText {
            text: Config.player.trackArtist
            font.pixelSize: 16
            Layout.maximumWidth: playerOsd.width - artImage.width - 40
            Layout.rightMargin: 8
          }

          ProgressBar {
            id: pb
            Layout.fillWidth: true
            Layout.rightMargin: 20
            implicitHeight: 8
            value: Config.player.position
            from: 0
            to: Config.player.length

            background: Rectangle {
              implicitHeight: 8
              radius: 4
              color: Colors.outline_variant
            }

            contentItem: Item {
              implicitWidth: pb.width
              implicitHeight: pb.height

              Rectangle {
                width: pb.visualPosition * parent.width
                height: parent.height
                radius: 4
                color: Colors.outline
              }
            }
          }
          StyledText {
            text: Config.player.isPlaying ? "" : ""
            Layout.alignment: Qt.AlignCenter
          }
        }
      }
    }
    // volume
    Rectangle {
      color: Colors.background
      implicitWidth: 1
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 8

      Rectangle {
        width: 15
        anchors.fill: parent
        anchors.margins: 8
        radius: 32
        color: Colors.outline_variant

        Rectangle {
          anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
          }
          color: Colors.outline

          implicitHeight: parent.height * playerOsd.volumePerc / 100
          radius: parent.radius
        }
      }
    }
  }
}
