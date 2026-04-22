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
    from: 0
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
  Switch {
    label:"stripes"
    checked: Config.bar.stripes
    onCheckedChanged: Config.bar.stripes = checked
  }
  Switch {
    label:"gradient"
    checked: Config.bar.gradient
    onCheckedChanged: Config.bar.gradient = checked
  }
  Slider {
    label: "gradient opacity"
    from: 0
    to: 100
    value: Config.bar.gradientOpacity
    onValueChanged: Config.bar.gradientOpacity =  value
  }
  Switch {
    label:"icons"
    checked: Config.bar.workspaceIcons
    onCheckedChanged: Config.bar.workspaceIcons = checked
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
}
