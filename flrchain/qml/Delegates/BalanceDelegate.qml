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
    height: childrenRect.height
    width: parent.width
    property bool buttonVisible: true
    property string title: qsTr("Balance")
    property real value: 0.0
    property alias btn: cashOutBtn

    Custom.ShadowedRectangle {
        width: parent.width
        height: childrenRect.height

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
                spacing: Style.baseMargin

                Label{
                    Layout.topMargin: Style.baseMargin
                    font.pixelSize: Style.fontSmall
                    font.weight: Font.DemiBold
                    text: title
                    color: Style.accentColor
                }

                Rectangle {
                    color: Style.sectionColor
                    Layout.preferredHeight: Style.borderWidth
                    Layout.fillWidth: true
                    Layout.leftMargin: -Style.baseMargin
                    Layout.rightMargin: -Style.baseMargin
                }

                Label {
                    id: valueLabel
                    font.pixelSize: Style.fontMax
                    font.weight: Font.DemiBold
                    text: qsTr("%1 USDC").arg(value)
                    color: Style.mediumLabelColor
                }

                Custom.PrimaryButton {
                    id: cashOutBtn
                    Layout.fillWidth: true
                    text: qsTr("Cash out")
                    visible: buttonVisible
                }

                Item{
                    Layout.fillWidth: true
                }
            }
        }
    }
}
