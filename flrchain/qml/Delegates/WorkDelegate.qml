import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

Column {
    spacing: 20

    Rectangle {
        color: Style.mediumLabelColor
        height: 191
        width: parent.width
        radius: 10
        Rectangle{
            anchors.bottom: parent.top
            anchors.bottomMargin: -Style.smallMargin
            anchors.left: parent.left
            anchors.leftMargin: Style.baseMargin
            height: 20
            width: 54
            color: Style.accentColor
            radius: 4

            Label{
                anchors.centerIn: parent
                font.pixelSize: Style.fontTiny
                font.weight: Font.DemiBold
                text: "Accepted"
                color: Style.bgColor
            }
        }

        Rectangle{
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            height: 40
            width: 74
            color: Style.accentColor
            radius: 4

            Label{
                anchors.centerIn: parent
                font.pixelSize: Style.fontBig
                font.weight: Font.Bold
                text: "10 USDC"
                color: Style.bgColor
            }
        }
    }

    Row {
        spacing: 5
        Image {
            source: ""
            asynchronous: true
            width: Style.iconSize
            height: Style.iconSize
            fillMode: Image.PreserveAspectFit
        }

        Label{
            font.pixelSize: Style.fontTiny
            font.weight: Font.DemiBold
            text: "August 24, 2020"
            color: Style.mediumLabelColor
        }
    }

    Rectangle{
        height: 1
        width: parent.width
        color: Style.sectionColor
    }
}
