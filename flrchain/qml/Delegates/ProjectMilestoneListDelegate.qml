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
import SortFilterProxyModel 0.2

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates

Pane {
    id: root
    padding: 0
    background: null

    property int actionNumber
    property int milestoneNumber
    property string milestoneName
    property var milestoneTasks

    contentItem: ColumnLayout {
        width: parent.availableWidth
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            Label {
                font: Qt.font({family: Style.appFontFamily, styleName: "Regular", pixelSize: 16})
                color: "#414D55"
                text: String("%1 %2: ").arg(qsTr("Milestone")).arg(root.milestoneNumber)
            }

            Label {
                Layout.fillWidth: true
                font: Qt.font({family: Style.appFontFamily, styleName: "SemiBold", pixelSize: 16})
                color: "#414D55"
                wrapMode: Label.WordWrap
                text: root.milestoneName
            }
        }

        ListView {
            Layout.fillWidth: true
            Layout.preferredHeight: contentHeight
            spacing: parent.spacing
            interactive: false

            model: SortFilterProxyModel {
                sourceModel: root.milestoneTasks
                filters: [
                    ValueFilter {
                        enabled: showFavouritesOnly
                        roleName: "taskFavourite"
                        value: true
                    }
                ]
            }

            delegate: Delegates.ProjectTaskListDelegate {
                width: ListView.view.width
                actionNumber: root.actionNumber
                milestoneNumber: root.milestoneNumber
                taskNumber: model.index + 1
                taskId: model.taskId
                taskName: model.taskName
                taskReward: model.taskReward
                taskBatch: model.taskBatch
                taskFavourite: model.taskFavourite
            }
        }
    }
}
