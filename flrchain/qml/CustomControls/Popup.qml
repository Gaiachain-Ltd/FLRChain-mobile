import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

Controls.Popup {
    id: popup

    anchors.centerIn: parent
    bottomMargin: 0
    implicitWidth: parent.width - (2 * Style.smallMargin)
    modal: true
    dim: true
    focus: true

    property string title: ""
    property string iconSrc: ""

    background: Rectangle {
        color: Style.bgColor
        radius: Style.rectangleRadius
    }

    contentItem: ColumnLayout {
        width: parent.width
        height: parent.height
        spacing: Style.baseMargin

        Image {
            source: iconSrc
            Layout.topMargin: Style.bigMargin
            Layout.preferredWidth: Style.popupImgHeight
            Layout.preferredHeight: Style.popupImgHeight
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Qt.size(Style.popupImgHeight, Style.popupImgHeight)
        }

        Controls.Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.fontUltra
            color: Style.darkLabelColor
            text: title
        }
    }
}
