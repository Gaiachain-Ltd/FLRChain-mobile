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
import com.milosolutions.AppNavigation 1.0

import "qrc:/CustomControls" as Custom

Pane {
    id: taskListDelegate
    topPadding: Style.panePadding
    bottomPadding: Style.panePadding
    leftPadding: Style.panePadding
    rightPadding: Style.panePadding

    property int actionNumber: -1
    property int milestoneNumber: -1
    property int taskNumber: -1

    background: Custom.ShadowedRectangle {
        color: Style.paneBackgroundColor
        radius: Style.paneBackgroundRadius
        shadowHorizontalOffset: Style.paneShadowHorizontalOffset
        shadowVerticalOffset: Style.paneShadowVerticalOffset
        shadowRadius: Style.paneShadowRadius
        shadowColor: Style.paneShadowColor

        AbstractButton {
            anchors {
                top: parent.top
                topMargin: padding
                right: parent.right
                rightMargin: padding
            }
            padding: 10
            visible: userHasJoined

            contentItem: RowLayout {
                id: favLayout
                spacing: 5

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    font: Style.projectDetailsPaneSectionTitleFont
                    color: Style.projectDetailsPaneSectionTitleFontColor
                    text: taskFavourite ? qsTr("Remove") : qsTr("Add")
                }

                Image {
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: Style.projectTaskFavouriteButtonSize.width
                    Layout.preferredHeight: Style.projectTaskFavouriteButtonSize.height
                    sourceSize: Style.projectTaskFavouriteButtonSize
                    source: taskFavourite ? "qrc:/img/icon-remove-fav.svg"
                                          : "qrc:/img/icon-add-fav.svg"
                }
            }

            onClicked: {
                taskFavourite = !taskFavourite
            }
        }
    }

    ColumnLayout {
        width: taskListDelegate.availableWidth
        spacing: 10

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 5

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: String("%1 %2.%3.%4").arg(qsTr("Task")).arg(actionNumber).arg(milestoneNumber).arg(taskNumber)
            }

            Label {
                id: taskNameLabel
                Layout.fillWidth: true
                font: Style.projectDetailsPaneContentFont
                color: Style.projectDetailsPaneContentFontColor
                wrapMode: Label.WordWrap
                text: taskName
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 5

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Reward")
            }

            Label {
                id: taskRewardLabel
                Layout.fillWidth: true
                font: Style.projectDetailsPaneContentFont
                color: Style.projectDetailsPaneContentFontColor
                wrapMode: Label.WordWrap
                text: String("%1 USDC").arg(taskReward)
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 5

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Batch")
            }

            Label {
                id: taskBatchLabel
                Layout.fillWidth: true
                font: Style.projectDetailsPaneContentFont
                color: Style.projectDetailsPaneContentFontColor
                wrapMode: Label.WordWrap
                text: String("%1 USDC (%2)").arg(taskBatch).arg(qsTr("evenly divided among all participants"))
            }
        }

        Custom.PrimaryButton {
            Layout.fillWidth: true
            visible: userHasJoined && projectIsActive
            text: qsTr("Earn reward")

            onClicked: {
                AppNavigationController.enterPage(AppNavigation.WorkPage, {taskId: taskId})
            }
        }
    }
}
