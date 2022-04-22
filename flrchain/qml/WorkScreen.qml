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
import com.milosolutions.AppNavigation 1.0
import com.melije.pulltorefresh 2.0

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

AppPage {
    id: workScreen

    property int taskId: -1

    readonly property Task task: dataManager.detailedTask
    readonly property int projectId: task ? task.projectId : -1
    readonly property string projectName: task ? task.projectName : ""
    readonly property string actionName: task ? task.actionName : ""
    readonly property string milestoneName: task ? task.milestoneName : ""
    readonly property string taskName: task ? task.name : ""
    readonly property string taskTypeOfInformation: task ? task.dataTypeTag : ""
    readonly property string taskInstructions: task ? task.instructions : ""
    readonly property var taskRequiredData: task ? task.dataTags : null

    property var taskSubmittedWork: null
    property bool errorMode: false

    Component.onCompleted: {
        reloadData()
    }

    function reloadData() {
        if (taskId != -1) {
            busyIndicator.visible = true
            session.getTaskDetails(taskId)
        }
    }

    Connections {
        target: dataManager

        function onDetailedTaskChanged() {
            session.getWorkData(projectId, taskId)
        }
    }

    Connections {
        target: session

        function onSendWorkJobFinished() {
            busyIndicator.visible = false
        }

        function onWorkDataReceived(workData) {
            busyIndicator.visible = false
            taskSubmittedWork = workData
        }

        function onTaskDetailsError() {
            busyIndicator.visible = false
        }
    }

    Custom.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Task details")
    }

    Flickable {
        id: taskDetailsFlickable
        anchors.fill: parent
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.DragOverBounds
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
                        id: typeOfInformationPane
                        Layout.maximumWidth: parent.width
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
                            width: typeOfInformationPane.availableWidth
                            height: typeOfInformationPane.availableHeight
                            font: Style.semiBoldTinyFont
                            color: Style.lightLabelColor
                            wrapMode: Label.WordWrap
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

                        readonly property bool modelIsArray: model ? Array.isArray(model) : false
                        property var missingData: []

                        function allDataValid() {
                            let isValid = true
                            missingData = []

                            for (let i = 0; i < count; ++i) {
                                let loader = itemAtIndex(i)
                                let input = loader.item

                                if (!input.hasValidData) {
                                    input.errorMode = true
                                    isValid = false

                                    missingData.push(loader.dataTagName.toString())
                                }
                            }

                            return isValid
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
                                let message = qsTr("The form is missing required information") + ": \n"

                                for (let i in requiredDataList.missingData) {
                                    message += requiredDataList.missingData[i] + "\n"
                                }

                                AppNavigationController.openPopup(AppNavigation.ErrorPopup, {errorMessage: message})
                            }
                        } else {
                            AppNavigationController.openPopup(AppNavigation.ErrorPopup, {errorMessage: qsTr("No Internet Connection")})
                        }
                    }
                }
            }

            Label {
                Layout.fillWidth: true
                Layout.topMargin: Style.taskDetailsPageTopMargin
                font: Style.semiBoldExtraLargeFont
                color: Style.darkLabelColor
                wrapMode: Label.WordWrap
                text: qsTr("Submitted work")
                visible: submittedWorkList.count > 0
            }

            ListView {
                id: submittedWorkList
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                Layout.bottomMargin: Style.taskDetailsPageBottomMargin
                spacing: 20
                interactive: false
                model: taskSubmittedWork

                delegate: Custom.Pane {
                    width: ListView.view.width

                    readonly property var submittedText: modelData.text
                    readonly property var submittedNumber: modelData.number
                    readonly property var submittedArea: modelData.area
                    readonly property var submittedPhotos: modelData.photos
                    readonly property int submittedWorkStatus: modelData.status

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: false

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            spacing: Style.taskDetailsTitleDataSpacing

                            Label {
                                Layout.fillWidth: true
                                font: Style.semiBoldSmallFont
                                color: Style.accentColor
                                wrapMode: Label.WordWrap
                                text: qsTr("Submitted at")
                            }

                            Label {
                                Layout.fillWidth: true
                                font: Style.semiBoldTinyFont
                                color: Style.lightLabelColor
                                wrapMode: Label.WordWrap
                                text: new Date(modelData.created).toLocaleString()
                            }
                        }

                        Custom.WorkActivityStatusLabel {
                            Layout.alignment: Qt.AlignRight | Qt.AlignTop
                            status: submittedWorkStatus
                        }
                    }

                    Label {
                        Layout.fillWidth: true
                        font: Style.semiBoldSmallFont
                        color: Style.accentColor
                        wrapMode: Label.WordWrap
                        text: qsTr("Submitted data")
                    }

                    ListView {
                        id: dataList
                        Layout.fillWidth: true
                        Layout.preferredHeight: contentHeight
                        spacing: parent.spacing
                        interactive: false
                        model: taskRequiredData

                        delegate: ColumnLayout {
                            width: ListView.view.width
                            spacing: ListView.view.spacing

                            readonly property int dataTagType: taskRequiredData && Array.isArray(taskRequiredData)
                                                               ? modelData.tag_type
                                                               : model.dataTagType
                            readonly property string dataTagName: taskRequiredData && Array.isArray(taskRequiredData)
                                                                  ? modelData.name
                                                                  : model.dataTagName

                            Label {
                                Layout.fillWidth: true
                                font: Style.semiBoldTinyFont
                                color: Style.lightLabelColor
                                wrapMode: Label.WordWrap
                                text: dataTagName
                            }

                            Loader {
                                Layout.fillWidth: true

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

                                    Custom.TextInput {
                                        Layout.fillWidth: true
                                        font: Style.semiBoldTinyFont
                                        color: Style.lightLabelColor
                                        wrapMode: Label.WordWrap
                                        readOnly: true

                                        text:
                                        {
                                            switch (dataTagType)
                                            {
                                            case DataTag.Type.Text:
                                                return submittedText

                                            case DataTag.Type.Number:
                                                return submittedNumber

                                            case DataTag.Type.Area:
                                                return submittedArea
                                            }

                                            return ""
                                        }
                                    }
                                }

                                Component {
                                    id: photoDelegate

                                    Pane {
                                        id: thumbnailPane
                                        Layout.fillWidth: true
                                        padding: 10

                                        background: Rectangle {
                                            implicitHeight: 120
                                            color: "#F7F9FB"
                                            radius: 7
                                        }

                                        contentItem: ListView {
                                            id: thumbnailListView
                                            width: thumbnailPane.availableWidth
                                            height: thumbnailPane.availableHeight
                                            boundsBehavior: ListView.DragOverBounds
                                            orientation: ListView.Horizontal
                                            spacing: 10
                                            clip: true

                                            model: submittedPhotos

                                            delegate: Image {
                                                width: 100
                                                height: ListView.view.height
                                                source: session.apiUrl + modelData.file
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        PullToRefreshHandler {
            target: taskDetailsFlickable
            refreshIndicatorDelegate: RefreshIndicator {
                Material.accent: Style.accentColor
            }

            onPullDownRelease: {
                reloadData()
            }
        }
    }
}
