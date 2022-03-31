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
import QtQuick.Controls 2.15 as Controls

import com.flrchain.style 1.0

Controls.Button {
    id: button
    implicitWidth: Style.defaultButtonSize.width
    implicitHeight: Style.defaultButtonSize.height

    property color backgroundColor: Style.primaryButtonBackgroundColor
    property int backgroundRadius: Style.defaultButtonRadius
    property color borderColor: Style.primaryButtonBorderColor
    property int borderWidth: Style.defaultButtonBorderWidth
    property color labelColor: Style.primaryButtonFontColor

    font: Style.buttonFont
    palette.buttonText: labelColor

    background: Rectangle {
        radius: button.backgroundRadius
        color: button.backgroundColor
        border {
            width: button.borderWidth
            color: button.borderColor
        }
    }
}
