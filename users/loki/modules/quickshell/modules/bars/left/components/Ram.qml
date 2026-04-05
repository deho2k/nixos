import QtQuick
import qs.config
import qs.widgets

Background {
  CircleProgress {
    anchors.centerIn: parent
    percentage: Config.memUsage
    icon: ""
  }
}
