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
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        title: qsTr("Earn rewards")
    }

    Popups.WorkSuccessPopup {
        id: workSuccessPopup

    }

    Rectangle {
        id: background
        color: Style.bgColor
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: Style.baseMargin
            anchors.rightMargin: Style.baseMargin
            anchors.topMargin: Style.baseMargin
            anchors.bottomMargin: 16

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
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.topMargin: Style.bigMargin

                Rectangle{
                    anchors.fill: parent
                    color: Style.bgColor
                    radius: 10

                    ColumnLayout{
                        anchors.fill: parent
                        anchors.margins: Style.baseMargin
                        anchors.bottomMargin: Style.bigMargin
                        spacing: Style.baseMargin

                        Label {
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
                            Layout.preferredHeight: 200

                            Custom.IconButton {
                                id: closeButton
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.margins: 5
                                width: 40
                                height: 40
                                iconSize: 30
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
                            enabled: photoVisible
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
