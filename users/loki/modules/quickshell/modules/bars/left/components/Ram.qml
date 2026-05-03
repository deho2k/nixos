import QtQuick
import qs.config
import qs.widgets

Background {
  CircleProgressWrapper {
    percentage: Config.memUsage
    icon: ""
  }
}
