import QtQuick
import QtQuick.Layouts
import qs.config
import "../componenents"


ColumnLayout {
  spacing: 16
  Text {
    text: "Bar"
    font.pixelSize: 32
    font.bold: true 
    color: Colors.inverse_surface
  }


  Slider {
    label: "margins"
    from: -30
    to: 400
    step: 10
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
  Dropdown {
    Layout.fillWidth: true
    label: "theme"
    options: ["top", "left"]
    currentIndex: options.indexOf(Config.bar.pos)
    onCurrentIndexChanged: {
      Config.bar.pos = options[currentIndex]
    }
  }
  Slider {
    label: "arc size"
    from: 0
    to: 40
    step: 2
    value: Config.bar.arc.size
    onValueChanged: Config.bar.arc.size =  value
  }
}
