import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.widgets
import QtQuick.Shapes
import Quickshell.Wayland 

PanelWindow {
  id: playerOsd
  property int volumePerc: 50
  property int radius: 12
  anchors.top: true

  exclusionMode: ExclusionMode.Normal
  implicitWidth: 400 + arcLeft.width + arcRight.width
  implicitHeight: 180
  color: "transparent"

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
  ColumnLayout {
    id: root
    anchors.fill: parent
    anchors.leftMargin: arcLeft.width
    anchors.rightMargin: arcRight.width
    // music
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      implicitHeight: 150
      radius: playerOsd.radius
      topLeftRadius: 0; topRightRadius: 0
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
            StyledText {
              anchors.centerIn: parent
              font.pixelSize: 50
              opacity: 0.6
              text: Config.player.isPlaying ? "" : ""
              Layout.alignment: Qt.AlignCenter
            }
          }
        }
        ColumnLayout {
          StyledText {
            text: Config.player.trackTitle
            font.pixelSize: 20
            Layout.maximumWidth: parent.width
            Layout.minimumWidth: 230 - arcLeft
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
        }
      }
    }
    // volume
    Rectangle {
      color: Colors.background
      implicitHeight: 24
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 12

      Rectangle {
        width: 15
        anchors.fill: parent
        anchors.margins: 8
        radius: 32
        color: Colors.outline_variant

        Rectangle {
          anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
          }
          color: Colors.outline

          implicitWidth: parent.width * playerOsd.volumePerc / 100
          radius: parent.radius
        }
      }
    }
  }
}
