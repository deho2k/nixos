// Background.qml
import QtQuick
import QtQuick.Layouts
import qs.config
// FIX ME: when floating gets fucked
Rectangle{
  implicitWidth: parent.width
  color: Config.bar.floating? Colors.background: "transparent"
  Layout.fillWidth: true
  radius: parent.parent.radius
  implicitHeight: childrenRect.height
  Layout.alignment: Qt.AlignHCenter
  bottomRightRadius: Config.bar.margins <= 0? Config.bar.radius :undefined 
  topRightRadius: Config.bar.margins <= 0? Config.bar.radius :undefined 
}
