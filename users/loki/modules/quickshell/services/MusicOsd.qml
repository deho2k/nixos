
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config

PanelWindow {
  id: playerOsd
  property int volumePerc: 50
  anchors.bottom: true
  margins.bottom: 60

  exclusionMode: ExclusionMode.Ignore
  implicitWidth: 400
  implicitHeight: 150
  color: "transparent"
  mask: Region {}

  RowLayout {
    anchors.fill: parent
    // music
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      implicitWidth: 15
      radius: 16
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
          Text {
            Layout.maximumWidth: playerOsd.width - artImage.width - 40
            Layout.minimumWidth: 230
            text: Config.player.trackTitle
            color: Colors.primary
            font.pixelSize: 20
            font.bold: true
            elide: Text.ElideRight
            maximumLineCount: 1
          }
          Text {
            text: Config.player.trackArtist
            Layout.maximumWidth: playerOsd.width - artImage.width - 40
            color: Colors.secondary
            font.pixelSize: 16
            elide: Text.ElideRight
            Layout.rightMargin: 8
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
