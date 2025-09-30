// Main.qml
import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 1400; height: 900
    visible: true
    title: "GLFW inside QML"

    required property var foreignWindow

    Rectangle { anchors.fill: parent; color: "#1e1e1e" }

    WindowContainer {
        id: host
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.6, 1280)
        height: Math.min(parent.height * 0.6, 720)
        window: root.foreignWindow
        clip: true
    }

    Window {
        id: overlay
        transientParent: root
        flags: Qt.FramelessWindowHint
             | Qt.Tool
             | Qt.WindowStaysOnTopHint
             | Qt.WindowTransparentForInput   // lets mouse/keys pass to GLFW
        color: "transparent"
        visible: root.visible
        screen: root.screen

        x: root.x + host.x
        y: root.y + host.y
        width: host.width
        height: host.height

        Rectangle {
            anchors.fill: parent
            anchors.margins: 24
            radius: 12
            color: "#8000FF00"// translucent green
            border.width: 4
            border.color: "white"

            Label {
                anchors.centerIn: parent
                text: `Underneath this text is Veloxr output, test mac!`
                color: "red"
                font.bold: true
            }
        }

        Label {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 8
            text: `${width}×${height} overlay`
            color: "red"
            font.bold: true
        }
    }
}
