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

Item {
    property string projectName: ""
    property bool projectInvestmentConfirmed: false
    property bool buttonVisible: false

    height: childrenRect.height
    width: parent.width
    Custom.ShadowedRectangle {
        height: childrenRect.height
        width: parent.width

        Rectangle{
            id: contentRect
            width: parent.width
            height: childrenRect.height
            color: Style.bgColor
            radius: Style.rectangleRadius

            ColumnLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Style.baseMargin
                    rightMargin: Style.baseMargin
                }
                spacing: Style.tinyMargin

                Label{
                    Layout.topMargin: Style.baseMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Action")
                    color: Style.accentColor
                }

                Label{
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: actionName
                    color: Style.mediumLabelColor
                }

                Label {
                    Layout.topMargin: Style.tinyMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("Rewards per unit")
                    color: Style.accentColor
                }

                Label{
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: qsTr("%1 USDC").arg(reward)
                    color: Style.mediumLabelColor
                }

                Custom.PrimaryButton {
                    Layout.topMargin: Style.tinyMargin
                    Layout.fillWidth: true
                    text: qsTr("Earn reward")
                    visible: buttonVisible
                    onClicked: {
                        if (!session.user.optedIn) {
                            pageManager.enterErrorPopup(qsTr("Your account is not active yet. Try again later."));
                            return;
                        }
                        if (!projectInvestmentConfirmed) {
                            pageManager.enterErrorPopup(qsTr("Investment has not been confirmed yet."));
                            return;
                        }
                        pageManager.enterWorkScreen(projectId, taskId, projectName, actionName)
                    }
                }

                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.tinyMargin
                }
            }
        }
    }
}
