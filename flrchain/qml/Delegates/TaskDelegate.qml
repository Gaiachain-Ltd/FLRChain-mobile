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

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 8

                Label{
                    Layout.topMargin: 20
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Action"
                    color: "#23BC3D"
                }

                Label{
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Plant Fruit trees on farmland"
                    color: "#72809D"
                }

                Label {
                    Layout.topMargin: 10
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "Rewards per unit"
                    color: "#23BC3D"
                }

                Label{
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    text: "2 USDC"
                    color: "#72809D"
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
