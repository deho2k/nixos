import qs.config
import qs.widgets
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    property string label: "Slider Label"
    property int from: 0
    property int to: 100
    property int value: 50
    property int step: 1 // Default step is 1
    spacing: 15

    StyledText { 
        text: root.label
        font.pixelSize: 22
        Layout.preferredWidth: 250
    }

    Rectangle {
        id: sliderTrack
        height: 6
        Layout.fillWidth: true
        color: Colors.outline
        radius: 3

        // Progress bar
        Rectangle {
            width: ((root.value - root.from) / (root.to - root.from)) * parent.width
            height: parent.height
            color: Colors.primary
            radius: 3
        }

        // Handle
        Rectangle {
            id: handle
            // Position uses the stepped value to stay visually aligned
            x: (((root.value - root.from) / (root.to - root.from)) * sliderTrack.width) - (width / 2)
            y: (parent.height / 2) - (height / 2)
            width: 16; height: 16; radius: 8; color: "white"
            border.color: Colors.outline; border.width: 1
        }

        MouseArea {
            anchors.fill: parent
            function updateValue(mouse) {
                let percentage = Math.max(0, Math.min(mouse.x / width, 1))
                let rawValue = root.from + (percentage * (root.to - root.from))
                
                // Step Logic: 
                // 1. Find how many steps fit into the current distance from "from"
                // 2. Round that number to the nearest whole step
                // 3. Multiply back by step and add to "from"
                let steppedValue = root.from + Math.round((rawValue - root.from) / root.step) * root.step
                
                // Final bounds check to ensure we don't exceed 'to' or 'from' due to rounding
                root.value = Math.max(root.from, Math.min(root.to, steppedValue))
            }
            onPressed: (mouse) => updateValue(mouse)
            onPositionChanged: (mouse) => updateValue(mouse)
        }
    }

    StyledText {
        text: root.value 
        font.pixelSize: 14
        Layout.minimumWidth: 30
        horizontalAlignment: Text.AlignRight
    }
}
