import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: popup

    anchors.centerIn: parent
    bottomMargin: 0
    implicitWidth: parent.width - 32
    modal: true
    dim: true
    focus: true

    property string title: ""

    background: Rectangle {
        color: "white"
        radius: 10
    }

    contentItem: ColumnLayout {
        width: parent.width
        height: parent.height
        spacing: 20

        Image {
            source: ""
            Layout.topMargin: 30
            Layout.preferredWidth: 72
            Layout.preferredHeight: 72
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Qt.size(72,72)
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 22
            color: "#253F50"
            text: title
        }
    }
}
