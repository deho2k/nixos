import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import qs.config
import "components"

PanelWindow {
  id: root
  required property var model
  implicitHeight: 600
  implicitWidth: 550 + arcRight.width + arcLeft.width
  focusable: true
  color: "transparent"
  onVisibleChanged: search.text = ""
  exclusionMode: ExclusionMode.Normal
  Component.onCompleted: {
    if (this.WlrLayershell != null) {
      //used to set custom animation in the hyprlnad config check
      // hyprland/rules.conf
      this.WlrLayershell.namespace = "qs-slide-bottom"
    }
  }
  anchors {
    bottom: true
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
  property int aw: 40
  property int ah: 40
  Shape {
    id: arcRight
    width: root.aw
    height: root.ah
    anchors.bottom: panel.bottom
    anchors.left: panel.right

    ShapePath {
      fillColor: Colors.background
      strokeColor: "transparent"

      startX: 0; startY: root.ah
      PathLine { x: 0; y: 0 }
      PathArc {
        x: root.aw; y: root.ah
        radiusX: root.aw; radiusY: root.ah
        direction: PathArc.Counterclockwise
      }
    }
  }
  Shape {
    id: arcLeft
    width: root.aw
    height: root.ah
    anchors.bottom: panel.bottom
    anchors.right: panel.left

    ShapePath {
      fillColor: Colors.background
      strokeColor: "transparent"

      startX: root.aw; startY: root.ah
      PathLine { x: root.aw; y: 0 }
      PathArc {
        x: 0; y: root.ah
        radiusX: root.aw; radiusY: root.ah
        direction: PathArc.Clockwise
      }
    }
  }
  Rectangle {
    id: panel
    color: Colors.background
    anchors.rightMargin: arcRight.width
    anchors.leftMargin: arcLeft.width
    anchors.fill: parent
    radius: 24
    bottomLeftRadius: 0; bottomRightRadius: 0
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
