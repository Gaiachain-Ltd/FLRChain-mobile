import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width

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
                    text: "Praesentium Aliquam Et"
                    color: Style.darkLabelColor
                }

                RowLayout {
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
                        text: "August 24, 2020"
                        color: Style.mediumLabelColor
                    }

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
                        text: "Ongoing"
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
                    text: qsTr("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ma jdsds dlsldasldajdjsajldsldasljdsaljjldasjl")
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
                    text: qsTr("Earn reward")
                    onClicked: stack.pushPage("qrc:/ProjectDetailsScreen.qml");
                }
            }
        }
    }
}
