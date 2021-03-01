import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {

    Connections{
        target: dataManager

        function onDisplayPhoto(filePath){
            img.source =  qsTr("file:///") + filePath

        }

        function onPhotoError(){
            log.text = "File error"
        }

    }

    Rectangle{
        anchors.fill: parent
        anchors.bottomMargin: 50
        anchors.topMargin: 50
        anchors.leftMargin: 40
        anchors.rightMargin: 40
        color: "#E5E6EC"
        radius: 10

        ColumnLayout{

            anchors.fill: parent
            Button{
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: 110
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("Upload photo")

                onClicked: {
                    platform.selectFile();
                }
            }

            Button{
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: 110
                Layout.alignment: Qt.AlignHCenter

                text: qsTr("Take photo")
                onClicked: {
                    platform.capture()
                }
            }

            Image {
                id: img
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: parent.height * 0.4
                Layout.alignment: Qt.AlignHCenter
                fillMode: Image.PreserveAspectCrop
            }

            Text{
                id: log
                text: ""
            }
        }
    }
}
