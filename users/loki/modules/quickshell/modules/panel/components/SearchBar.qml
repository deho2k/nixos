//SearchBar.qml
import QtQuick
import qs.config

Rectangle{
  required property var list
  property alias text: searchInput.text 
  function grabFocus() {
    searchInput.forceActiveFocus();
  }
  color: Colors.primary
  TextInput {
    id: searchInput
    anchors.verticalCenter: parent.verticalCenter
    font.pixelSize: 18
    focus: true
    onTextChanged: root.filterApps(text)
    Keys.onPressed: (event) => {
      if (event.key === Qt.Key_Down) { appList.incrementCurrentIndex() }
      else if (event.key === Qt.Key_Up) { appList.decrementCurrentIndex() }
      else if (event.key === Qt.Key_Escape) { root.active = false }
    }
    Keys.onReturnPressed: {
      appList.currentItem.modelData.execute()
      root.active = false
    }
  }
}
