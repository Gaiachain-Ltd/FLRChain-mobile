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

import com.flrchain.objects 1.0
import SortFilterProxyModel 0.2

import "qrc:/Delegates" as Delegates

ListView {
    id: projectTaskList
    implicitHeight: contentHeight
    spacing: 20
    interactive: false
    delegate: actionDelegate

    property alias sourceModel: filterModel.sourceModel

    property int projectId: -1
    property string projectName: "N/A"
    property int projectStatus: Project.ProjectStatus.Undefined
    property int projectAssignmentStatus: Project.AssignmentStatus.Undefined
    readonly property bool projectIsActive: projectStatus === Project.ProjectStatus.Active
    readonly property bool userHasJoined: projectAssignmentStatus === Project.AssignmentStatus.Accepted

    property bool showFavouritesOnly: false
    property bool showActionInfo: true
    property bool showMilestoneInfo: true

    property Component actionDelegate: Delegates.ProjectActionListDelegate {
        width: ListView.view.width
    }

    property Component milestoneDelegate: Delegates.ProjectMilestoneListDelegate {
        width: ListView.view.width
    }

    property Component taskDelegate: Delegates.ProjectTaskListDelegate {
        width: ListView.view.width
    }

    model: SortFilterProxyModel {
        id: filterModel

        filters: [
            ValueFilter {
                enabled: showFavouritesOnly
                roleName: "actionHasFavouriteTask"
                value: true
            }
        ]
    }
}
