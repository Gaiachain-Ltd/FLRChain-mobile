import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

Button {
    id: button

    property string backgroundColor: Style.accentColor
    property string textColor: Style.darkLabelColor
    property string iconSource: ""
    property size iconSize: Qt.size(Style.iconMedium, Style.iconMedium)

    implicitWidth: Style.buttonHeight
    implicitHeight: Style.buttonHeight
    font.family: Style.appFontFamily

    background: Rectangle {
        radius: Style.baseRadius
        color: backgroundColor
    }

    contentItem: Item {
        anchors {
            fill: parent
            leftMargin: Style.baseMargin
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter
            spacing: Style.smallMargin

            Image {
                width: button.iconSize.width
                height: button.iconSize.height
                sourceSize: Qt.size(width, height)
                source: button.iconSource
                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }

            Label {
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font: button.font
                color: button.textColor
                text: button.text
            }
        }
    }
}
