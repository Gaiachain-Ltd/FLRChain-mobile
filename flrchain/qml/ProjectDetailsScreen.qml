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
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0
import com.flrchain.objects 1.0
import SortFilterProxyModel 0.2
import com.melije.pulltorefresh 2.0

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Project" as ProjectComponents

AppPage {
    id: root

    readonly property Project project: dataManager.detailedProject
    readonly property int projectId: project ? project.id : -1
    readonly property string projectName: project ? project.name : "N/A"
    readonly property string projectDescription: project ? project.description : "N/A"
    readonly property string projectPhoto: project ? project.photo : null
    readonly property url projectMapLink: project ? project.mapLink : ""
    readonly property date projectStartDate: project ? project.startDate : new Date
    readonly property date projectEndDate: project ? project.endDate : new Date
    readonly property int projectStatus: project ? project.status : Project.ProjectStatus.Undefined
    readonly property int projectAssignmentStatus: project ? project.assignmentStatus : Project.AssignmentStatus.Undefined
    readonly property var projectActions: project ? project.actions : null

    readonly property bool projectIsActive: projectStatus === Project.ProjectStatus.Active
    readonly property bool userHasJoined: projectAssignmentStatus === Project.AssignmentStatus.Accepted
    readonly property bool showFavouritesOnly: tabBar.currentIndex == 1

    Custom.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }

    Connections {
        target: dataManager

        function onDetailedProjectChanged() {
            busyIndicator.visible = false
        }
    }

    Connections {
        target: session

        function onJoinRequestSent(projectId) {
            if (projectId === root.projectId) {
                session.getProjectDetails(projectId)
            }
        }
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Project details")
    }

    Flickable {
        id: projectDetailsFlickable
        anchors.fill: parent
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.DragOverBounds
        clip: true
        visible: !busyIndicator.visible

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.projectDetailsSideMargins
                rightMargin: Style.projectDetailsSideMargins
            }
            spacing: Style.projectDetailsContentSpacing

            Label {
                id: title
                Layout.topMargin: Style.projectDetailsTopBottomMargin
                Layout.fillWidth: true
                font: Style.projectDetailsTitleFont
                color: Style.projectDetailsTitleFontColor
                wrapMode: Label.WrapAtWordBoundaryOrAnywhere
                text: projectName
            }

            Delegates.ProjectDetailsDelegate {
                Layout.fillWidth: true
                projectId: root.projectId
                projectName: root.projectName
                deadline: root.projectEndDate
                description: root.projectDescription
                status: root.projectStatus
                assignmentStatus: root.projectAssignmentStatus
                photo: root.projectPhoto
                mapLink: root.projectMapLink
            }

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsTitleFont
                color: Style.projectDetailsTitleFontColor
                wrapMode: Label.WrapAtWordBoundaryOrAnywhere
                text: qsTr("Overview")
            }

            TabBar {
                id: tabBar
                Layout.fillWidth: true
                Layout.preferredHeight: Style.defaultTabButtonHeight
                spacing: 0
                currentIndex: 0
                visible: userHasJoined

                Custom.TabButton { text: qsTr("All tasks") }
                Custom.TabButton { text: qsTr("My tasks") }
            }

            ProjectComponents.ProjectTaskList {
                id: projectTaskList
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                Layout.bottomMargin: Style.projectDetailsTopBottomMargin
                sourceModel: root.projectActions
                projectId: root.projectId
                projectName: root.projectName
                projectStatus: root.projectStatus
                projectAssignmentStatus: root.projectAssignmentStatus
                showFavouritesOnly: root.showFavouritesOnly
            }
        }

        PullToRefreshHandler {
            target: projectDetailsFlickable
            refreshIndicatorDelegate: RefreshIndicator {
                Material.accent: Style.accentColor
            }

            onPullDownRelease:
            {
                busyIndicator.visible = true
                session.getProjectDetails(projectId)
            }
        }
    }
}
