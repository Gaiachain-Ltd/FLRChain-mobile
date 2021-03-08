import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates

Item {
    Custom.Header {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        title: qsTr("Earn rewards")
    }

    Flickable {
        id: flick
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 20
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        ColumnLayout {
            id: mainColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            height: listView.contentHeight + 60

            spacing: 20

            Label {
                text: qsTr("Eum Repellendus Aut")
                font.pixelSize: 22
                color: "#253F50"
            }

            Delegates.ProjectDelegate {
                id: exampleDelegate
                Layout.fillWidth: true
            }

            ListView {
                id: listView
                model: dataManager.projects
                interactive: false

                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 20

                delegate: Delegates.ProjectDelegate {

                }
            }
        }
    }
}
