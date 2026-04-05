import qs.widgets
import qs.config

Background {
  CircleProgress {
    anchors.centerIn: parent
    percentage: Config.cpuUsage
    icon: ""
  }
}
