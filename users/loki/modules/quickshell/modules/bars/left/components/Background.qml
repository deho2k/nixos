// Background.qml
import QtQuick
import QtQuick.Layouts
import qs.config
// FIX ME: when floating gets fucked
Rectangle{
  implicitWidth: parent.width
  color: Colors.background
  Layout.fillWidth: true
  radius: parent.parent.radius
  implicitHeight: childrenRect.height
}
