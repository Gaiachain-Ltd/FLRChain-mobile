import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

Popup {
    id: popup

    anchors.centerIn: parent
    bottomMargin: 0
    implicitWidth: parent.width - 32
    modal: true
    dim: true
    focus: true

    property string title: ""
    property string iconSrc: ""

    background: Rectangle {
        color: Style.bgColor
        radius: 10
    }

    contentItem: ColumnLayout {
        width: parent.width
        height: parent.height
        spacing: 20

        Image {
            source: iconSrc
            Layout.topMargin: Style.bigMargin
            Layout.preferredWidth: 72
            Layout.preferredHeight: 72
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Qt.size(72,72)
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.fontUltra
            color: Style.darkLabelColor
            text: title
        }
    }
}
