pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel

PanelWindow {
  // !! IMPORTANT !! set the path for ur wallpaper
  property string wallpapersPath: "/.config/walls/Wallpapers"
  Component.onCompleted: {
    if (this.WlrLayershell != null) {
      //used to set custom animation in the hyprlnad config check
      // hyprland/rules.conf
      this.WlrLayershell.namespace = "qs-slide-left"
    }
  }
  id: window
  exclusionMode: ExclusionMode.Ignore
  focusable: true
  implicitHeight: imageHeight + 200
  implicitWidth: screen.width
  color: "transparent"
  property int imageHeight: 500
  property int imageWidth: 300
  property int imageWidthFocused: 600
  property double skewFactor: -0.25
  property string currentImage: ""

  Process {
    id: gotoCurrentWallpaper
    command: ["sh", "-c", "cat /tmp/image.txt"]
    stdout: SplitParser {
      onRead: data => {
        if (!data || !data.trim()) return
        list.goTo("file:/" + data)
      }
    }
  }
  onVisibleChanged: {
    if (visible) {
      list.forceActiveFocus()
      Qt.callLater(() => list.positionViewAtIndex(list.currentIndex, ListView.Center))
    }
    gotoCurrentWallpaper.running = true;
  }


  FolderListModel {
    id: wallpaperModel
    folder: "file://" + Quickshell.env("HOME") + window.wallpapersPath;
    nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp", "*.gif", "*.mp4", "*.mkv", "*.mov", "*.webm"]
  }
  property var favsModel: []
  ColumnLayout { 
    anchors.fill: parent
    ListView {
      id: list
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true
      orientation: ListView.Horizontal
      model: wallpaperModel
      highlightMoveDuration: 500
      spacing: 0
      leftMargin: window.width /2
      rightMargin: window.width /2
      highlightRangeMode: ListView.StrictlyEnforceRange
      preferredHighlightBegin: (width / 2) - (window.imageHeight / 2)
      preferredHighlightEnd: (width / 2) + (window.imageHeight / 2)
      function goTo(path) {
        const idx = model.indexOf(path)
        if (idx !== -1) currentIndex = idx
      }
      Keys.onPressed: (event) => {
        if( visible){
          if (event.key === Qt.Key_Right || event.key === Qt.Key_K) {
            list.incrementCurrentIndex()
            event.accepted = true;
          } 
          else if (event.key === Qt.Key_Left || event.key === Qt.Key_J) {
            list.decrementCurrentIndex()
            event.accepted = true;
          }
          else if (event.key === Qt.Key_Return || event.key === Qt.Key_A) {
            if (list.currentItem && list.currentItem.filePath) {
              Quickshell.execDetached(["bash", "-c", "qs ipc call wallpaper wallpaper '" + list.currentItem.filePath + "'"])
            }
          }
        }
      }
      delegate: Item {
        id: imgDelegate
        width: ListView.isCurrentItem ? window.imageWidthFocused : window.imageWidth
        height: window.imageHeight
        required property string filePath
        readonly property bool isCurrent: ListView.isCurrentItem
        z: isCurrent ? 10:1

        Item {
          anchors.centerIn: parent
          width: parent.width
          height: parent.height
          scale: parent.isCurrent ? 1.15 : 0.95
          opacity: parent.isCurrent ? 1.0 : 0.6
          Behavior on scale { NumberAnimation { duration: 500; easing.type: Easing.OutBack } }
          Behavior on opacity { NumberAnimation { duration: 500 } }
          transform: Matrix4x4 {
            property real s: window.skewFactor
            matrix: Qt.matrix4x4(1, s, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
          }
          Item {
            anchors.fill: parent
            Rectangle { anchors.fill: parent; color: "black" }
            clip: true

            Image {
              anchors.centerIn: parent
              anchors.horizontalCenterOffset: -50 
              scale: 1.2
              width: parent.width + (parent.height * Math.abs(window.skewFactor)) + 50
              height: parent.height
              fillMode: Image.PreserveAspectCrop
              source: imgDelegate.filePath
              asynchronous: true
              transform: Matrix4x4 {
                property real s: -window.skewFactor
                matrix: Qt.matrix4x4(1, s, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              }
            }
          }
        }
      }
    }
  }
}
