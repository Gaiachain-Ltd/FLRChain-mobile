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

    readonly property int cashOutMode: {
        if (cashOutPhone.length > 0) {
            return 1;
        } else if (cashOutFacilitatorName.length > 0) {
            return 2;
        } else {
            return 3;
        }
    }
    property string cashOutAmount: "0.0"
    property string cashOutPhone: ""
    property string cashOutAddress: ""
    property int cashOutFacilitatorId: -1
    property string cashOutFacilitatorName: ""

    title: {
        switch(cashOutMode) {
        case 1:
            return qsTr("Do you really want to send the money to mobile number?");
        case 2:
            return qsTr("Do you really want to send the money to faciliator?");
        case 3:
            return qsTr("Do you really want to send the money to wallet address?");
        default:
            return "";
        }
    }

    iconSource: "qrc:/img/icon-confirmation.svg"


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
                wrapMode: Label.WrapAtWordBoundaryOrAnywhere
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
                text: {
                    switch(cashOutMode) {
                    case 1:
                        return qsTr("to phone number");
                    case 2:
                        return qsTr("to facilitator");
                    case 3:
                        return qsTr("to wallet address");
                    }
                }
            }

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Label.AlignLeft
                font: Style.boldSmallFont
                color: Style.accentColor
                wrapMode: Label.WrapAtWordBoundaryOrAnywhere
                text: {
                    switch(cashOutMode) {
                    case 1:
                        return cashOutPhone;
                    case 2:
                        return cashOutFacilitatorName;
                    case 3:
                        return cashOutAddress;
                    }
                }
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
                switch(cashOutMode) {
                    case 1:
                        session.cashOut(cashOutAmount, cashOutPhone);
                    break;
                    case 2:
                        session.facilitatorCashOut(cashOutAmount,
                                                   cashOutFacilitatorId,
                                                   cashOutFacilitatorName);
                    break;
                    case 3:
                        session.walletCashOut(cashOutAmount, cashOutAddress);
                    break;
                }

                popup.close()
            }
        }
    ]
}
