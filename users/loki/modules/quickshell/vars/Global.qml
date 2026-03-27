pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    property int fontSize: 20
    property string matugenThemes: "~/.config/matugen/themes/"

    property string leader: ":"
    property var batteryPerc: 0
    property int cpuUsage: 0
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0
    property string panelSource: "player"

    property bool settingsVisible: false
    property bool bigPanelVisible: false
    property bool osdVolumeVisible: false
    property bool osdPlayerVisible: false
    property real volume: 0.5

    property string clockHours: Qt.formatDateTime(new Date(), "HH")
    property string clockMinutes: Qt.formatDateTime(new Date(), "mm")

    property string uptime
    property string osAge

    property string execString: ""
    property string tempStringOutput: ""

    function executeString(command) { 
        execString = command; 
        execProcess.running = true; 
        return tempStringOutput
    }
    Process {
        id: execProcess
        command: ["sh", "-c", execString]
        stdout: SplitParser {
            onRead: data => {
                if (!data || !data.trim()) return
                tempStringOutput = ""
                tempStringOutput += data
            }
        }
    }

    Process {
        id: uptimeProcess
        running: true
        command: ["sh", "-c", "echo $(( $(cat /proc/uptime | cut -d'.' -f1) / 60 ))"]
        stdout: SplitParser {
            onRead: data => { if (data) uptime = data.trim() }
        }
    }

    Process {
        id: osAgeProcess
        running: true
        command: ["sh", "-c", "echo $(( ($(date +%s) - $(stat -c %W /)) / 86400 )) days"]
        stdout: SplitParser {
            onRead: data => { if (data) osAge = data.trim() }
        }
    }
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var user = parseInt(parts[1]) || 0
                var nice = parseInt(parts[2]) || 0
                var system = parseInt(parts[3]) || 0
                var idle = parseInt(parts[4]) || 0
                var iowait = parseInt(parts[5]) || 0
                var irq = parseInt(parts[6]) || 0
                var softirq = parseInt(parts[7]) || 0

                var total = user + nice + system + idle + iowait + irq + softirq
                var idleTime = idle + iowait

                if (lastCpuTotal > 0) {
                    var totalDiff = total - lastCpuTotal
                    var idleDiff = idleTime - lastCpuIdle
                    if (totalDiff > 0) {
                        cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff)
                    }
                }
                lastCpuTotal = total
                lastCpuIdle = idleTime
            }
        }
        Component.onCompleted: running = true
    }
    // Memory usage
    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                memUsage = Math.round(100 * used / total)
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
            osAgeProcess.running = true
            uptimeProcess.running = true
            clockHours = Qt.formatDateTime(new Date(), "HH")
            clockMinutes = Qt.formatDateTime(new Date(), "mm")
        }
    }
}
