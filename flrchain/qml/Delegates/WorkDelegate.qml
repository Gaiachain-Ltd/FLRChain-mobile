import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import QtGraphicalEffects 1.15

Column {
    spacing: 20
    property string localPhotoPath: ""

    Rectangle {
        color: "transparent"
        height: 191
        width: parent.width
        radius: 10

        Image {
            id: img
            source: localPhotoPath
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: img.width
                    height: img.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: img.width
                        height: img.height
                        radius: 10
                    }
                }
            }
        }

        Rectangle{
            anchors.bottom: parent.top
            anchors.bottomMargin: -Style.tinyMargin
            anchors.left: parent.left
            anchors.leftMargin: Style.baseMargin
            height: 20
            width: row.width + Style.baseMargin
            color: Style.accentColor
            radius: 4

            RowLayout{
                id: row
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    source: "qrc:/img/icon-accepted.svg"
                    asynchronous: true
                    width: 13
                    height: 10
                    fillMode: Image.PreserveAspectFit
                    sourceSize: Qt.size(width, height)
                    Layout.alignment: Qt.AlignVCenter
                }

                Label{
                    font.pixelSize: Style.fontTiny
                    font.weight: Font.DemiBold
                    text: "Accepted"
                    color: Style.bgColor
                }
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
            source: "qrc:/img/icon-calendar.svg"
            asynchronous: true
            width: Style.iconSize
            height: Style.iconSize
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(width, height)
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
