import QtQuick
import QtQuick.Layouts
import qs.config
import "../componenets"


ColumnLayout {
  spacing: 16
  Text {
    text: "General"
    font.pixelSize: 32
    font.bold: true 
    color: Colors.inverse_surface
  }


  Slider {
    label: "margins"
    from: -16
    to: 600
    value: Config.bar.margins
    onValueChanged: Config.bar.margins =  value
  }
  Slider {
    label: "radius"
    from: 0
    to: 16
    value: Config.bar.radius
    onValueChanged: Config.bar.radius =  value
  }
  Switch {
    label:"floating"
    checked: Config.bar.floating
    onCheckedChanged: Config.bar.floating = checked
  }


}
