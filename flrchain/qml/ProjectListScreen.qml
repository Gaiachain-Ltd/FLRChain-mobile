import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates

Item {
    id: projectsScreen
    property var modelData

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: true
        visible: false
    }

    Connections{
        target: dataManager
        function onProjectsReceived(projects){
            modelData = projects
            busyIndicator.visible = false
        }
    }

    Component.onCompleted: {
        busyIndicator.visible = true
        session.getProjectsData()
    }

    Connections{
        target: pageManager
        function onBackTriggered(){
            busyIndicator.visible = true
            session.getProjectsData()
        }
    }

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
        anchors.topMargin: Style.baseMargin
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        visible: !busyIndicator.visible

        ColumnLayout {
            id: mainColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Style.baseMargin
            anchors.rightMargin: Style.baseMargin
            height: listView.contentHeight + 60

            spacing: 20

            Label {
                text: qsTr("Project list (%1)").arg(listView.count)
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            ListView {
                id: listView
                model: modelData
                interactive: false

                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 20

                delegate: Delegates.ProjectDelegate {
                    projectItem: listView.model[index]
                    projectIndex: index
                }
            }
        }
    }
}
