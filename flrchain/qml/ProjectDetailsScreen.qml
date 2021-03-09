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
        title: qsTr("Project Details")
    }

    Flickable {
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: mainColumn.height

        ColumnLayout {
            id: mainColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 20

            Label {
                id: title
                Layout.topMargin: 20
                text: qsTr("Eum Repellendus Aut")
                font.pixelSize: 22
                color: "#253F50"
            }

            Delegates.ProjectDetailsDelegate{
                Layout.topMargin: 20
                Layout.fillWidth: true
            }

            Label {
                Layout.topMargin: 20
                text: qsTr("Tasks (2)")
                font.pixelSize: 22
                color: "#253F50"
            }

            Delegates.TaskDelegate {
                Layout.fillWidth: true

            }

            Label {
                Layout.topMargin: 20
                text: qsTr("Work history")
                font.pixelSize: 22
                color: "#253F50"
            }

            Delegates.WorkDelegate {
                Layout.fillWidth: true

            }
        }
    }
}
