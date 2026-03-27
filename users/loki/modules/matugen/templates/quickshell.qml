pragma Singleton
import Quickshell
import QtQuick

Singleton {
    <* for name, value in colors *>
    property color {{name}}: "{{value.default.hex}}"
    <* endfor *>
    property string image: "{{image}}"
    readonly property color borderColor: inverse_surface
}
