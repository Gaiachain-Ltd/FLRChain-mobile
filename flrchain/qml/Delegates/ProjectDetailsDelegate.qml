import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width

    property alias button: btn
    property string deadline: ""
    property string description: ""
    property string startDate: ""
    property string endDate: ""
    property string status: ""
    property bool joined: false

    Custom.ShadowedRectangle {
        height: childrenRect.height
        width: parent.width

        Rectangle{
            id: contentRect
            width: parent.width
            height: childrenRect.height
            color: Style.bgColor
            radius: 10

            Rectangle{
                anchors.bottom: parent.top
                anchors.bottomMargin: -Style.tinyMargin
                anchors.left: parent.left
                anchors.leftMargin: Style.baseMargin
                height: 20
                width: 54
                color: Style.accentColor
                radius: 4
                visible: joined

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: Style.fontTiny
                    font.weight: Font.DemiBold
                    text: "Joined"
                    color: Style.bgColor
                }
            }

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Style.baseMargin
                anchors.rightMargin: Style.baseMargin
                spacing: 10

                Label{
                    Layout.topMargin: Style.bigMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Project deadline"
                    color: Style.accentColor
                }

                Row {
                    spacing: 5
                    Image {
                        source: "qrc:/img/icon-calendar.svg"
                        asynchronous: true
                        width: Style.iconSize
                        height: width
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
                    text: "Investment time"
                    color: Style.accentColor
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
                        text: startDate + " - " + endDate
                        color: Style.mediumLabelColor
                    }
                }

                Label{
                    Layout.topMargin: Style.tinyMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Project status"
                    color: Style.accentColor
                }

                Row {
                    spacing: 5
                    Image {
                        source: status === "Ongoing" ? "qrc:/img/icon-ongoing.svg" : status === "Suspended" ? "qrc:/img/icon-suspended.svg" : "qrc:/img/icon-finished.svg"
                        asynchronous: true
                        width: Style.iconSize
                        height: Style.iconSize
                        fillMode: Image.PreserveAspectFit
                        sourceSize: Qt.size(width, height)
                    }

                    Label {
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: status
                        color: Style.mediumLabelColor
                    }
                }

                Label {
                    Layout.topMargin: Style.tinyMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Description"
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
                    text: "Photo"
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
                    visible: status === "Ongoing" && !joined
                }
            }
        }
    }
}
