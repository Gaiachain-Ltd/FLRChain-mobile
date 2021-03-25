import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {
    height: childrenRect.height
    width: parent.width
    property bool buttonVisible: true
    property string title: "Balance"
    property real value: 0.0
    property alias btn: cashOutBtn

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
                spacing: Style.baseMargin

                Label{
                    Layout.topMargin: Style.baseMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: title
                    color: Style.accentColor
                }

                Rectangle {
                    color: Style.sectionColor
                    Layout.preferredHeight: 1
                    Layout.fillWidth: true
                    Layout.leftMargin: -Style.baseMargin
                    Layout.rightMargin: -Style.baseMargin
                }

                Label {
                    id: valueLabel
                    font.pixelSize: 29
                    font.weight: Font.DemiBold
                    text: value + " USDC"
                    color: Style.mediumLabelColor
                }

                Custom.Button {
                    id: cashOutBtn
                    Layout.fillWidth: true
                    text: qsTr("Cash out")
                    visible: buttonVisible
                }

                Item{
                    Layout.fillWidth: true
                }
            }
        }
    }
}
