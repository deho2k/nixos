import QtQuick
import QtQuick.Shapes
import qs.config
import Quickshell

Scope {

  // ── Visual frame (rounded border shape) ──────────────────────
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: frame
      required property var modelData
      screen: modelData
      visible: Config.frameVisible
      exclusionMode: ExclusionMode.Ignore
      anchors { top: true; bottom: true; left: true; right: true }
      color: "transparent"
      mask: Region {}

      // Avoid shadowing built-in width/height — use explicit names
      readonly property bool  isSide    : Config.bar.pos === "left"
      readonly property int   lw        : Config.frame.width
      readonly property int   cr        : Config.frame.radius
      readonly property int   frameW    : isSide ? screen.width  - Config.bar.width  : screen.width
      readonly property int   frameH    : isSide ? screen.height                     : screen.height - Config.bar.height

      Shape {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        antialiasing: true
        ShapePath {
          fillColor : Colors.background
          strokeWidth: 0
          fillRule  : ShapePath.OddEvenFill

          PathRectangle {
            width : frame.frameW
            height: frame.frameH
          }
          PathRectangle {
            x     : frame.isSide ? 0        : frame.lw
            y     : frame.isSide ? frame.lw : 0
            width : frame.isSide ? frame.frameW - frame.lw       : frame.frameW - frame.lw * 2 
            height: frame.isSide ? frame.frameH - frame.lw * 2  : frame.frameH - frame.lw
            topLeftRadius: frame.cr
            topRightRadius: frame.isSide? frame.lw == 0? 0 : frame.cr : frame.cr
            bottomLeftRadius: frame.isSide?  frame.cr: frame.lw == 0? 0 : frame.cr
            bottomRightRadius: frame.lw == 0? 0 : frame.cr
          }
        }
      }
    }
  }

  // ── Hyprland margin windows (one Variants block, one delegate) ──
  //
  // Each PanelWindow reserves exactly one edge worth of strut space.
  // They're invisible (transparent + no content) — their only job
  // is to push Hyprland's usable-area inward by `frame.width` px.
  //
  // Condition logic:  hide the edge that the bar already occupies,
  // since the bar's own PanelWindow already claims that strut.
  Variants {
    model: Quickshell.screens

    Item {
      required property var modelData

      component EdgePanel: PanelWindow {
        screen: modelData
        visible: Config.frameVisible
        color: "transparent"
      }

      EdgePanel {
        visible: Config.frameVisible && Config.bar.pos !== "top"
        anchors { top: true; left: true; right: true }
        implicitHeight: Config.frame.width
      }
      EdgePanel {
        visible: Config.frameVisible && Config.bar.pos !== "bottom"
        anchors { bottom: true; left: true; right: true }
        implicitHeight: Config.frame.width
      }
      EdgePanel {
        visible: Config.frameVisible && Config.bar.pos !== "left"
        anchors { left: true; top: true; bottom: true }
        implicitWidth: Config.frame.width
      }
      EdgePanel {
        visible: Config.frameVisible && Config.bar.pos !== "right"
        anchors { right: true; top: true; bottom: true }
        implicitWidth: Config.frame.width
      }
    }
  }
}
