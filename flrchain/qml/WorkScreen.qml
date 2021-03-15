import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {
    id: workScreen
    property bool photoVisible: false
    property int projectId: -1
    property int taskId: -1
    property string taskName: ""
    property string projectName: ""

    Connections{
        target: dataManager

        function onDisplayPhoto(filePath){
            img.source =  "file:///" + filePath
            photoVisible = true
        }

        function onPhotoError(){
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
    }

    Custom.Header {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        title: qsTr("Earn rewards")
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
            anchors.leftMargin: Style.bigMargin
            anchors.rightMargin: Style.bigMargin
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
                        spacing: 20

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

                            onClicked: {
                                platform.selectFile();
                            }
                        }

                        Custom.ImageButton{
                            Layout.alignment: Qt.AlignHCenter
                            bgColor: Style.inputBgColor
                            visible: !photoVisible
                            text: qsTr("Take photo...")
                            onClicked: {
                                platform.capture()
                            }
                        }

                        Image {
                            id: img
                            visible: photoVisible
                            Layout.fillWidth: true
                            Layout.preferredHeight: 200
                            Layout.alignment: Qt.AlignHCenter
                            fillMode: Image.PreserveAspectCrop

                            Custom.IconButton {
                                id: closeButton
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.margins: 10
                                width: 30
                                height: 30
                                iconSize: 30
                                iconSrc: ""
                                onClicked: {
                                    img.source = ""
                                    photoVisible = false
                                }
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
                            }
                        }
                    }
                }
            }
        }
    }
}
