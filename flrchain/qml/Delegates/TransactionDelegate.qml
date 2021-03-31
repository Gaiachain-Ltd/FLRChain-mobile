import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

Item {
    height: 63
    width: parent.width
    property bool separatorVisible: true

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
                text: projectName
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
        height: 1
        color: Style.sectionColor
    }
}
