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
import com.flrchain.objects 1.0

Pane {
    id: root

    property int status: -1

    topPadding: Style.assignmentStatusLabelTopBottomPadding
    bottomPadding: Style.assignmentStatusLabelTopBottomPadding
    leftPadding: Style.assignmentStatusLabelLeftRightPadding
    rightPadding: Style.assignmentStatusLabelLeftRightPadding
    visible: status !== -1

    background: Rectangle {
        radius: Style.assignmentStatusLabelRadius
        color:
        {
            switch (root.status)
            {
            case 0:
                return Style.assignmentWaitingColor

            case 1:
                return Style.assignmentAcceptedColor

            case 2:
                return Style.assignmentRejectedColor
            }

            return "#FFFFFF"
        }
    }

    Label {
        anchors.centerIn: parent
        font: Style.assignmentStatusLabelFont
        color: Style.assignmentStatusLabelFontColor
        text:
        {
            switch (root.status)
            {
            case 0:
                return qsTr("WAITING")

            case 1:
                return qsTr("ACCEPTED")

            case 2:
                return qsTr("REJECTED")
            }

            return ""
        }
    }
}
