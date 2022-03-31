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

Drawer {
    id: drawer
    width: parent.width
    edge: Qt.TopEdge
    interactive: false
    leftPadding: Style.menuPadding
    rightPadding: Style.menuPadding
    topPadding: Style.menuPadding
    bottomPadding: 0

    background: Custom.ShadowedRectangle {
        color: Style.paneBackgroundColor
        radius: Style.paneBackgroundRadius
        shadowHorizontalOffset: Style.paneShadowHorizontalOffset
        shadowVerticalOffset: Style.paneShadowVerticalOffset
        shadowRadius: Style.paneShadowRadius
        shadowColor: Style.paneShadowColor
    }

    ColumnLayout {
        width: drawer.availableWidth

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.leftMargin: Style.menuPadding

            Item {
                Layout.preferredWidth: childrenRect.width
                Layout.preferredHeight: childrenRect.height

                Column {
                    id: column
                    spacing: Style.microMargin

                    Label {
                        id: username
                        font: Style.menuUserNameFont
                        color: Style.menuUserNameFontColor
                        text: session && session.user ? session.user.firstName + " " + session.user.lastName : ""
                    }

                    Label {
                        id: usermail
                        font: Style.menuUserEmailFont
                        color: Style.menuUserEmailFontColor
                        text: session && session.user ? session.user.email : ""
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // TODO: open my profile page
                        console.warn("TODO: not implemented!")
                    }
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Custom.IconButton {
                Layout.preferredWidth: Style.menuButtonClickAreaWidth
                Layout.preferredHeight: Style.menuButtonClickAreaWidth
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                Layout.topMargin: -Style.menuPadding
                Layout.rightMargin: -Style.menuPadding
                iconSize: Style.menuCloseIconSize
                iconSource: "qrc:/img/icon-close-menu.svg"

                onClicked: {
                    drawer.close()
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.separatorHeight
            Layout.leftMargin: -Style.menuPadding
            Layout.rightMargin: -Style.menuPadding
            Layout.topMargin: Style.menuPadding
            color: Style.menuSeparatorColor
        }

        Custom.ImageButton {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.menuItemHeight
            background: null
            iconSize: Style.menuItemIconSize
            iconSource: "qrc:/img/icon-menu-home.svg"
            font: Style.menuItemLabelFont
            textColor: Style.menuItemLabelFontColor
            text: qsTr("Home")

            onClicked: {
                drawer.close()
                pageManager.enterDashboardScreen()
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.menuSeparatorHeight
            color: Style.sectionColor
        }

        Custom.ImageButton {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.menuItemHeight
            background: null
            iconSize: Style.menuItemIconSize
            iconSource: "qrc:/img/icon-menu-earn-rewards.svg"
            font: Style.menuItemLabelFont
            textColor: Style.menuItemLabelFontColor
            text: qsTr("Earn rewards")

            onClicked: {
                drawer.close()
                pageManager.enterProjectListScreen()
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.menuSeparatorHeight
            color: Style.sectionColor
        }

        Custom.ImageButton {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.menuItemHeight
            background: null
            iconSize: Style.menuItemIconSize
            iconSource: "qrc:/img/icon-menu-wallet.svg"
            font: Style.menuItemLabelFont
            textColor: Style.menuItemLabelFontColor
            text: qsTr("Wallet")

            onClicked: {
                drawer.close()
                pageManager.enterWalletScreen()
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.menuSeparatorHeight
            color: Style.sectionColor
        }

        Custom.ImageButton {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.menuItemHeight
            background: null
            iconSize: Style.menuItemIconSize
            iconSource: "qrc:/img/icon-menu-logout.svg"
            font: Style.menuItemLabelFont
            textColor: Style.menuItemLogoutLabelFontColor
            text: qsTr("Log out")

            onClicked: {
                drawer.close()
                logoutPopup.open()
            }
        }
    }
}
