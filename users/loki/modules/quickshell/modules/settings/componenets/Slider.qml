import qs.config
import qs.widgets
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    
    property string label: "Slider Label"
    property real from: 0
    property real to: 100
    property real value: 50
    
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

        // Visual progress bar
        Rectangle {
            // Calculate width based on where 'value' sits between 'from' and 'to'
            width: ((root.value - root.from) / (root.to - root.from)) * parent.width
            height: parent.height
            color: Colors.primary
            radius: 3
        }

        // The Draggable Knob
        Rectangle {
            id: handle
            // Position the handle based on the value ratio
            x: (((root.value - root.from) / (root.to - root.from)) * sliderTrack.width) - (width / 2)
            y: (parent.height / 2) - (height / 2)
            width: 16; height: 16; radius: 8; color: "white"
            
            // Subtle shadow/border to make it pop
            border.color: Colors.outline; border.width: 1
        }

        MouseArea {
            anchors.fill: parent
            
            function updateValue(mouse) {
                // 1. Get the horizontal percentage (0.0 to 1.0) of the click
                let percentage = Math.max(0, Math.min(mouse.x / width, 1))
                
                // 2. Map that percentage to our [from, to] range
                let newValue = root.from + (percentage * (root.to - root.from))
                
                // 3. Update the value (rounded to nearest whole number)
                root.value = Math.round(newValue)
            }
            
            onPressed: updateValue(mouse)
            onPositionChanged: updateValue(mouse)
        }
    }

    // Displays the current value
    StyledText {
        text: Math.round(root.value) 
        font.pixelSize: 14
        Layout.minimumWidth: 30
        horizontalAlignment: Text.AlignRight
    }
}
