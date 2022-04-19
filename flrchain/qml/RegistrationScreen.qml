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

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom

AppNavigationPage {
    property bool errorMode: false

    Connections {
        target: session

        function onRegistrationError(error) {
            errorMode = true
            errorLabel.text = error
        }

        function onRegistrationSuccessful(){
            pageManager.enterSuccessPopup("Account has been created.")
            pageManager.enterLoginScreen()
        }
    }

    function validateData() {
        if(!nameInput.text.length || !lastNameInput.text.length ||
           !userEmailInput.text.length || !passwordInput.text.length  ||
           !repeatPassword.text.length)
        {
            errorLabel.text = ""
            errorMode = true
            return
        }

        if(passwordInput.text !== repeatPassword.text) {
            errorLabel.text = qsTr("Passwords are not equal")
            errorMode = true
            return
        }

        session.registerUser(userEmailInput.text, passwordInput.text, nameInput.text,
                             lastNameInput.text, phoneInput.text, villageNameInput.text)
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
                title: qsTr("Register")
                subtitle: qsTr("Fill the form, make sure it is correct")

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: nameInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("First name") + "*"
                    }

                    Custom.TextInput {
                        id: nameInput
                        Layout.fillWidth: true
                        placeholderText: qsTr("Type in your first name...")
                        isValid: !errorMode || (errorMode && !errorLabel.text.length && text.length)

                        onTextEdited: {
                            if(errorMode){
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: lastNameInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Last name") + "*"
                    }

                    Custom.TextInput {
                        id: lastNameInput
                        Layout.fillWidth: true
                        placeholderText: qsTr("Type in your last name...")
                        isValid: !errorMode || (errorMode && !errorLabel.text.length && text.length)

                        onTextEdited: {
                            if(errorMode){
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }
                }

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
                        placeholderText: qsTr("Type in your email...")
                        isValid:  !errorMode || (errorMode && !errorLabel.text.length && text.length)

                        onTextEdited: {
                            if(errorMode){
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }

                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: phoneInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Phone")
                    }

                    Custom.TextInput {
                        id: phoneInput
                        Layout.fillWidth: true
                        placeholderText: qsTr("Type in your phone number...")
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: villageNameInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Village name")
                    }

                    Custom.TextInput {
                        id: villageNameInput
                        Layout.fillWidth: true
                        placeholderText: qsTr("Type in your village name...")
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: passwordInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Password") + "*"
                    }

                    Custom.TextInput {
                        id: passwordInput
                        Layout.fillWidth: true
                        echoMode: TextInput.Password
                        placeholderText: qsTr("Type in your password...")
                        isValid: !errorMode || (errorMode && !errorLabel.text.length && text.length)

                        onTextEdited: {
                            if(errorMode){
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: repeatPasswordInput
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Repeat password") + "*"
                    }

                    Custom.TextInput {
                        id: repeatPassword
                        Layout.fillWidth: true
                        echoMode: TextInput.Password
                        placeholderText: qsTr("Re-type your password...")
                        isValid: !errorMode || (errorMode && !errorLabel.text.length && text.length)

                        onTextEdited: {
                            if(errorMode){
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
                    id: registerButton
                    Layout.fillWidth: true
                    text: qsTr("Register")

                    onClicked: {
                        validateData()
                    }
                }

                Custom.SecondaryButton {
                    id: loginButton
                    Layout.fillWidth: true
                    text: qsTr("Log in")

                    onClicked: {
                        pageManager.enterLoginScreen()
                    }
                }

                Column {
                    Layout.fillWidth: true
                    Layout.bottomMargin: Style.registrationPageTopBottomMargin

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font: Style.registrationTermsFont
                        color: Style.registrationTermsFontInfoColor
                        text: qsTr("By creating this account, you agree with our")
                    }

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font: Style.registrationTermsFont
                        color: Style.registrationTermsFontLinkColor
                        text: qsTr("Terms & Conditions")

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                // TODO
                                console.warn("TODO: not implemented!")
                            }
                        }
                    }
                }
            }
        }
    }
}
