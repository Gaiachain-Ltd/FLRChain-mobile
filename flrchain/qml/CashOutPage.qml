import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Page {
    id: root
    padding: Style.cashOutPageMargins

    readonly property string sendToFacilitatorState: "SendToFacilitatorState"
    readonly property string sendToMobileNumberState: "SendToMobileNumberState"

    Connections {
        target: pageManager

        function onSetupCashOutScreen(cashOutMode) {
            if (cashOutMode === Pages.FacilitatorCashOutMode) {
                root.state = root.sendToFacilitatorState
            } else {
                root.state = root.sendToMobileNumberState
            }
        }
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Cash out")
    }

    Custom.Pane {
        anchors.fill: parent
        contentSpacing: Style.cashOutPageSpacing

        Label {
            id: infoLabel
            Layout.fillWidth: true
            horizontalAlignment: Label.AlignHCenter
            wrapMode: Label.WordWrap
            font: Style.cashOutInfoFont
            color: Style.cashOutInfoFontColor
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: Style.cashOutInputTitleSpacing

            Label {
                id: amountInputTitle
                font: Style.cashOutInputTitleFont
                color: Style.cashOutInputTitleFontColor
                text: qsTr("Amount")
            }

            Custom.TextInput {
                id: amountInput
                Layout.fillWidth: true
                Layout.preferredHeight: Style.cashOutInputHeight
                font: length > 0 ? Style.cashOutAmountInputFont : Style.textInputFont
                color: Style.cashOutAmountInputFontColor
                horizontalAlignment: Qt.AlignHCenter
                placeholderText: amountInputTitle.text
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: RegExpValidator{ regExp: /^[0-9]+([.][0-9]{1,2})?$/ }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: Style.cashOutInputTitleSpacing

            Label {
                id: receiverInputTitle
                font: Style.cashOutInputTitleFont
                color: Style.cashOutInputTitleFontColor
            }

            StackLayout {
                id: receiverInputSelector

                Layout.fillWidth: true
                Layout.fillHeight: false

                Custom.ComboBox {
                    id: receiverInput
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.cashOutInputHeight
                    model: ["TODO: John Doe", "TODO: Mark McDonald", "TODO: Jerry Johnson"] // TODO
                }

                Custom.TextInput {
                    id: phoneNumberInput
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.cashOutInputHeight
                    horizontalAlignment: Qt.AlignHCenter
                    placeholderText: receiverInputTitle.text
                    inputMethodHints: Qt.ImhDialableCharactersOnly
                    text: session.user.phone
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Custom.SecondaryButton {
            Layout.fillWidth: true
            text: qsTr("Cancel")

            onClicked: {
                pageManager.back()
            }
        }

        Custom.PrimaryButton {
            Layout.fillWidth: true
            enabled:
            {
                if (root.state == root.sendToMobileNumberState) {
                    return phoneNumberInput.displayText.length > 0 && amountInput.displayText.length > 0
                }

                return false // TODO
            }
            opacity: enabled ? 1.0 : 0.5
            text: qsTr("Send money")

            onClicked: {
                if (root.state == root.sendToMobileNumberState) {
                    session.cashOut(amountInput.text, phoneNumberInput.text)
                    pageManager.back()
                } else {
                    // TODO
                    console.warn("TODO: not implemented")
                }
            }
        }
    }

    state: sendToMobileNumberState
    states: [
        State {
            name: sendToFacilitatorState

            PropertyChanges {
                target: infoLabel
                text: qsTr("This is for sending your USDC to the facilitator in exchange for cash in local currency")
            }

            PropertyChanges {
                target: receiverInputTitle
                text: qsTr("Send to")
            }

            PropertyChanges {
                target: receiverInputSelector
                currentIndex: 0
            }
        },

        State {
            name: sendToMobileNumberState

            PropertyChanges {
                target: infoLabel
                text: qsTr("This is for sending your USDC to the mobile number to cash it out at your mobile operator's facility")
            }

            PropertyChanges {
                target: receiverInputTitle
                text: qsTr("Phone number")
            }

            PropertyChanges {
                target: receiverInputSelector
                currentIndex: 1
            }
        }
    ]
}
