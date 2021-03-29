import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

Button {
    id: button

    property string bgColor: Style.accentColor
    property string iconSrc: ""
    property string textColor: Style.darkLabelColor
    property int imgHeight: 24
    property int imgWidth: 24

    implicitWidth: parent.width
    implicitHeight: 42

    background: Rectangle {
        anchors.fill: parent
        radius: 10
        color: bgColor
    }

    contentItem: Rectangle {
        anchors {
            fill: parent
            leftMargin: Style.baseMargin
        }
        color: Style.colorTransparent
        Row {
            anchors.verticalCenter: parent.verticalCenter
            spacing: Style.smallMargin

            Image {
                source: button.iconSrc
                asynchronous: true
                width: imgWidth
                height: imgHeight
                fillMode: Image.PreserveAspectFit
                sourceSize: Qt.size(width, height)
            }

            Text {
                text: button.text
                font.pixelSize: Style.fontMedium
                color: textColor
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
