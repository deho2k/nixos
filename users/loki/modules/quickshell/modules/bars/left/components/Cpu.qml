import qs.widgets
import qs.config

Background {
  CircleProgressWrapper {
    percentage: Config.cpuUsage
    icon: ""
  }
}
