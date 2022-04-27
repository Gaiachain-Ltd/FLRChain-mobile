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

import QtMultimedia 5.8

import QZXing 3.3

import com.flrchain.style 1.0
import com.milosolutions.AppNavigation 1.0

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom

AppPage {
    id: root
    padding: Style.receiveMoneyPagePadding

    property real maxAmount: 0;
    property string receiverAddress: "";
    readonly property string scanCodeState: "ScanCodeState";
    readonly property string foundCodeState: "FoundCodeState";

    Component.onCompleted: {
        root.maxAmount = maxAmount
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Send money")
    }

    Item {
        id: scanCodeContainer
        anchors.fill: parent

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Label.AlignHCenter
            wrapMode: Label.WordWrap
            font: Style.receiveMoneyInfoFont
            color: Style.receiveMoneyInfoFontColor
            text: qsTr("Scan QR code")
        }

        Camera {
            id:camera
            focus {
                focusMode: CameraFocus.FocusContinuous
                focusPointMode: CameraFocus.FocusPointAuto
            }
        }

        VideoOutput {
            id: videoOutput
            source: camera
            anchors.fill: parent
            autoOrientation: true
            fillMode: VideoOutput.PreserveAspectFit
            filters: [ zxingFilter ]
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    camera.focus.customFocusPoint = Qt.point(mouse.x / width,  mouse.y / height);
                    camera.focus.focusMode = CameraFocus.FocusMacro;
                    camera.focus.focusPointMode = CameraFocus.FocusPointCustom;
                }
            }
            Rectangle {
                id: captureZone
                color: "transparent"
                border.color: "white"
                border.width: 4
                opacity: 0.8
                width: parent.width / 1.1
                height: width
                anchors.centerIn: parent
            }
        }

        QZXingFilter {
            id: zxingFilter
            orientation: videoOutput.orientation
            captureRect: {
                // setup bindings
                videoOutput.contentRect;
                videoOutput.sourceRect;
                return videoOutput.mapRectToSource(videoOutput.mapNormalizedRectToItem(Qt.rect(
                                                                                           0.1, 0.1, 0.9, 0.9
                                                                                           )));
            }

            decoder {
                enabledDecoders: QZXing.DecoderFormat_QR_CODE

                onTagFound: {
                    const found = tag.match(/^(algorand:\/\/)?[A-Z2-7]{58}/);
                    console.log("FOUND!", tag, found);
                    if (found) {
                        root.receiverAddress = found[0].replace("algorand://", "");
                        root.state = foundCodeState;
                    }
                }

                tryHarder: true
            }
        }
    }

    Custom.Pane {
        id: foundCodeConainer
        anchors.fill: parent

        Label {
            Layout.fillWidth: true
            Layout.bottomMargin: Style.cashOutPageSpacing
            horizontalAlignment: Label.AlignHCenter
            wrapMode: Label.WordWrap
            font: Style.receiveMoneyInfoFont
            color: Style.receiveMoneyInfoFontColor
            text: qsTr("Enter amount of USDC")
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

            Label {
                id: walletTitle
                font: Style.cashOutInputTitleFont
                color: Style.cashOutInputTitleFontColor
                text: qsTr("Receiver address")
            }

            Label {
                id: receiverAddressText
                Layout.fillWidth: true
                font: Style.textInputFont
                color: Style.textInputValidFontColor
                text: receiverAddress
                wrapMode: "WrapAnywhere"
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Custom.PrimaryButton {
            Layout.fillWidth: true
            text: qsTr("Send money")
            enabled: amountInput.text.length > 0

            onClicked: {
                AppNavigationController.openPopup(AppNavigation.ConfirmCashOutPopup,
                                                  {
                                                      cashOutAmount: amountInput.text,
                                                      cashOutAddress: receiverAddress
                                                  })
            }
        }

        Custom.SecondaryButton {
            Layout.fillWidth: true
            text: qsTr("Cancel")

            onClicked: {
                root.state = scanCodeState;
            }
        }
    }

    state: scanCodeState
    states: [
        State {
          name: scanCodeState

          PropertyChanges {
              target: scanCodeContainer
              visible: true
          }

          PropertyChanges {
              target: foundCodeConainer
              visible: false
          }
        },
        State {
          name: foundCodeState

          PropertyChanges {
              target: scanCodeContainer
              visible: false
          }

          PropertyChanges {
              target: foundCodeConainer
              visible: true
          }
        }
    ]
}
