import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs.vars


LazyLoader {
    active: Global.osdPlayerVisible 
    IpcHandler {
        target: "playerOsd"
        function player() {
            Global.osdPlayerVisible = true
            hideTimer.restart()
        }
    }
    PanelWindow {
        id: playerOsd
        anchors.top: true
        margins.top: 60
        margins.left: 60

        exclusionMode: ExclusionMode.Ignore
        implicitWidth: 350
        implicitHeight: 140
        color: "transparent"
        mask: Region {}


        Rectangle {
            anchors.fill: parent
            radius: 16
            color: Colors.background

            RowLayout {
                anchors {
                    fill: parent
                    margins: 8
                }

                ClippingRectangle {
                    id: artImage
                    width: 130
                    Layout.fillHeight: true
                    radius: 12
                    anchors.left:parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    Image {
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                        width: 10
                        height: 10
                        source: player.trackArtUrl
                        opacity: 1
                    }
                }
                ColumnLayout {
                    Text {
                        Layout.maximumWidth: playerOsd.width - artImage.width - 40
                        Layout.minimumWidth: 230
                        text: player.trackTitle
                        color: Colors.primary
                        font.pixelSize: 20
                        font.family: fontFamily
                        font.bold: true
                        elide: Text.ElideRight
                        maximumLineCount: 1
                    }
                    Text {
                        text: player.trackArtist
                        Layout.maximumWidth: playerOsd.width - artImage.width - 40
                        color: Colors.secondary
                        font.pixelSize: 16
                        elide: Text.ElideRight
                        Layout.rightMargin: 8
                    }
                }

            }
        }
    }
}
