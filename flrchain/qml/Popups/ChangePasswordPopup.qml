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

Custom.Popup {
    id: popup
    title: qsTr("Change password")

    function validateData() {
        if (!oldPasswordInput.length || !passwordInput.text.length || !repeatPassword.text.length) {
            errorLabel.text = qsTr("Please fill out all fields")
            return false;
        }

        if(passwordInput.text !== repeatPassword.text) {
            errorLabel.text = qsTr("Passwords are not equal")
            return false;
        }

        session.changePassword(oldPasswordInput.text, passwordInput.text);
        return true;
    }

    Column {
        Layout.fillWidth: true
        spacing: 5

        Label {
            id: oldPasswordInputTitle
            font: Style.loginPanelInputTitleFont
            color: Style.loginPanelInputTitleFontColor
            text: qsTr("Old password")
        }

        Custom.TextInput {
            id: oldPasswordInput
            echoMode: TextInput.Password
            placeholderText: passwordInputTitle.text
        }
    }

    Column {
        Layout.fillWidth: true
        spacing: 5

        Label {
            id: passwordInputTitle
            font: Style.loginPanelInputTitleFont
            color: Style.loginPanelInputTitleFontColor
            text: qsTr("Password")
        }

        Custom.TextInput {
            id: passwordInput
            echoMode: TextInput.Password
            placeholderText: passwordInputTitle.text
        }
    }

    Column {
        Layout.fillWidth: true
        spacing: 5

        Label {
            id: repeatPasswordInput
            font: Style.loginPanelInputTitleFont
            color: Style.loginPanelInputTitleFontColor
            text: qsTr("Repeat password")
        }

        Custom.TextInput {
            id: repeatPassword
            echoMode: TextInput.Password
            placeholderText: repeatPasswordInput.text
        }
    }

    Label {
        id: errorLabel
        Layout.fillWidth: true
        font: Style.loginPanelErrorMessageFont
        color: Style.loginPanelErrorMessageFontColor
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        visible: errorLabel.text
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
            text: qsTr("Change password")

            onClicked: {
                if (validateData()) {
                    popup.close()
                }
            }
        }
    ]
}
