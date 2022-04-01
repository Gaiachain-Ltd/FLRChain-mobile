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

import "qrc:/CustomControls" as Custom

Page {
    id: root
    padding: Style.receiveMoneyPagePadding

    Component.onCompleted: {
        busyIndicator.visible = true;
        session.getWalletQRCode();
    }

    Connections {
        target: dataManager

        function onWalletQRCodeReceived(qrCodeData) {
            busyIndicator.visible = false;
            qrCodeImage.source = "data:image/svg+xml;utf-8," + qrCodeData;
        }
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Receive money")
    }

    Custom.Pane {
        anchors.fill: parent

        Label {
            Layout.fillWidth: true
            horizontalAlignment: Label.AlignHCenter
            wrapMode: Label.WordWrap
            font: Style.receiveMoneyInfoFont
            color: Style.receiveMoneyInfoFontColor
            text: qsTr("Let the sender scan your QR code")
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Custom.BusyIndicator {
                id: busyIndicator
                anchors.centerIn: parent
                visible: false
            }

            Image {
                id: qrCodeImage
                anchors.centerIn: parent
                width: Style.receiveMoneyQrCodeSize.width
                height: Style.receiveMoneyQrCodeSize.height
                sourceSize: Style.receiveMoneyQrCodeSize
                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }
        }

        Custom.PrimaryButton {
            Layout.fillWidth: true
            text: qsTr("Close")

            onClicked: {
                pageManager.back()
            }
        }
    }
}
