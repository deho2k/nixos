import QtQuick
import qs.config

Image {
  id: imageArt
  anchors.fill: parent
  source:   Config.player.trackArtUrl
  fillMode: Image.PreserveAspectCrop
  visible:  Config.player ? Config.player.trackArtUrl !== "" : false
  asynchronous: true
  transform: Translate { id: imageTranslate; x: 0 }
  Behavior on source {
    SequentialAnimation {
      ParallelAnimation {
        NumberAnimation { 
          target: imageArt; property: "opacity"; to: 0 
          duration: 250; easing.type: Easing.InQuad 
        }
        NumberAnimation { 
          target: imageTranslate; property: "x"; to: -20 
          duration: 250; easing.type: Easing.InQuad 
        }
      }
      PropertyAction { } 
      PropertyAction { target: imageTranslate; property: "x"; value: 10 }
      ParallelAnimation {
        NumberAnimation { 
          target: imageArt; property: "opacity"; to: 1 
          duration: 250; easing.type: Easing.OutBack 
        }
        NumberAnimation { 
          target: imageTranslate; property: "x"; to: 0 
          duration: 250; easing.type: Easing.OutBack 
        }
      }
    }
  }
}
