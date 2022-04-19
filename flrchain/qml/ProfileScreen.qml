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
import "qrc:/Popups" as Popups

AppPage {
    property bool errorMode: false

    function validateData() {
        if(!nameInput.text.length || !lastNameInput.text.length)
        {
            errorLabel.text = qsTr("Please fill out all fields")
            return
        }

        session.saveUserInfo(nameInput.text, lastNameInput.text, phoneInput.text,
                             villageNameInput.text);
    }

    background: Rectangle {
        color: Style.backgroundColor
    }

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Wallet")
    }

    Popups.ChangePasswordPopup {id: changePasswordPopup }

    Flickable {
        anchors {
            fill: parent
            leftMargin: Style.profileScreenMargins
            rightMargin: Style.profileScreenMargins
        }
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds

        ColumnLayout {
            id: mainColumn
            width: parent.width
            spacing: Style.profileScreenSpacing

            Custom.Pane {
                Layout.fillWidth: true
                Layout.topMargin: Style.profileScreenMargins
                Layout.bottomMargin: Style.profileScreenMargins

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        id: nameInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("First name")
                    }

                    Custom.TextInput {
                        id: nameInput
                        placeholderText: nameInputTitle.text
                        text: session.user.firstName
                    }
                }

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        id: lastNameInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Last name")
                    }

                    Custom.TextInput {
                        id: lastNameInput
                        placeholderText: lastNameInputTitle.text
                        text: session.user.lastName
                    }
                }

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        id: phoneInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Phone")
                    }

                    Custom.TextInput {
                        id: phoneInput
                        placeholderText: phoneInputTitle.text
                        text: session.user.phone
                    }
                }

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        id: villageNameInputTitle
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Village name")
                    }

                    Custom.TextInput {
                        id: villageNameInput
                        placeholderText: villageNameInputTitle.text
                        text: session.user.village
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

                Custom.ImageButton {
                    Layout.fillWidth: true
                    Layout.topMargin: Style.profileScreenSpacing
                    backgroundColor: Style.backgroundColor
                    text: qsTr("Change password")
                    iconSource: "qrc:/img/padlock.svg"
                    layoutDirection: Qt.RightToLeft
                    rowSpacing: Style.tinyMargin
                    borderColor: Style.inputBackgroundColor
                    textColor: Style.loginPanelInputTitleFontColor
                    implicitHeight: Style.changePasswordButtonHeight
                    borderWidth: Style.changePasswordButtonBorderWidth
                    centerContent: true

                    onClicked: {
                        changePasswordPopup.open();
                    }
                }

                Custom.PrimaryButton {
                    id: saveChangesButton
                    Layout.fillWidth: true
                    Layout.topMargin: Style.profileScreenSpacing
                    text: qsTr("Save changes")

                    onClicked: {
                        validateData()
                    }
                }
            }
        }
    }
}
