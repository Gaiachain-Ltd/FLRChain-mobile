import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {
    property var taskItem
    property string projectName: ""
    property bool buttonVisible: false

    height: childrenRect.height
    width: parent.width
    Custom.ShadowedRectangle {
        height: childrenRect.height
        width: parent.width

        Rectangle{
            id: contentRect
            width: parent.width
            height: childrenRect.height
            color: Style.bgColor
            radius: 10

            ColumnLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Style.baseMargin
                    rightMargin: Style.baseMargin
                }
                spacing: 8

                Label{
                    Layout.topMargin: Style.baseMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Action")
                    color: Style.accentColor
                }

                Label{
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: taskItem.action
                    color: Style.mediumLabelColor
                }

                Label {
                    Layout.topMargin: Style.tinyMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Rewards per unit")
                    color: Style.accentColor
                }

                Label{
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("%1 USDC").arg(taskItem.reward)
                    color: Style.mediumLabelColor
                }

                Custom.Button{
                    Layout.topMargin: Style.tinyMargin
                    Layout.fillWidth: true
                    text: qsTr("Earn reward")
                    visible: buttonVisible
                    onClicked: {
                        pageManager.enterWorkScreen(taskItem.projectId, taskItem.taskId, projectName, taskItem.action)
                    }
                }

                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.tinyMargin
                }
            }
        }
    }
}
