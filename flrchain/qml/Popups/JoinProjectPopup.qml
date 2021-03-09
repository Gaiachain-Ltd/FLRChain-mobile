import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/CustomControls" as Custom

Custom.Popup {
    title: qsTr("Send request")

    ColumnLayout {
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.leftMargin: 20
        Layout.rightMargin: 20
        spacing: 20

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 14
            font.weight: Font.DemiBold
            color: "#253F50"
            text: qsTr("Are you sure you want to join to the project")
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -15
            font.pointSize: 14
            color: "#23BC3D"
            text: qsTr("Eum Repellendus Aut")
        }

        Custom.Button {
            id: registerButton
            text: qsTr("Send request")

            onClicked: {
            }
        }

        Custom.Button {
            id: loginButton
            text: qsTr("Cancel")
            Layout.bottomMargin: 10
            bgColor: "#06BCC1"

            onClicked: {
            }
        }
    }
}
