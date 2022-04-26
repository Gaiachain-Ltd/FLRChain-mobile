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
    title: cashOutPhone.length > 0  ? qsTr("Do you really want to send the money to mobile number?")
                                    : qsTr("Do you really want to send the money to faciliator?")
    iconSource: "qrc:/img/icon-confirmation.svg"

    property string cashOutAmount: "0.0"
    property string cashOutPhone: ""
    property int cashOutFacilitatorId: -1
    property string cashOutFacilitatorName: ""

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
                text: qsTr("Amount")
            }

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Label.AlignLeft
                font: Style.boldSmallFont
                color: Style.accentColor
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
                color: Style.accentColor
                wrapMode: Label.WordWrap
                text: cashOutPhone.length > 0 ? cashOutPhone
                                              : cashOutFacilitatorName
            }
        }
    }

    buttons: [
        Custom.SecondaryButton {
            Layout.fillWidth: true
            text: qsTr("Cancel")

            onClicked: {
                popup.close()
            }
        },
        Custom.PrimaryButton {
            Layout.fillWidth: true
            text: qsTr("Send")

            onClicked: {
                if (cashOutPhone.length > 0) {
                    session.cashOut(cashOutAmount, cashOutPhone)
                } else {
                    session.facilitatorCashOut(cashOutAmount,
                                               cashOutFacilitatorId,
                                               cashOutFacilitatorName)
                }

                popup.close()
            }
        }
    ]
}
