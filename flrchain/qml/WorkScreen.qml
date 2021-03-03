import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/CustomControls" as Custom

Item {

    property bool photoVisible: false

    Connections{
        target: dataManager

        function onDisplayPhoto(filePath){
            img.source =  qsTr("file:///") + filePath
            photoVisible = true
        }

        function onPhotoError(){
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
        color: "white"
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 30
            anchors.rightMargin: 30
            anchors.topMargin: 20
            anchors.bottomMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: qsTr("Eum Repellendus Aut")
                font.pixelSize: 22
                color: "#253F50"
            }

            Label {
                text: qsTr("Plant Fruit trees on farmland")
                font.pixelSize: 17
                color: "#253F50"
            }

            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.topMargin: 30
                color: "white"
                radius: 10

                ColumnLayout{
                    anchors.fill: parent
                    anchors.bottomMargin: 30
                    spacing: 20

                    Label {
                        text: qsTr("Photo")
                        font.pixelSize: 12
                        color: "#253F50"
                        font.weight: Font.DemiBold
                    }

                    Custom.ImageButton{
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 42
                        Layout.alignment: Qt.AlignHCenter
                        bgColor: "#F7F9FB"
                        text: qsTr("Upload from gallery...")
                        visible: !photoVisible

                        onClicked: {
                            platform.selectFile();
                        }
                    }

                    Custom.ImageButton{
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 42
                        Layout.alignment: Qt.AlignHCenter
                        bgColor: "#F7F9FB"
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
                            iconContainerSize: 30
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
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 42
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
