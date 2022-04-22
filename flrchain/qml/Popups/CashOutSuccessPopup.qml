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
import com.milosolutions.AppNavigation 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: String("%1 %2 USDC").arg(qsTr("You have just sent")).arg(cashOutAmount)
    iconSource: "qrc:/img/icon-success.svg"

    property real cashOutAmount: 0.0
    property string cashOutPhone: ""
    property string cashOutFacilitator: ""
    property string cashOutTransactionId: ""

    ColumnLayout {
        Layout.fillWidth: false
        Layout.fillHeight: false
        Layout.alignment: Qt.AlignHCenter
        Layout.maximumWidth: popup.availableWidth
        spacing: 5

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 5

            Label {
                Layout.fillWidth: true
                Layout.minimumWidth: implicitWidth
                horizontalAlignment: Label.AlignRight
                font: Style.regularSmallFont
                color: Style.darkLabelColor
                wrapMode: Label.NoWrap
                text: qsTr("You transferred")
            }

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Label.AlignLeft
                font: Style.boldSmallFont
                color: Style.successColor
                wrapMode: Label.WordWrap
                text: String("%1 USDC").arg(cashOutAmount)
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 5

            Label {
                Layout.fillWidth: true
                Layout.minimumWidth: implicitWidth
                horizontalAlignment: Label.AlignRight
                font: Style.regularSmallFont
                color: Style.darkLabelColor
                wrapMode: Label.NoWrap
                text: cashOutPhone.length > 0 ? qsTr("to phone number")
                                              : qsTr("to facilitator")
            }

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Label.AlignLeft
                font: Style.boldSmallFont
                color: Style.successColor
                wrapMode: Label.WordWrap
                text: cashOutPhone.length > 0 ? cashOutPhone
                                              : cashOutFacilitator
            }
        }
    }

    buttons: [
        Custom.SecondaryButton {
            visible: cashOutTransactionId.length > 0
            Layout.fillWidth: true
            borderColor: Style.successColor
            labelColor: Style.successColor
            enabled: timer.timeRemainingSeconds == 0
            text: String("%1%2").arg(qsTr("Transaction details")).arg(timer.timeRemainingSeconds > 0
                                                                         ? String(" (%1)").arg(timer.timeRemainingSeconds)
                                                                         : "")

            /*
              It takes a few seconds for blockchain to generate the transaction details.
              In order to avoid user receiving 404 error we enable the button after few
              seconds with a countdown displayed on the button.
            */
            Timer {
                id: timer
                interval: 1000
                repeat: false
                running: true

                property int timeRemainingSeconds: 8

                onTriggered: {
                    timeRemainingSeconds--

                    if (timeRemainingSeconds > 0) {
                        start()
                    }
                }
            }

            onClicked: {
                Qt.openUrlExternally("https://testnet.algoexplorer.io/tx/" + cashOutTransactionId)
            }
        },

        Custom.PrimaryButton {
            Layout.fillWidth: true
            backgroundColor: Style.successColor
            borderColor: Style.successColor
            text: qsTr("OK")

            onClicked: {
                popup.close()
                AppNavigationController.goBack()
            }
        }
    ]
}
