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
    id: control

    property int radius: 0
    property string iconSource: ""
    property size iconSize: Qt.size(Style.iconSize, Style.iconSize)
    property size iconContainerSize: iconSize

    implicitWidth: Style.iconButtonHeight
    implicitHeight: Style.iconButtonHeight

    background: null

    contentItem: Item {
        anchors.fill: parent

        Item {
            width: control.iconContainerSize.width
            height: control.iconContainerSize.height
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: imageIcon
                anchors.centerIn: parent

                source: control.iconSource
                asynchronous: true

                opacity: control.enabled ? 1.0 : 0.3

                width: control.iconSize.width
                height: control.iconSize.height

                fillMode: Image.PreserveAspectFit
                sourceSize: Qt.size(width, height)
            }
        }
    }
}
