import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width

    property bool joined: assignmentStatus === Project.Joined
    property bool undefinedStatus: assignmentStatus === Project.Undefined
    property bool investmentOngoing: status === Project.InvestmentOngoing
    property bool investmentFinished: status === Project.InvestmentFinished

    Custom.ShadowedRectangle {
        width: parent.width
        height: childrenRect.height

        Rectangle{
            id: contentRect
            width: parent.width
            height: childrenRect.height
            color: Style.bgColor
            radius: Style.rectangleRadius

            ColumnLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Style.baseMargin
                    rightMargin: Style.baseMargin
                }
                spacing: Style.tinyMargin

                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.tinyMargin
                }

                Custom.StatusLabel{
                    status: assignmentStatus
                }

                Label{
                    font.pixelSize: Style.fontUltra
                    font.weight: Font.DemiBold
                    text: name
                    color: Style.darkLabelColor
                }

                RowLayout {
                    spacing: Style.microMargin
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
                        text: deadline
                        color: Style.mediumLabelColor
                    }

                    Image {
                        Layout.preferredWidth: Style.iconSize
                        Layout.preferredHeight: Style.iconSize
                        Layout.leftMargin: Style.microMargin
                        source: investmentOngoing ? "qrc:/img/icon-ongoing.svg" : investmentFinished ? "qrc:/img/icon-finished.svg" : "qrc:/img/icon-suspended.svg"
                        asynchronous: true

                        fillMode: Image.PreserveAspectFit
                        sourceSize: Qt.size(width, height)
                    }

                    Label{
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: investmentOngoing ? qsTr("Ongoing") : investmentFinished ? qsTr("Finished") : qsTr("Pending")
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
                    text: qsTr("Description")
                    color: Style.mediumLabelColor
                }

                Text {
                    text: description
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
                    text: !investmentFinished ? undefinedStatus ? qsTr("Join") : joined && investmentOngoing ? qsTr("Earn reward") : qsTr("Details") : qsTr("Details")
                    bgColor: !investmentFinished && (joined || undefinedStatus) ? Style.accentColor : Style.buttonSecColor
                    onClicked:{
                        pageManager.enterProjectDetailsScreen(projectId)
                    }
                }
            }
        }
    }
}
