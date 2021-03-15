import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Successfully added")

    ColumnLayout {
        Layout.fillWidth: true
        Layout.leftMargin: Style.baseMargin
        Layout.rightMargin: Style.baseMargin
        spacing: 20

        Row {
            Layout.alignment: Qt.AlignHCenter

            Label {
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: Style.fontSmall
                font.weight: Font.DemiBold
                color: Style.darkLabelColor
                text: qsTr("The work for project: ")
            }

            Label {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: -15
                font.pointSize: Style.fontSmall
                color: Style.darkLabelColor
                font.weight: Font.Bold
                text: qsTr("Eum Repellendus Aut")
            }
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -Style.baseMargin
            Label {
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: Style.fontSmall
                font.weight: Font.DemiBold
                color: Style.darkLabelColor
                text: qsTr("in task: ")
            }

            Label {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: -15
                font.pointSize: Style.fontSmall
                color: Style.darkLabelColor
                font.weight: Font.Bold
                text: qsTr("Plant fruit trees on farmland")
            }
        }

        Label {
            Layout.topMargin: -Style.baseMargin
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.fontSmall
            font.weight: Font.DemiBold
            color: Style.darkLabelColor
            text: qsTr("has been successfully added")
        }

        Custom.Button {
            text: qsTr("Back to project")
            Layout.fillWidth: true

            onClicked: {
                popup.close()
            }
        }

        Item{
            Layout.fillWidth: true
        }
    }
}
