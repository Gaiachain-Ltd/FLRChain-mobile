import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width

    property alias button: btn
    property string deadline: ""
    property string description: ""
    property string startDate: ""
    property string endDate: ""
    property int status: Project.InvestmentUnknown
    property int assignmentStatus: Project.Undefined
    property bool investmentOngoing: status === Project.InvestmentOngoing
    property bool investmentFinished: status === Project.InvestmentFinished

    Custom.ShadowedRectangle {
        height: contentRect.height
        width: parent.width

        Rectangle{
            id: contentRect
            width: parent.width
            height: childrenRect.height
            color: Style.bgColor
            radius: Style.rectangleRadius

            Custom.StatusLabel{
                status: assignmentStatus
                anchors {
                    bottom: parent.top
                    bottomMargin: -Style.tinyMargin
                    left: parent.left
                    leftMargin: Style.baseMargin
                }
            }

            ColumnLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Style.baseMargin
                    rightMargin: Style.baseMargin
                }
                spacing: Style.tinyMargin

                Label{
                    Layout.topMargin: Style.bigMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Project deadline")
                    color: Style.accentColor
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
                        text: deadline
                        color: Style.mediumLabelColor
                    }
                }

                Label {
                    Layout.topMargin: Style.tinyMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Investment time")
                    color: Style.accentColor
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
                        text: startDate + " - " + endDate
                        color: Style.mediumLabelColor
                    }
                }

                Label{
                    Layout.topMargin: Style.tinyMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Project status")
                    color: Style.accentColor
                }

                RowLayout {
                    spacing: Style.microMargin
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.iconSize
                    Image {
                        source: investmentOngoing ? "qrc:/img/icon-ongoing.svg" : investmentFinished ? "qrc:/img/icon-finished.svg" : "qrc:/img/icon-suspended.svg"
                        asynchronous: true
                        Layout.preferredWidth: Style.iconSize
                        Layout.preferredHeight: Style.iconSize
                        fillMode: Image.PreserveAspectFit
                        sourceSize: Qt.size(width, height)
                    }

                    Label {
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: investmentOngoing ? qsTr("Ongoing") : investmentFinished ? qsTr("Finished") : qsTr("Suspended")
                        color: Style.mediumLabelColor
                    }
                }

                Label {
                    Layout.topMargin: Style.tinyMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Description")
                    color: Style.accentColor
                }

                Text {
                    text: description
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Style.mediumLabelColor
                }

                Label{
                    Layout.topMargin: Style.tinyMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Photo")
                    color: Style.accentColor
                }

                Image {
                    source: ""
                    Layout.fillWidth: true
                    Layout.preferredHeight: 139
                }

                Custom.Button{
                    id: btn
                    Layout.topMargin: Style.tinyMargin
                    Layout.bottomMargin: Style.baseMargin
                    Layout.fillWidth: true
                    text: qsTr("Join")
                    visible: !investmentFinished && assignmentStatus === Project.Undefined
                }
            }
        }
    }
}
