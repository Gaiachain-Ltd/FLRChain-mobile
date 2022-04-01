/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Page {
    id: root
    padding: Style.cashOutPageMargins

    property real maxAmount: 0
    readonly property string sendToFacilitatorState: "SendToFacilitatorState"
    readonly property string sendToMobileNumberState: "SendToMobileNumberState"

    Connections {
        target: pageManager

        function onSetupCashOutScreen(cashOutMode, maxAmount) {
            root.maxAmount = maxAmount;
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
                text: qsTr("Amount") + " (max " + root.maxAmount +") USDC"
            }

            Custom.TextInput {
                id: amountInput
                property string prevAmount: ""

                Layout.fillWidth: true
                Layout.preferredHeight: Style.cashOutInputHeight
                font: length > 0 ? Style.cashOutAmountInputFont : Style.textInputFont
                color: Style.cashOutAmountInputFontColor
                horizontalAlignment: Qt.AlignHCenter
                placeholderText: amountInputTitle.text
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: DoubleValidator{
                    bottom: 0;
                    decimals: 6;
                    top: root.maxAmount;
                }
                onTextChanged:
                {
                    if(!acceptableInput) {
                        amountInput.text = prevAmount
                    } else if (amountInput.text.length > 1) {
                        prevAmount = amountInput.text;
                    } else {
                        prevAmount = "";
                    }
                }
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
