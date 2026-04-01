import QtQuick
import qs.config
import qs.widgets

Background {
  CircleProgress {
    percentage: Config.memUsage
    icon: ""
  }
}
