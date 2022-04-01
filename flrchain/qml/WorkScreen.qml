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
import QtGraphicalEffects 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Popups" as Popups

Page {
    id: workScreen
    property bool photoVisible: false
    property int projectId: -1
    property int taskId: -1
    property string taskName: ""
    property string projectName: ""
    property string photoPath: ""

    Connections {
        target: dataManager

        function onDisplayPhoto(filePath){
            img.source =  "file:///" + filePath
            busyIndicator.visible = false
            photoPath = filePath
        }

        function onPhotoError(){
            busyIndicator.visible = false
        }

        function onProcessingPhoto(){
            busyIndicator.visible = true
            photoVisible = true
        }

        function onWorkAdded(taskName, projectName){
            workSuccessPopup.taskName = taskName
            workSuccessPopup.projectName = projectName
            workSuccessPopup.open()
        }
    }

    Connections {
        target: pageManager
        function onSetupWorkScreen(projectId, taskId, projectName, taskName){
            workScreen.projectId = projectId
            workScreen.taskId = taskId
            workScreen.projectName = projectName
            workScreen.taskName = taskName
        }

        function onBeforePopBack(){
            if(photoVisible){
                dataManager.removeCurrentWorkPhoto()
            }
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
        title: qsTr("Earn rewards")
    }

    Flickable {
        anchors {
            fill: parent
            topMargin: Style.baseMargin
        }
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.smallMargin
                rightMargin: Style.smallMargin
                topMargin: Style.bigMargin
                bottomMargin: Style.smallMargin
            }

            Label {
                text: projectName
                font.pixelSize: Style.hugeFontPixelSize
                color: Style.darkLabelColor
            }

            Label {
                text: taskName
                font.pixelSize: Style.largeFontPixelSize
                color: Style.darkLabelColor
            }

            Custom.ShadowedRectangle {
                Layout.preferredHeight: childrenRect.height
                Layout.fillWidth: true
                Layout.topMargin: Style.bigMargin

                Rectangle {
                    anchors.fill: parent
                    color: Style.backgroundColor
                    radius: Style.rectangleRadius
                }

                ColumnLayout{
                    id: col
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: Style.baseMargin
                        bottomMargin: Style.bigMargin
                    }
                    spacing: Style.baseMargin

                    Label {
                        Layout.topMargin: Style.baseMargin
                        text: qsTr("Photo")
                        font.pixelSize: Style.tinyFontPixelSize
                        color: Style.darkLabelColor
                        font.weight: Font.DemiBold
                    }

                    Custom.ImageButton {
                        Layout.alignment: Qt.AlignHCenter
                        backgroundColor: Style.inputBackgroundColor
                        text: qsTr("Upload from gallery...")
                        visible: !photoVisible
                        iconSource: "qrc:/img/icon-upload.svg"

                        onClicked: {
                            platform.selectFile();
                        }
                    }

                    Custom.ImageButton {
                        Layout.alignment: Qt.AlignHCenter
                        backgroundColor: Style.inputBackgroundColor
                        visible: !photoVisible
                        text: qsTr("Take photo...")
                        iconSource: "qrc:/img/icon-camera.svg"
                        onClicked: {
                            platform.capture()
                        }
                    }

                    Custom.RoundedImage {
                        id: img
                        visible: photoVisible
                        Layout.fillWidth: true
                        Layout.preferredHeight: Style.workImgHeight

                        Custom.IconButton {
                            id: closeButton
                            anchors {
                                right: parent.right
                                top: parent.top
                                margins: Style.microMargin
                            }
                            iconSize: Qt.size(Style.iconUltra, Style.iconUltra)
                            iconSource: "qrc:/img/icon-delete.svg"
                            visible: !busyIndicator.visible
                            onClicked: {
                                img.source = ""
                                photoVisible = false
                                dataManager.removeCurrentWorkPhoto()
                            }
                        }

                        Custom.BusyIndicator {
                            id: busyIndicator
                            anchors.centerIn: img
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                    Custom.PrimaryButton {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.bottomMargin: Style.bigMargin
                        enabled: photoVisible && !busyIndicator.visible
                        opacity: enabled ? 1 : 0.5

                        text: qsTr("Upload")
                        onClicked: {
                            if(session.internetConnection){
                                session.sendWorkRequest(photoPath, projectId, taskId)
                            } else {
                                pageManager.enterErrorPopup("No Internet Connection")
                            }
                        }
                    }
                }
            }
        }
    }
}
