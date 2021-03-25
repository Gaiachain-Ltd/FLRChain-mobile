import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width

    property var projectItem
    property int projectIndex
    property bool joined: projectItem.assignmentStatus === Project.Joined
    property bool undefinedStatus: projectItem.assignmentStatus === Project.Undefined
    property bool investmentOngoing: projectItem.status === Project.InvestmentOngoing
    property bool investmentFinished: projectItem.status === Project.InvestmentFinished

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
                spacing: Style.tinyMargin

                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10
                }

                Custom.StatusLabel{
                    status: projectItem.assignmentStatus
                }

                Label{
                    font.pixelSize: Style.fontUltra
                    font.weight: Font.DemiBold
                    text: projectItem.name
                    color: Style.darkLabelColor
                }

                RowLayout {
                    spacing: 5
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.iconSize

                    Image {
                        Layout.preferredWidth: Style.iconSize
                        Layout.preferredHeight: Style.iconSize
                        source: "qrc:/img/icon-calendar.svg"
                        asynchronous: true
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
                        Layout.preferredWidth: Style.iconSize
                        Layout.preferredHeight: Style.iconSize
                        Layout.leftMargin: 5
                        source: investmentOngoing ? "qrc:/img/icon-ongoing.svg" : investmentFinished ? "qrc:/img/icon-finished.svg" : "qrc:/img/icon-suspended.svg"
                        asynchronous: true

                        fillMode: Image.PreserveAspectFit
                        sourceSize: Qt.size(width, height)
                    }

                    Label{
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: investmentOngoing ? qsTr("Ongoing") : investmentFinished ? qsTr("Finished") : qsTr("Suspended")
                        color: investmentOngoing ? Style.accentColor : investmentFinished ? Style.errorColor : Style.yellowLabelColor
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
                    Layout.topMargin: Style.tinyMargin
                    Layout.bottomMargin: Style.baseMargin
                    Layout.fillWidth: true
                    text: investmentOngoing ? undefinedStatus ? qsTr("Join") : joined ? qsTr("Earn reward") : qsTr("Details") : qsTr("Details")
                    bgColor: investmentOngoing && (joined || undefinedStatus) ? Style.accentColor : Style.buttonSecColor
                    onClicked:{
                         pageManager.enterProjectDetailsScreen(projectItem.id)
                    }
                }
            }
        }
    }
}
