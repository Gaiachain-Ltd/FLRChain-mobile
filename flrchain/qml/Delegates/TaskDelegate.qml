import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

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
            color: Style.bgColor
            radius: 10

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Style.baseMargin
                anchors.rightMargin: Style.baseMargin
                spacing: 8

                Label{
                    Layout.topMargin: Style.baseMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Action"
                    color: Style.accentColor
                }

                Label{
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Plant Fruit trees on farmland"
                    color: Style.mediumLabelColor
                }

                Label {
                    Layout.topMargin: Style.smallMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "Rewards per unit"
                    color: Style.accentColor
                }

                Label{
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: "2 USDC"
                    color: Style.mediumLabelColor
                }

                Custom.Button{
                    Layout.topMargin: Style.smallMargin
                    Layout.bottomMargin: Style.baseMargin
                    Layout.fillWidth: true
                    text: qsTr("Earn reward")
                    onClicked: stack.pushPage("qrc:/WorkScreen.qml");
                }
            }
        }
    }
}
