import QtQuick
import qs.config

Rectangle{
  required property var list
  property alias text: searchInput.text 
  color: Colors.secondary
  TextInput {
    id: searchInput
    anchors.verticalCenter: parent.verticalCenter
    font.pixelSize: 18
    focus: true
    onTextChanged: root.filterApps(text)
    Keys.onPressed: (event) => {
      if (event.key === Qt.Key_Down) { parent.list.incrementCurrentIndex() }
      else if (event.key === Qt.Key_Up) { parent.list.decrementCurrentIndex() }
      else if (event.key === Qt.Key_Escape) { 
        root.visible = false 
      }

    }
    Keys.onReturnPressed: {
      parent.list.currentItem.modelData.execute()
      root.visible = false
    }
  }
}
