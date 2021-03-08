import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

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
            color: "white"
            radius: 10

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 10

                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 20
                }

                Rectangle{
                    Layout.preferredHeight: 21
                    Layout.preferredWidth: 54
                    color: "#23BC3D"
                    radius: 4

                    Label{
                        anchors.centerIn: parent
                        font.pixelSize: 12
                        font.weight: Font.DemiBold
                        text: "Joined"
                        color: "#FFFFFF"
                    }
                }

                Label{
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                    text: "Praesentium Aliquam Et"
                    color: "#253F50"
                }

                RowLayout {
                    spacing: 5
                    Image {
                        source: ""
                        asynchronous: true
                        width: 18
                        height: 18
                        fillMode: Image.PreserveAspectFit
                    }

                    Label{
                        font.pixelSize: 12
                        font.weight: Font.DemiBold
                        text: "August 24, 2020"
                        color: "#72809D"
                    }

                    Image {
                        source: ""
                        asynchronous: true
                        width: 18
                        height: 18
                        fillMode: Image.PreserveAspectFit
                    }

                    Label{
                        font.pixelSize: 12
                        font.weight: Font.DemiBold
                        text: "Ongoing"
                        color: "#23BC3D"
                    }

                    Item{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 18
                    }
                }

                Label{
                    Layout.topMargin: 20
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Description"
                    color: "#72809D"
                }

                Text {
                    text: qsTr("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ma jdsds dlsldasldajdjsajldsldasljdsaljjldasjl")
                    Layout.fillWidth: true
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: "#72809D"
                    maximumLineCount: 3
                    elide: Text.ElideRight
                }

                Custom.Button{
                    Layout.topMargin: 10
                    Layout.bottomMargin: 20
                    Layout.fillWidth: true
                    Layout.preferredHeight: 42
                    text: qsTr("Earn reward")
                    onClicked: stack.pushPage("qrc:/ProjectDetailsScreen.qml");
                }
            }
        }
    }
}
