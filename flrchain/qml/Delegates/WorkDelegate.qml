import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    spacing: 20

    Rectangle {
        color: "#72809D"
        height: 191
        width: parent.width
        radius: 10
        Rectangle{
            anchors.bottom: parent.top
            anchors.bottomMargin: -10
            anchors.left: parent.left
            anchors.leftMargin: 20
            height: 20
            width: 54
            color: "#23BC3D"
            radius: 4

            Label{
                anchors.centerIn: parent
                font.pixelSize: 12
                font.weight: Font.DemiBold
                text: "Accepted"
                color: "#FFFFFF"
            }
        }

        Rectangle{
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            height: 40
            width: 74
            color: "#23BC3D"
            radius: 4

            Label{
                anchors.centerIn: parent
                font.pixelSize: 17
                font.weight: Font.Bold
                text: "10 USDC"
                color: "#FFFFFF"
            }
        }
    }

    Row {
        spacing: 5
        Image {
            source: ""
            asynchronous: true
            width: 18
            height: 18
            fillMode: Image.PreserveAspectFit
        }

        Label{
            font.pixelSize: 12
            font.weight: Font.DemiBold
            text: "August 24, 2020"
            color: "#72809D"
        }
    }

    Rectangle{
        height: 2
        width: parent.width
        color: "#E2E9F0"
    }
}
