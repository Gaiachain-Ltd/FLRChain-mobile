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
        boundsBehavior: Flickable.DragOverBounds

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
                title: qsTr("Login")
                subtitle: qsTr("Welcome Back!")

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Email") + "*"
                    }

                    Custom.TextInput {
                        id: userEmailInput
                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                        placeholderText: qsTr("Please enter your email...")
                        inputMethodHints: Qt.ImhEmailCharactersOnly | Qt.ImhLowercaseOnly
                        isValid: !errorMode || (errorMode && !errorLabel.text.length && text.length)

                        onTextEdited: {
                            if (errorMode) {
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }
                }

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Password") + "*"
                    }

                    Custom.TextInput {
                        id: passwordInput
                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                        placeholderText: qsTr("Please enter your password...")
                        echoMode: TextInput.Password
                        isValid: !errorMode || (errorMode && !errorLabel.text.length && text.length)

                        onTextEdited: {
                            if (errorMode) {
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }
                }

                Custom.CheckBox {
                    checked: session.getRememberMe()
                    text: qsTr("Remember me")

                    onToggled: {
                        if (session) {
                            session.setRememberMe(checked)
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
                    id: signInButton
                    Layout.fillWidth: true
                    text: qsTr("Log In")

                    onClicked: {
                        if (!userEmailInput.text.length || !passwordInput.text.length) {
                            errorLabel.text = qsTr("Please enter both email and password")
                            errorMode = true
                            return
                        }

                        session.login(userEmailInput.text, passwordInput.text)
                    }
                }

                Custom.SecondaryButton {
                    id: registerButton
                    Layout.fillWidth: true
                    text: qsTr("Register")

                    onClicked: {
                        AppNavigationController.enterPage(AppNavigation.RegistrationPage)
                    }
                }

                Custom.SecondaryButton {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: -10
                    Layout.bottomMargin: -5
                    implicitWidth: contentItem.implicitWidth + leftPadding + rightPadding
                    implicitHeight: contentItem.implicitHeight + topPadding + bottomPadding
                    background: null
                    font: Style.loginPanelForgotPasswordFont
                    text: qsTr("Forgot password?")

                    onClicked: {
                        AppNavigationController.enterPage(AppNavigation.ForgotPasswordPage)
                    }
                }
            }
        }
    }
}
