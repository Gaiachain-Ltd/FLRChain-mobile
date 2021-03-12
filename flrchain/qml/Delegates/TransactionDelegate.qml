import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

Item {
    height: 63
    width: parent.width

    RowLayout{
        height: childrenRect.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Style.baseMargin
        anchors.rightMargin: Style.baseMargin

        Column{
            Label {
                text: qsTr("Quas Eos Quisquam")
                font.pixelSize: Style.fontTiny
                color: Style.mediumLabelColor
            }

            Label {
                text: qsTr("Reward")
                font.pixelSize: Style.fontTiny
                color: Style.darkLabelColor
            }
        }

        Item{
            Layout.fillWidth: true
        }

        Label {
            text: qsTr("+ 20 USDC")
            font.pixelSize: Style.fontLarge
            color: Style.accentColor
        }
    }

    Rectangle{
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Style.baseMargin
        anchors.rightMargin: Style.baseMargin
        height: 1
        color: Style.sectionColor
    }
}
