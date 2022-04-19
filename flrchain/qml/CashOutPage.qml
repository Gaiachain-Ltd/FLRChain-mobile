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

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom

AppNavigationPage {
    id: root
    padding: Style.cashOutPageMargins

    property real maxAmount: 0
    readonly property string loadingState: "Loading"
    readonly property string sendToFacilitatorState: "SendToFacilitatorState"
    readonly property string sendToMobileNumberState: "SendToMobileNumberState"

    Connections {
        target: pageManager

        function onSetupCashOutScreen(cashOutMode, maxAmount) {
            root.maxAmount = maxAmount;
            if (cashOutMode === Pages.FacilitatorCashOutMode) {
                session.getFacilitatorList()
                root.state = root.loadingState
            } else {
                root.state = root.sendToMobileNumberState
            }
        }
    }

    Connections {
        target: dataManager

        function onFacilitatorListReceived(facilitators) {
            receiverInput.model = facilitators
            root.state = root.sendToFacilitatorState
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
                validator: DoubleValidator {
                    bottom: 0
                    decimals: 6
                    top: root.maxAmount
                }
                onTextChanged:
                {
                    if(!acceptableInput) {
                        amountInput.text = prevAmount
                    } else if (amountInput.text.length > 1) {
                        prevAmount = amountInput.text
                    } else {
                        prevAmount = ""
                    }
                }
            }
        }

        Custom.BusyIndicator {
            id: busyIndicator
            Layout.alignment: Qt.AlignHCenter
        }

        ColumnLayout {
            id: receiverColumn
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
                    textRole: "name"
                    valueRole: "id"
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.cashOutInputHeight
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
                } else if (root.state == root.sendToFacilitatorState) {
                    return receiverInput.currentValue > 0 && amountInput.displayText.length > 0
                }
                return false;
            }
            text: qsTr("Send money")

            onClicked: {
                if (root.state == root.sendToMobileNumberState) {
                    session.cashOut(amountInput.text, phoneNumberInput.text)
                    pageManager.back()
                } else {
                    session.facilitatorCashOut(amountInput.text, receiverInput.currentValue)
                    pageManager.back()
                }
            }
        }
    }

    state: sendToMobileNumberState
    states: [
        State {
            name: loadingState

            PropertyChanges {
                target: receiverColumn
                visible: false
            }

            PropertyChanges {
                target: busyIndicator
                visible: true
            }

            PropertyChanges {
                target: amountInput
                enabled: false
            }
        },

        State {
            name: sendToFacilitatorState

            PropertyChanges {
                target: receiverColumn
                visible: true
            }

            PropertyChanges {
                target: busyIndicator
                visible: false
            }

            PropertyChanges {
                target: amountInput
                enabled: true
            }

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
                target: receiverColumn
                visible: true
            }

            PropertyChanges {
                target: busyIndicator
                visible: false
            }

            PropertyChanges {
                target: amountInput
                enabled: true
            }

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
