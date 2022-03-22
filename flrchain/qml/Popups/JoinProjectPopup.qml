import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Send request")
    iconSource: "qrc:/img/icon-confirmation.svg"

    property string projectName: ""
    property int projectId: -1

    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        spacing: 0

        Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            horizontalAlignment: Label.AlignHCenter
            font: Style.popupTextFont
            color: Style.popupTextFontColor
            wrapMode: Label.WordWrap
            text: qsTr("Are you sure you want to join the project")
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            font: Style.popupHighlightedTextFont
            color: Style.accentColor
            text: popup.projectName
        }
    }

    Custom.SecondaryButton {
        Layout.fillWidth: true
        text: qsTr("Cancel")

        onClicked: {
            popup.close()
        }
    }

    Custom.PrimaryButton {
        Layout.fillWidth: true
        text: qsTr("Send request")

        onClicked: {
            popup.close()
            session.joinProject(popup.projectId)
        }
    }
}
