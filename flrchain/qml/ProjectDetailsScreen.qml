import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

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
            anchors.leftMargin: Style.baseMargin
            anchors.rightMargin: Style.baseMargin
            spacing: 20

            Label {
                id: title
                Layout.topMargin: Style.baseMargin
                text: qsTr("Eum Repellendus Aut")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Delegates.ProjectDetailsDelegate{
                Layout.topMargin: Style.baseMargin
                Layout.fillWidth: true
            }

            Label {
                Layout.topMargin: Style.baseMargin
                text: qsTr("Tasks (2)")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Delegates.TaskDelegate {
                Layout.fillWidth: true

            }

            Label {
                Layout.topMargin: Style.baseMargin
                text: qsTr("Work history")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Delegates.WorkDelegate {
                Layout.fillWidth: true

            }
        }
    }
}
