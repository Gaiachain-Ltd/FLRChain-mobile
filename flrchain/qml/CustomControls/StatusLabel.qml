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

    property int status: Project.AssignmentStatus.Undefined

    topPadding: Style.assignmentStatusLabelTopBottomPadding
    bottomPadding: Style.assignmentStatusLabelTopBottomPadding
    leftPadding: Style.assignmentStatusLabelLeftRightPadding
    rightPadding: Style.assignmentStatusLabelLeftRightPadding
    visible: status !== Project.AssignmentStatus.Undefined

    background: Rectangle {
        radius: Style.assignmentStatusLabelRadius
        color:
        {
            switch (root.status)
            {
            case Project.AssignmentStatus.New:
                return Style.assignmentNewColor

            case Project.AssignmentStatus.Waiting:
                return Style.assignmentWaitingColor

            case Project.AssignmentStatus.Accepted:
                return Style.assignmentAcceptedColor

            case Project.AssignmentStatus.Rejected:
                return Style.assignmentRejectedColor
            }

            console.warn("Could not pick proper color for assignment status label:", root.status)
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
            case Project.AssignmentStatus.New:
                return qsTr("NEW")

            case Project.AssignmentStatus.Waiting:
                return qsTr("WAITING")

            case Project.AssignmentStatus.Accepted:
                return qsTr("ACCEPTED")

            case Project.AssignmentStatus.Rejected:
                return qsTr("REJECTED")
            }

            console.warn("Could not pick proper text for assignment status label:", root.status)
            return ""
        }
    }
}
