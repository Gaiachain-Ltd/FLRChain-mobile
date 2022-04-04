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
import com.flrchain.style 1.0

Button {
    id: button

    property string backgroundColor: Style.accentColor
    property string textColor: Style.darkLabelColor
    property string iconSource: ""
    property size iconSize: Qt.size(Style.iconMedium, Style.iconMedium)
    property int layoutDirection: Qt.LeftToRight
    property int rowSpacing: Style.smallMargin
    property string borderColor: backgroundColor
    property int borderWidth: 0

    implicitWidth: Style.buttonHeight
    implicitHeight: Style.buttonHeight
    font.family: Style.appFontFamily

    background: Rectangle {
        radius: Style.baseRadius
        color: backgroundColor
        border.color: button.borderColor
        border.width: button.borderWidth
    }

    contentItem: Item {
        anchors {
            fill: parent
            leftMargin: Style.baseMargin
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: button.spacing
            layoutDirection: button.layoutDirection

            Image {
                width: button.iconSize.width
                height: button.iconSize.height
                sourceSize: Qt.size(width, height)
                source: button.iconSource
                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }

            Label {
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font: button.font
                color: button.textColor
                text: button.text
            }
        }
    }
}
