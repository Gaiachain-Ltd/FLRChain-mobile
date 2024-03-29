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
import com.melije.pulltorefresh 2.0

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom
import "qrc:/Project" as ProjectComponents

AppPage {
    id: projectsScreen

    Custom.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }

    Connections {
        target: projectsModel

        function onProjectsReceived() {
            busyIndicator.visible = false
        }
    }

    Connections {
        target: dataManager

        function onMyTasksReceived(myTasks) {
            busyIndicator.visible = false
            myTasksView.myTasks = myTasks
        }
    }

    function reloadData() {
        busyIndicator.visible = true

        if (stackLayout.currentIndex == 0) {
            const ids = FavouriteTaskStorage.favouriteIds();
            if (ids.length === 0) {
                busyIndicator.visible = false;
            } else {
                session.getMyTasks(FavouriteTaskStorage.favouriteIds())
            }
        } else {
            session.getProjectsData()
        }
    }

    background: null

    header: Custom.Header {
        id: header
        height: Style.headerHeight
        title: qsTr("Earn rewards")
    }

    ColumnLayout {
        anchors.fill: parent
        visible: !busyIndicator.visible

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            Layout.preferredHeight: Style.defaultTabButtonHeight
            spacing: 0
            currentIndex: 0

            Custom.TabButton { text: qsTr("My tasks") }
            Custom.TabButton { text: qsTr("Projects") }
        }

        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: tabBar.currentIndex

            Component.onCompleted: reloadData()
            onCurrentIndexChanged: reloadData()

            ProjectComponents.MyTasksList {
                id: myTasksView
                Layout.leftMargin: Style.projectListSideMargins
                Layout.rightMargin: Style.projectListSideMargins

                PullToRefreshHandler {
                    target: myTasksView
                    threshold: 25
                    refreshIndicatorDelegate: RefreshIndicator {
                        Material.accent: Style.accentColor
                    }

                    onPullDownRelease:
                    {
                        reloadData()
                    }
                }
            }

            ProjectComponents.ProjectList {
                id: projectsView
                Layout.leftMargin: Style.projectListSideMargins
                Layout.rightMargin: Style.projectListSideMargins

                PullToRefreshHandler {
                    target: projectsView
                    threshold: 25
                    refreshIndicatorDelegate: RefreshIndicator {
                        Material.accent: Style.accentColor
                    }

                    onPullDownRelease:
                    {
                        reloadData()
                    }
                }
            }
        }
    }
}
