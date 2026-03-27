import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs.vars


LazyLoader {
    active: Global.osdVolumeVisible
    IpcHandler {
        target: "volumeOsd"
        function volume(perc: real) {
            Global.percentage = perc * 100
            Global.osdVisible = true
            hideTimer.restart()
        }
    }
    PanelWindow {
        anchors.top: true
        margins.top: 60

        exclusionMode: ExclusionMode.Ignore
        implicitWidth: 400
        implicitHeight: 50
        color: "transparent"
        mask: Region {}


        Rectangle {
            anchors.fill: parent
            radius: cfg.config.ui.radius
            color: Colors.background

            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: 25
                    rightMargin: 25
                }

                Text {
                    text: ""
                    color: Colors.primary
                    font.pixelSize: fontSize
                    Layout.rightMargin: 8
                }

                Rectangle {
                    Layout.fillWidth: true

                    implicitHeight: 8
                    radius: 20
                    color: Colors.outline_variant

                    Rectangle {
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                        color: Colors.outline

                        implicitWidth: parent.width * Global.volume
                        radius: parent.radius
                    }
                }
            }
        }
    }
}

