import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Popups" as Popups

Item {
    id: workScreen
    property bool photoVisible: false
    property int projectId: -1
    property int taskId: -1
    property string taskName: ""
    property string projectName: ""
    property string photoPath: ""

    Connections{
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

    Connections{
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

    Custom.Header {
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        title: qsTr("Earn rewards")
    }

    Popups.WorkSuccessPopup {
        id: workSuccessPopup

    }

    Rectangle {
        id: background
        color: Style.bgColor
        anchors.fill: parent

        Flickable {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
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
                    font.pixelSize: Style.fontUltra
                    color: Style.darkLabelColor
                }

                Label {
                    text: taskName
                    font.pixelSize: Style.fontBig
                    color: Style.darkLabelColor
                }

                Custom.ShadowedRectangle {
                    Layout.preferredHeight: childrenRect.height
                    Layout.fillWidth: true
                    Layout.topMargin: Style.bigMargin

                    Rectangle {
                        anchors.fill: parent
                        color: Style.bgColor
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
                            font.pixelSize: Style.fontTiny
                            color: Style.darkLabelColor
                            font.weight: Font.DemiBold
                        }

                        Custom.ImageButton{
                            Layout.alignment: Qt.AlignHCenter
                            bgColor: Style.inputBgColor
                            text: qsTr("Upload from gallery...")
                            visible: !photoVisible
                            iconSrc: "qrc:/img/icon-upload.svg"

                            onClicked: {
                                platform.selectFile();
                            }
                        }

                        Custom.ImageButton{
                            Layout.alignment: Qt.AlignHCenter
                            bgColor: Style.inputBgColor
                            visible: !photoVisible
                            text: qsTr("Take photo...")
                            iconSrc: "qrc:/img/icon-camera.svg"
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
                                iconSize: Style.iconUltra
                                iconSrc: "qrc:/img/icon-delete.svg"
                                visible: !busyIndicator.visible
                                onClicked: {
                                    img.source = ""
                                    photoVisible = false
                                    dataManager.removeCurrentWorkPhoto()
                                }
                            }

                            BusyIndicator {
                                id: busyIndicator
                                anchors.centerIn: img
                                running: true
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Custom.Button{
                            Layout.alignment: Qt.AlignHCenter
                            Layout.bottomMargin: Style.bigMargin
                            enabled: photoVisible && !busyIndicator.visible
                            opacity: enabled ? 1 : 0.5

                            text: qsTr("Upload")
                            onClicked: {
                                if(session.internetConnection){
                                    session.sendWorkRequest(photoPath, projectId, taskId)
                                }
                                else{
                                    pageManager.enterErrorPopup("No Internet Connection")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
