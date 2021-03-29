import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Column {
    spacing: Style.baseMargin
    property var workItem
    property bool separatorVisible: true

    Rectangle {
        color: "transparent"
        height: 191
        width: parent.width
        radius: 10

        Custom.RoundedImage {
            id: img
            source: workItem.localPath
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
            radius: 4

            RowLayout{
                id: row
                spacing: 5
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
            height: 40
            width: rewardLabel.width + Style.baseMargin
            color: Style.accentColor
            radius: 4

            Label{
                id: rewardLabel
                anchors.centerIn: parent
                font.pixelSize: Style.fontBig
                font.weight: Font.Bold
                text: qsTr("%1 USDC").arg(workItem.amount)
                color: Style.bgColor
            }
        }
    }

    RowLayout {
        spacing: 5
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
            text: "August 24, 2020"
            color: Style.mediumLabelColor
        }
    }

    Rectangle{
        height: 1
        width: parent.width
        color: Style.sectionColor
        visible: separatorVisible
    }
}
