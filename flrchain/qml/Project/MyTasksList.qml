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
import com.flrchain.objects 1.0
import com.milosolutions.AppNavigation 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Project" as ProjectComponents

Flickable {
    id: root
    contentHeight: mainColumn.height
    boundsBehavior: Flickable.StopAtBounds
    clip: true

    property alias myTasks: myTasksList.model

    ColumnLayout {
        id: mainColumn
        anchors {
            left: parent.left
            leftMargin: Style.projectListSideMargins
            right: parent.right
            rightMargin: Style.projectListSideMargins
        }
        spacing: Style.baseMargin

        Label {
            Layout.topMargin: 20
            font: Style.projectListTitleFont
            color: Style.projectListTitleFontColor
            text: qsTr("My tasks to do")
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            font: Style.projectListTitleFont
            color: Style.projectListTitleFontColor
            text: qsTr("No tasks")
            visible: !myTasks || !myTasks.length
        }

        ListView {
            id: myTasksList
            Layout.fillWidth: true
            Layout.preferredHeight: contentHeight
            Layout.bottomMargin: Style.projectDetailsTopBottomMargin
            spacing: 10
            interactive: false

            delegate: Custom.Pane {
                width: ListView.view.width

                GridLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    columns: 2
                    columnSpacing: 20

                    Label {
                        Layout.alignment: Qt.AlignVCenter
                        font: Style.myTaskDelegateInfoTypeFont
                        color: Style.myTaskDelegateInfoTypeFontColor
                        text: qsTr("Project")
                    }

                    Label {
                        Layout.fillWidth: true
                        font: Style.myTaskDelegateProjectNameFont
                        color: Style.myTaskDelegateDataFontColor
                        wrapMode: Label.WordWrap
                        text: modelData.project_name
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.columnSpan: parent.columns
                        Layout.preferredHeight: 2
                        color: "#EDEEF2"
                    }

                    Label {
                        Layout.alignment: Qt.AlignVCenter
                        font: Style.myTaskDelegateInfoTypeFont
                        color: Style.myTaskDelegateInfoTypeFontColor
                        text: qsTr("Task")
                    }

                    Label {
                        Layout.fillWidth: true
                        font: Style.myTaskDelegateTaskDataFont
                        color: Style.myTaskDelegateDataFontColor
                        wrapMode: Label.WordWrap
                        text: modelData.name
                    }

                    Label {
                        Layout.alignment: Qt.AlignVCenter
                        font: Style.myTaskDelegateInfoTypeFont
                        color: Style.myTaskDelegateInfoTypeFontColor
                        text: qsTr("Reward")
                    }

                    Label {
                        Layout.fillWidth: true
                        font: Style.myTaskDelegateTaskDataFont
                        color: Style.myTaskDelegateDataFontColor
                        wrapMode: Label.WordWrap
                        text: modelData.reward
                    }

                    Custom.PrimaryButton {
                        Layout.fillWidth: true
                        Layout.columnSpan: parent.columns
                        text: qsTr("Earn reward")

                        onClicked: {
                            AppNavigationController.enterPage(AppNavigation.WorkPage,
                                                              {
                                                                  projectId: modelData.project_id,
                                                                  projectName: modelData.project_name,
                                                                  actionName: modelData.action_name,
                                                                  milestoneName: modelData.milestone_name,
                                                                  taskId: modelData.id,
                                                                  taskName: modelData.name,
                                                                  taskTypeOfInformation: modelData.data_type_tag.name,
                                                                  taskInstructions: modelData.instructions,
                                                                  taskRequiredData: modelData.data_tags
                                                              })
                        }
                    }
                }
            }
        }
    }
}
