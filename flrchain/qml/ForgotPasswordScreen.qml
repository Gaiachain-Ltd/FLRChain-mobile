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

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom

AppPage {
    property bool errorMode: false
    property bool resetInProgress: false

    Connections {
        target: dataManager

        function onResetPasswordReplyReceived(result) {
            if (result) {
                pageManager.enterSuccessPopup(qsTr("Reset link has been sent to your email"))
                AppNavigationController.goBack()
            } else {
                pageManager.enterErrorPopup(qsTr("Couldn't send reset link. Try again"))
                resetInProgress = false
            }
        }
    }

    background: Rectangle {
        color: Style.loginPageBackgroundColor
    }

    Flickable {
        anchors {
            fill: parent
            leftMargin: Style.loginPageSideMargin
            rightMargin: Style.loginPageSideMargin
        }
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds

        ColumnLayout {
            id: mainColumn
            width: parent.width
            spacing: Style.loginPageSpacing

            Image {
                Layout.topMargin: Style.loginLogoTopMargin
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Style.loginPageLogoSize
                source: "qrc:/img/logo-login.svg"
            }

            Custom.FormPane {
                Layout.fillWidth: true
                Layout.bottomMargin: Style.registrationPageTopBottomMargin
                title: qsTr("Forgot password")
                subtitle: qsTr("We will send reset link to your email address")

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: userEmailInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Email") + "*"
                    }

                    Custom.TextInput {
                        id: userEmailInput
                        Layout.fillWidth: true
                        placeholderText: qsTr("Please enter your email...")
                        isValid: !errorMode

                        onTextEdited: {
                            if (errorMode) {
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }
                }

                Label {
                    id: errorLabel
                    Layout.fillWidth: true
                    font: Style.loginPanelErrorMessageFont
                    color: Style.loginPanelErrorMessageFontColor
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                Custom.PrimaryButton {
                    id: resetButton
                    Layout.fillWidth: true
                    enabled: !resetInProgress
                    text: qsTr("Reset password")

                    onClicked: {
                        if(!userEmailInput.text.length) {
                            errorMode = true
                            errorLabel.text = qsTr("Please enter email")
                            return
                        }

                        resetInProgress = true
                        session.resetPassword(userEmailInput.text)
                    }
                }

                Custom.SecondaryButton {
                    id: loginButton
                    Layout.fillWidth: true
                    text: qsTr("Log in")

                    onClicked: {
                        AppNavigationController.goBack()
                    }
                }
            }
        }
    }
}
