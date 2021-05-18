import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

Item {
    height: Style.walletDelegateHeight
    width: parent.width
    property bool separatorVisible: true

    function statusName() {
        switch(status) {
        case 0:
            return qsTr("Rejected")
        case 1:
            return qsTr("Confirmed")
        case 2:
            return qsTr("Pending")
        }
    }

    function statusColor() {
        switch(status) {
        case 0:
            return Style.errorColor;
        case 1:
            return Style.accentColor;
        case 2:
            return Style.yellowLabelColor;
        }
    }

    RowLayout{
        height: childrenRect.height
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: Style.baseMargin
            rightMargin: Style.baseMargin
        }
        Column{
            Label {
                text: title
                font.pixelSize: Style.fontTiny
                color: Style.mediumLabelColor
            }

            Label {
                text: qsTr("Reward")
                font.pixelSize: Style.fontTiny
                color: Style.darkLabelColor
            }

            Label {
                text: statusName()
                font.pixelSize: Style.fontTiny
                color: statusColor()
            }
        }

        Item{
            Layout.fillWidth: true
        }

        Label {
            text: "+ " + amount
            font.pixelSize: Style.fontLarge
            color: Style.accentColor
        }
    }

    Rectangle{
        visible: separatorVisible
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            leftMargin: Style.baseMargin
            rightMargin: Style.baseMargin
        }
        height: Style.borderWidth
        color: Style.sectionColor
    }
}
