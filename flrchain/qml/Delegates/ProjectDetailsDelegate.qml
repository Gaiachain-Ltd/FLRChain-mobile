import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width
    Custom.ShadowedRectangle {
        height: childrenRect.height
        width: parent.width

        Rectangle{
            id: contentRect
            width: parent.width
            height: childrenRect.height
            color: "white"
            radius: 10

            Rectangle{
                anchors.bottom: parent.top
                anchors.bottomMargin: -10
                anchors.left: parent.left
                anchors.leftMargin: 20
                height: 20
                width: 54
                color: "#23BC3D"
                radius: 4
                visible: true

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: 12
                    font.weight: Font.DemiBold
                    text: "Joined"
                    color: "#FFFFFF"
                }
            }

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 10

                Label{
                    Layout.topMargin: 30
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Project deadline"
                    color: "#23BC3D"
                }

                Row {
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
                }

                Label {
                    Layout.topMargin: 10
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Investment time"
                    color: "#23BC3D"
                }

                Row {
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
                        text: "May 02, 2020 - May 25, 2020"
                        color: "#72809D"
                    }
                }

                Label{
                    Layout.topMargin: 10
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Project status"
                    color: "#23BC3D"
                }

                Row {
                    spacing: 5
                    Image {
                        source: ""
                        asynchronous: true
                        width: 18
                        height: 18
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        font.pixelSize: 12
                        font.weight: Font.DemiBold
                        text: "Ongoing"
                        color: "#72809D"
                    }
                }

                Label {
                    Layout.topMargin: 10
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Description"
                    color: "#23BC3D"
                }

                Text {
                    text: qsTr("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore")
                    Layout.fillWidth: true
                    Layout.preferredHeight: 66
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: "#72809D"
                }

                Label{
                    Layout.topMargin: 10
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Photo"
                    color: "#23BC3D"
                }

                Image {
                    source: ""
                    Layout.fillWidth: true
                    Layout.preferredHeight: 139
                }

                Custom.Button{
                    Layout.topMargin: 10
                    Layout.bottomMargin: 20
                    Layout.fillWidth: true
                    Layout.preferredHeight: 42
                    text: qsTr("Earn reward")
                    onClicked: stack.pushPage("qrc:/WorkScreen.qml");
                }
            }
        }
    }
}
