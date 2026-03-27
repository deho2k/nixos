import QtQuick
import qs.vars
import QtQuick.Controls

Rectangle {
  id: sliderRoot
  property string label
  property real sliderValue
  property real from: 0
  property real to: 100
  signal valueChanged(real value)


  implicitHeight: 50
  color: Colors.primary
  radius: 8

  Text { 
    text: sliderRoot.label
    font.pixelSize: 24
    font.bold: true 
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 20
    color: Colors.background
  }


  Slider {
    id: slider
    from: parent.from
    to: parent.to
    value: parent.sliderValue
    stepSize: 1
    onMoved:parent.valueChanged(value)
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 50

    background: Rectangle {
      x: slider.leftPadding
      y: slider.topPadding + slider.availableHeight / 2 - height / 2
      implicitWidth: 200
      implicitHeight: 6
      width: slider.availableWidth
      height: implicitHeight
      radius: 3
      color: Colors.secondary_container

      Rectangle {
        width: slider.visualPosition * parent.width
        height: parent.height
        color: Colors.secondary
        radius: 3
      }
    }

    handle: Rectangle {
      x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
      y: slider.topPadding + slider.availableHeight / 2 - height / 2
      implicitWidth: 20
      implicitHeight: 20
      radius: 10
      color: Colors.background
      border.width: 2
    }
  }
  Text {
    text: Math.round(slider.value)
    color: Colors.primary
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 20
    font.pixelSize: 14
    font.bold: true
    horizontalAlignment: Text.AlignRight
  }
}
