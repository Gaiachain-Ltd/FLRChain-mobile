import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: button

    property string bgColor: "#23BC3D"
    property string iconSrc: ""
    property string textColor: "#253F50"

    background: Rectangle {
        anchors.fill: parent
        radius: 10
        color: bgColor
    }

    contentItem: Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 20
        color: "transparent"
        Row {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            Image {
                source: button.iconSrc
                asynchronous: true
                width: 24
                height: 24
                fillMode: Image.PreserveAspectFit
            }

            Text {
                text: button.text
                font.pixelSize: 15
                color: textColor
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}