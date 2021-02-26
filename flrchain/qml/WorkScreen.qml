import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {

    Connections{
        target: platform
        function onFileSelected(pathToFile){
            console.log(pathToFile)
            img.source =  qsTr("file:///") + pathToFile
        }

        function onCapturedMedia(pathToFile){
            console.log(pathToFile)
            img.source =  qsTr("file:///") + pathToFile
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
                Layout.preferredHeight: 150
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("Upload photo")

                onClicked: {
                    platform.selectFile();
                }
            }

            Button{
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: 150
                Layout.alignment: Qt.AlignHCenter

                text: qsTr("Take photo")
                onClicked: {
                    platform.capture()
                }
            }
            Image {
                id: img
                Layout.preferredWidth: parent.width * 0.9
                Layout.alignment: Qt.AlignHCenter
                sourceSize.width: 1024
                sourceSize.height: 1024
                //   fillMode: Image.PreserveAspectFit
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
