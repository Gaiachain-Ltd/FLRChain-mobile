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
import QtGraphicalEffects 1.15
import com.flrchain.style 1.0

Rectangle {
    id: root
    radius: Style.rectangleRadius
    color: "#00FFFFFF"

    property int shadowHorizontalOffset: 5
    property int shadowVerticalOffset: 15
    property int shadowRadius: 30
    property color shadowColor: "#29000000"

    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: root.shadowHorizontalOffset
        verticalOffset: root.shadowVerticalOffset
        radius: root.shadowRadius
        color: root.shadowColor
    }
}
