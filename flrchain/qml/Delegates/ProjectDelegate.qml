import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width

    property var projectItem
    property int projectIndex

    Custom.ShadowedRectangle {
        width: parent.width
        height: childrenRect.height

        Rectangle{
            id: contentRect
            width: parent.width
            height: childrenRect.height
            color: Style.bgColor
            radius: 10

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Style.baseMargin
                anchors.rightMargin: Style.baseMargin
                spacing: 10

                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10
                }

                Rectangle{
                    Layout.preferredHeight: 21
                    Layout.preferredWidth: 54
                    color: Style.accentColor
                    radius: 4
                    visible: projectItem.joined

                    Label{
                        anchors.centerIn: parent
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: "Joined"
                        color: Style.bgColor
                    }
                }

                Label{
                    font.pixelSize: Style.fontUltra
                    font.weight: Font.DemiBold
                    text: projectItem.name
                    color: Style.darkLabelColor
                }

                RowLayout {
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
                        text: projectItem.deadline
                        color: Style.mediumLabelColor
                    }

                    Image {
                        Layout.leftMargin: 5
                        source: projectItem.status === "Ongoing" ? "qrc:/img/icon-ongoing.svg" : projectItem.status === "Suspended" ? "qrc:/img/icon-suspended.svg" : "qrc:/img/icon-finished.svg"
                        asynchronous: true
                        width: Style.iconSize
                        height: Style.iconSize
                        fillMode: Image.PreserveAspectFit
                        sourceSize: Qt.size(width, height)
                    }

                    Label{
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: projectItem.status
                        color: Style.accentColor
                    }

                    Item{
                        Layout.fillWidth: true
                        Layout.preferredHeight: Style.iconSize
                    }
                }

                Label{
                    Layout.topMargin: Style.baseMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Description"
                    color: Style.mediumLabelColor
                }

                Text {
                    text: projectItem.description
                    Layout.fillWidth: true
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Style.mediumLabelColor
                    maximumLineCount: 3
                    elide: Text.ElideRight
                }

                Custom.Button{
                    Layout.topMargin: Style.smallMargin
                    Layout.bottomMargin: Style.baseMargin
                    Layout.fillWidth: true
                    text: projectItem.status === "Ongoing" ? projectItem.joined ? qsTr("Earn reward") : qsTr("Join") : qsTr("Details")
                    bgColor: projectItem.status === "Ongoing" ? Style.accentColor : Style.buttonSecColor
                    onClicked:{
                        pageManager.enterProjectDetailsScreen(projectIndex)
                    }
                }
            }
        }
    }
}
