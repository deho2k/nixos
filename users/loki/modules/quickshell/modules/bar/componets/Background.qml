import QtQuick
import qs.config
Rectangle{
  height: parent.height
  color: Colors.background
  anchors.margins: 12
  radius: parent.radius
  bottomRightRadius: Config.bar.radius
  bottomLeftRadius: Config.bar.radius
}
