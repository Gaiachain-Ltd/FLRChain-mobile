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

    property bool errorMode: false

    Connections {
        target: dataManager

        function onResetPasswordReplyReceived(result) {
            if (result) {
                pageManager.enterSuccessPopup(qsTr("Reset link has been sent to your email"));
                pageManager.back();
            } else {
                pageManager.enterErrorPopup(qsTr("Couldn't send reset link. Try again"));
            }
        }
    }

    function validateData() {
        if(!userEmailInput.text.length)
        {
            errorLabel.text = qsTr("Please enter email")
            return
        }

        session.resetPassword(userEmailInput.text);
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
                Layout.topMargin: Style.registrationPageTopBottomMargin
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Style.loginPageLogoSize
                source: "qrc:/img/logo-login.svg"
            }

            Custom.FormPane {
                Layout.fillWidth: true
                Layout.bottomMargin: Style.registrationPageTopBottomMargin
                title: qsTr("Forgot password")
                subtitle: qsTr("We will send reset link to your email address")

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        id: userEmailInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Email")
                    }

                    Custom.TextInput {
                        id: userEmailInput
                        placeholderText: userEmailInputTitle.text
                        isValid: !errorMode

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
                    id: resetButton
                    Layout.fillWidth: true
                    text: qsTr("Reset password")

                    onClicked: {
                        validateData();
                    }
                }

                Custom.SecondaryButton {
                    id: loginButton
                    Layout.fillWidth: true
                    text: qsTr("Log in")

                    onClicked: {
                        pageManager.back()
                    }
                }
            }
        }
    }
}
