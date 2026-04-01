import QtQuick
import qs.config

Rectangle {
    id: root
    width: 50
    height: 50
    
    anchors.centerIn: parent
    color: "transparent" 

    property int percentage: 0
    property string icon: ""
    property color backgroundColor: Colors.outline 
    property color progressColor: Colors.secondary

    Canvas {
        id: progressCanvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var centerX = width / 2;
            var centerY = height / 2;

            var lineWidth = 5; 
            var radius = (Math.min(width, height) / 2) - (lineWidth / 2) - 10;
            
            var startAngle = -Math.PI / 2; 
            var endAngle = startAngle + (2 * Math.PI * (root.percentage / 100));

            ctx.beginPath();
            ctx.strokeStyle = Qt.rgba(root.backgroundColor.r, root.backgroundColor.g, root.backgroundColor.b, 0.2);
            ctx.lineWidth = lineWidth;
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
            ctx.stroke();

            ctx.beginPath();
            ctx.strokeStyle = root.progressColor; 
            ctx.lineWidth = lineWidth;
            ctx.lineCap = "round";
            ctx.arc(centerX, centerY, radius, startAngle, endAngle);
            ctx.stroke();
        }

        Connections {
            target: root
            function onPercentageChanged() { 
                progressCanvas.requestPaint(); 
            }
        }
    }
    StyledText {
      text: root.icon
      font.pixelSize: 10
      anchors.centerIn: parent
    }
}
