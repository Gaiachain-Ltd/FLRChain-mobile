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
import "qrc:/Popups" as Popups

AppPage {
    property bool errorMode: false

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("My profile")
    }

    Flickable {
        id: profileFlickable
        anchors.fill: parent
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.DragOverBounds

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.profileScreenMargins
                rightMargin: Style.profileScreenMargins
            }
            spacing: Style.profileScreenSpacing

            Custom.Pane {
                Layout.fillWidth: true
                Layout.topMargin: Style.profileScreenMargins
                Layout.bottomMargin: Style.profileScreenMargins

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: nameInputTitle
                        Layout.fillWidth: true
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        wrapMode: Label.WordWrap
                        text: qsTr("First name")
                    }

                    Custom.TextInput {
                        id: nameInput
                        Layout.fillWidth: true
                        placeholderText: nameInputTitle.text
                        text: session.user.firstName
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: lastNameInputTitle
                        Layout.fillWidth: true
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Last name")
                    }

                    Custom.TextInput {
                        id: lastNameInput
                        Layout.fillWidth: true
                        placeholderText: lastNameInputTitle.text
                        text: session.user.lastName
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: phoneInputTitle
                        Layout.fillWidth: true
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Phone")
                    }

                    Custom.TextInput {
                        id: phoneInput
                        Layout.fillWidth: true
                        placeholderText: phoneInputTitle.text
                        text: session.user.phone
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: 5

                    Label {
                        id: villageNameInputTitle
                        Layout.fillWidth: true
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Village name")
                    }

                    Custom.TextInput {
                        id: villageNameInput
                        Layout.fillWidth: true
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
                        AppNavigationController.openPopup(AppNavigation.ChangePasswordPopup)
                    }
                }

                Custom.PrimaryButton {
                    id: saveChangesButton
                    Layout.fillWidth: true
                    Layout.topMargin: Style.profileScreenSpacing
                    text: qsTr("Save changes")

                    onClicked: {
                        if(!nameInput.text.length || !lastNameInput.text.length) {
                            errorLabel.text = qsTr("Please fill out all fields")
                            return
                        }

                        session.saveUserInfo(nameInput.text, lastNameInput.text,
                                             phoneInput.text, villageNameInput.text)
                    }
                }
            }
        }
    }
}
