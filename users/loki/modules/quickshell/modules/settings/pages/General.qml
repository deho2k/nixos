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


  Dropdown {
    Layout.fillWidth: true
    label: "Theme"
    options: ["wave", "center", "outer","random","wipe"]
    currentIndex: options.indexOf(Config.theme.transition)
    onCurrentIndexChanged: Config.theme.transition = options[currentIndex]
  }
  Dropdown {
    Layout.fillWidth: true
    label: "theme"
    options: ["wallpaper", "monochrome","red", "purple","aqua"]
    currentIndex: options.indexOf(Config.theme.theme)
    onCurrentIndexChanged: {
      Config.theme.theme = options[currentIndex]
      Config.setWallpaper()
    }
  }
  Slider {
    label: "transition duration"
    from: 0
    to: 5
    value: Config.theme.transitionDuration
    onValueChanged: Config.theme.transitionDuration =  value
  }
}
