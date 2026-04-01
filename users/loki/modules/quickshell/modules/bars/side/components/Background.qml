// Background.qml
import QtQuick
import qs.config
Rectangle{
  implicitWidth: parent.width
  implicitHeight: childrenRect.height + 15
  color: Colors.background
  radius: parent.parent.radius
}
