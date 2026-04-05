import QtQuick
import qs.config

Rectangle {
    id: root
    width: 50
    height: 50
    
    color: "transparent" 

    property int percentage: 0
    property int lineWidth: 6
    property int margin: 7
    property string icon: ""
    property color backgroundColor: Colors.outline 
    property color progressColor: Colors.secondary

    onPercentageChanged: progressCanvas.requestPaint()
    Canvas {
        id: progressCanvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var centerX = width / 2;
            var centerY = height / 2;

            var lineWidth = root.lineWidth;
            var radius = (Math.min(width, height) / 2) - (lineWidth / 2) - root.margin
            
            var startAngle = -Math.PI / 2; 
            var endAngle = startAngle + (2 * Math.PI * (root.percentage / 100));

            ctx.beginPath();
            ctx.strokeStyle = Qt.rgba(root.backgroundColor.r, root.backgroundColor.g, root.backgroundColor.b, 0.2);
            ctx.lineWidth = lineWidth;
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
            ctx.stroke();

            ctx.beginPath();
            ctx.strokeStyle = root.progressColor; 
            ctx.lineWidth = lineWidth - 1;
            ctx.lineCap = "round";
            ctx.arc(centerX, centerY, radius, startAngle, endAngle);
            ctx.stroke();
        }

    }
    StyledText {
      text: root.icon
      font.pixelSize: 16
      anchors.centerIn: parent
    }
}
