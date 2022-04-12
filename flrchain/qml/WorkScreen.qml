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

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

Page {
    id: workScreen

    property int projectId: -1
    property string projectName: ""
    property string actionName: ""
    property string milestoneName: ""
    property int taskId: -1
    property string taskName: ""
    property string taskTypeOfInformation: ""
    property string taskInstructions: ""
    property var taskRequiredData: null
    property bool errorMode: false

    Custom.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }

    Connections {
        target: dataManager

        function onWorkAdditionFailed() {
            busyIndicator.visible = false
        }

        function onWorkAdded(taskName, projectName) {
            busyIndicator.visible = false
            workSuccessPopup.taskName = taskName
            workSuccessPopup.projectName = projectName
            workSuccessPopup.open()
        }
    }

    Connections {
        target: pageManager

        function onSetupWorkScreen(taskData) {
            workScreen.projectId = taskData.projectId
            workScreen.projectName = taskData.projectName
            workScreen.actionName = taskData.actionName
            workScreen.milestoneName = taskData.milestoneName
            workScreen.taskId = taskData.taskId
            workScreen.taskName = taskData.taskName
            workScreen.taskTypeOfInformation = taskData.taskTypeOfInformation
            workScreen.taskInstructions = taskData.taskInstructions
            workScreen.taskRequiredData = taskData.taskRequiredData
        }
    }

    Popups.WorkSuccessPopup {
        id: workSuccessPopup
    }

    background: Rectangle {
        color: Style.backgroundColor
    }

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Task details")
    }

    Flickable {
        anchors.fill: parent
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds
        visible: !busyIndicator.visible

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.taskDetailsPageSideMargins
                rightMargin: Style.taskDetailsPageSideMargins
            }

            Label {
                id: projectNameLabel
                Layout.fillWidth: true
                Layout.topMargin: Style.taskDetailsPageTopMargin
                font: Style.semiBoldExtraLargeFont
                color: Style.darkLabelColor
                wrapMode: Label.WordWrap
                text: projectName
            }

            Custom.Pane {
                Layout.fillWidth: true
                Layout.bottomMargin: Style.taskDetailsPageBottomMargin
                contentSpacing: Style.taskDetailsContentSpacing

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: Style.taskDetailsTitleDataSpacing

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldSmallFont
                        color: Style.accentColor
                        wrapMode: Label.WordWrap
                        text: qsTr("FLR Action")
                    }

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldTinyFont
                        color: Style.lightLabelColor
                        wrapMode: Label.WordWrap
                        text: actionName
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: Style.taskDetailsTitleDataSpacing

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldSmallFont
                        color: Style.accentColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Milestone")
                    }

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldTinyFont
                        color: Style.lightLabelColor
                        wrapMode: Label.WordWrap
                        text: milestoneName
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: Style.taskDetailsTitleDataSpacing

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldSmallFont
                        color: Style.accentColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Task")
                    }

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldTinyFont
                        color: Style.lightLabelColor
                        wrapMode: Label.WordWrap
                        text: taskName
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: Style.taskDetailsTitleDataSpacing

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldSmallFont
                        color: Style.accentColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Type of information")
                    }

                    Pane {
                        topPadding: 10
                        bottomPadding: 10
                        leftPadding: 20
                        rightPadding: 20

                        background: Rectangle {
                            color: Style.paneBackgroundColor
                            border {
                                width: 1
                                color: Style.lightLabelColor
                            }
                            radius: 20
                        }

                        contentItem: Label {
                            font: Style.semiBoldTinyFont
                            color: Style.lightLabelColor
                            text: taskTypeOfInformation
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: Style.taskDetailsTitleDataSpacing

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldSmallFont
                        color: Style.accentColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Instructions")
                    }

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldTinyFont
                        color: Style.lightLabelColor
                        wrapMode: Label.WordWrap
                        text: taskInstructions
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    spacing: Style.taskDetailsTitleDataSpacing

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldSmallFont
                        color: Style.accentColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Required data")
                    }

                    ListView {
                        id: requiredDataList
                        Layout.fillWidth: true
                        Layout.preferredHeight: contentHeight
                        spacing: parent.spacing
                        interactive: false
                        model: taskRequiredData

                        readonly property bool modelIsArray: Array.isArray(model)

                        function allDataValid() {
                            let isValid = true;
                            for (let i = 0; i < count; ++i) {
                                let input = itemAtIndex(i).item

                                if (!input.hasValidData) {
                                    input.errorMode = true;
                                    isValid = false;
                                }
                            }

                            return isValid;
                        }

                        function activityDataDump() {
                            let activityData = {}

                            for (let i = 0; i < count; ++i) {
                                let type = itemAtIndex(i).dataTagType
                                let input = itemAtIndex(i).item

                                switch (type)
                                {
                                    case DataTag.Type.Text:
                                        activityData.text = input.value
                                        break

                                    case DataTag.Type.Number:
                                        activityData.number = parseInt(input.value)
                                        break

                                    case DataTag.Type.Area:
                                        activityData.area = parseInt(input.value)
                                        break
                                }
                            }

                            return activityData
                        }

                        function activityPhotosDump() {
                            let activityPhotos = []

                            for (let i = 0; i < count; ++i) {
                                let type = itemAtIndex(i).dataTagType
                                let input = itemAtIndex(i).item

                                if (type === DataTag.Type.Photo) {
                                    activityPhotos = activityPhotos.concat(input.photos())
                                }
                            }

                            return activityPhotos
                        }

                        delegate: Loader {
                            width: ListView.view.width

                            readonly property int dataTagType: requiredDataList.modelIsArray ? modelData.tag_type
                                                                                             : model.dataTagType
                            readonly property string dataTagName: requiredDataList.modelIsArray ? modelData.name
                                                                                                : model.dataTagName

                            sourceComponent:
                            {
                                switch (dataTagType)
                                {
                                    case DataTag.Type.Text:
                                    case DataTag.Type.Number:
                                    case DataTag.Type.Area:
                                        return inputDelegate

                                    case DataTag.Type.Photo:
                                        return photoDelegate
                                }
                            }

                            Component {
                                id: inputDelegate

                                Delegates.TaskRequiredDataInputDelegate{}
                            }

                            Component {
                                id: photoDelegate

                                Delegates.TaskRequiredDataPhotoDelegate {}
                            }
                        }
                    }
                }

                Custom.PrimaryButton {
                    Layout.fillWidth: true
                    text: qsTr("Submit")

                    onClicked: {
                        if (session.internetConnection) {
                            if (requiredDataList.allDataValid()) {
                                var requiredData = {}
                                requiredData.data = requiredDataList.activityDataDump()
                                requiredData.photos = requiredDataList.activityPhotosDump()
                                session.sendWorkRequest(projectId, taskId, requiredData)
                                busyIndicator.visible = true
                            } else {
                                pageManager.enterErrorPopup("Please fill all required data before submitting work")
                            }
                        } else {
                            pageManager.enterErrorPopup("No Internet Connection")
                        }
                    }
                }
            }
        }
    }
}
