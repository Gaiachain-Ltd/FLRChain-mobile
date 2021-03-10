import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width

    property alias button: btn

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
                anchors.bottomMargin: -Style.smallMargin
                anchors.left: parent.left
                anchors.leftMargin: Style.baseMargin
                height: 20
                width: 54
                color: Style.accentColor
                radius: 4
                visible: true

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
                        source: ""
                        asynchronous: true
                        width: Style.iconSize
                        height: width
                        fillMode: Image.PreserveAspectFit
                    }
                    Label{
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: "August 24, 2020"
                        color: Style.mediumLabelColor
                    }
                }

                Label {
                    Layout.topMargin: Style.smallMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Investment time"
                    color: Style.accentColor
                }

                Row {
                    spacing: 5
                    Image {
                        source: ""
                        asynchronous: true
                        width: Style.iconSize
                        height: Style.iconSize
                        fillMode: Image.PreserveAspectFit
                    }

                    Label{
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: "May 02, 2020 - May 25, 2020"
                        color: Style.mediumLabelColor
                    }
                }

                Label{
                    Layout.topMargin: Style.smallMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Project status"
                    color: Style.accentColor
                }

                Row {
                    spacing: 5
                    Image {
                        source: ""
                        asynchronous: true
                        width: Style.iconSize
                        height: Style.iconSize
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        text: "Ongoing"
                        color: Style.mediumLabelColor
                    }
                }

                Label {
                    Layout.topMargin: Style.smallMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Description"
                    color: Style.accentColor
                }

                Text {
                    text: qsTr("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore")
                    Layout.fillWidth: true
                    Layout.preferredHeight: 66
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Style.mediumLabelColor
                }

                Label{
                    Layout.topMargin: Style.smallMargin
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
                    Layout.topMargin: Style.smallMargin
                    Layout.bottomMargin: Style.baseMargin
                    Layout.fillWidth: true
                    text: qsTr("Join")
                }
            }
        }
    }
}
