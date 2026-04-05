import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import "components"

PanelWindow {
  id: root
  required property var model
  implicitHeight: 600
  implicitWidth: 550
  focusable: true
  color: "transparent"
  onVisibleChanged: search.text = ""
  exclusionMode: ExclusionMode.Normal
  anchors {
    left:false
  }

  function filterApps(query) {
    if (query === "") {
      model = DesktopEntries.applications.values;
      return;
    }
    let results = [];
    let allApps = DesktopEntries.applications.values;
    let lowerQuery = query.toLowerCase();
    for (let i = 0; i < allApps.length; i++) {
      if (allApps[i].name.toLowerCase().indexOf(lowerQuery) !== -1) {
        results.push(allApps[i]);
      }
    }
    model = results;
    list.currentIndex = 0;
  }
  Arc {
    anchors.bottom: parent.top
    anchors.left: parent.left
  }
  Rectangle {
    color: Colors.surface
    anchors.margins: 40
    anchors.fill: parent
    radius: 12
    height: parent.height
    width: parent.width

    ColumnLayout {
      id: launcherContent
      anchors.fill: parent
      anchors.margins: 20
      spacing: 14

      SearchBar {
        id: search
        list:list
        Layout.fillWidth: true
        Layout.preferredHeight:30
        radius: 1
      }

      ListView {
        id: list
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        model: root.model
        spacing: 2
        delegate: ItemDelegate {}
      }
    }
  }
}
