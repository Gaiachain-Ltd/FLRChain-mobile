import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Page {
    id: root
    padding: Style.receiveMoneyPagePadding

    Connections {
        target: pageManager

        function onSetupReceiveMoneyScreen(qrCodeUrl) {
            qrCodeImage.source = qrCodeUrl
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
