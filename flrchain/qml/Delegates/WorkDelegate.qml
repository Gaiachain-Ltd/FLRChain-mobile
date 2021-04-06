import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Column {
    spacing: Style.baseMargin
    property bool separatorVisible: true

    Rectangle {
        color: "transparent"
        height: 191
        width: parent.width
        radius: Style.rectangleRadius

        Custom.RoundedImage {
            id: img
            source: localPath
            anchors.fill: parent
        }

        Rectangle{
            anchors {
                bottom: parent.top
                bottomMargin: -Style.tinyMargin
                left: parent.left
                leftMargin: Style.baseMargin
            }
            height: 20
            width: row.width + Style.baseMargin
            color: Style.accentColor
            radius: Style.labelRadius

            RowLayout{
                id: row
                spacing: Style.microMargin
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
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
                    text: qsTr("Accepted")
                    color: Style.bgColor
                }
            }
        }

        Rectangle{
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            height: Style.iconButtonHeight
            width: rewardLabel.width + Style.baseMargin
            color: Style.accentColor
            radius: Style.labelRadius

            Label{
                id: rewardLabel
                anchors.centerIn: parent
                font.pixelSize: Style.fontBig
                font.weight: Font.Bold
                text: qsTr("%1 USDC").arg(amount)
                color: Style.bgColor
            }
        }
    }

    RowLayout {
        spacing: Style.microMargin
        Layout.fillWidth: true
        Layout.preferredHeight: Style.iconSize
        Image {
            source: "qrc:/img/icon-calendar.svg"
            asynchronous: true
            Layout.preferredWidth: Style.iconSize
            Layout.preferredHeight: Style.iconSize
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(width, height)
        }

        Label{
            font.pixelSize: Style.fontTiny
            font.weight: Font.DemiBold
            text: date
            color: Style.mediumLabelColor
        }
    }

    Rectangle{
        height: Style.borderWidth
        width: parent.width
        color: Style.sectionColor
        visible: separatorVisible
    }
}
