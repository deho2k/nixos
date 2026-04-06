import QtQuick
import qs.config
Rectangle{
  height: parent.height
  width: childrenRect.width + 15
  color: Colors.background
  radius: parent.radius
  bottomRightRadius: Config.bar.radius
  bottomLeftRadius: Config.bar.radius
}
