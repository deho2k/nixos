import qs.widgets
import qs.config

Background {
  CircleProgress {
    percentage: Config.cpuUsage
    icon: ""
  }
}
