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
    id: milestoneListDelegate
    padding: 0
    background: null

    property int actionNumber: -1
    property int milestoneNumber: -1

    contentItem: ColumnLayout {
        width: parent.availableWidth
        spacing: projectTaskList.showMilestoneInfo ? 10 : 0

        RowLayout {
            Layout.fillWidth: true
            spacing: 0
            visible: projectTaskList.showMilestoneInfo

            Label {
                font: Qt.font({family: Style.appFontFamily, styleName: "Regular", pixelSize: 16})
                color: Style.darkLabelColor
                text: String("%1 %2.%3: ").arg(qsTr("Milestone")).arg(actionNumber).arg(milestoneNumber)
            }

            Label {
                Layout.fillWidth: true
                font: Qt.font({family: Style.appFontFamily, styleName: "SemiBold", pixelSize: 16})
                color: Style.darkLabelColor
                wrapMode: Label.WordWrap
                text: milestoneName
            }
        }

        ListView {
            Layout.fillWidth: true
            Layout.preferredHeight: contentHeight
            spacing: 10
            interactive: false

            delegate: Delegates.ProjectTaskListDelegate {
                width: ListView.view.width
                actionNumber: model.actionNumber
                milestoneNumber: model.milestoneNumber
                taskNumber: filterModel.mapToSource(model.index) + 1
            }

            model: SortFilterProxyModel {
                id: filterModel
                sourceModel: milestoneTasks

                filters: [
                    ValueFilter {
                        enabled: showFavouritesOnly
                        roleName: "taskFavourite"
                        value: true
                    }
                ]

                proxyRoles: [
                    ExpressionRole {
                        name: "actionNumber"
                        expression: milestoneListDelegate.actionNumber
                    },
                    ExpressionRole {
                        name: "milestoneNumber"
                        expression: milestoneListDelegate.milestoneNumber
                    }
                ]
            }
        }
    }
}
