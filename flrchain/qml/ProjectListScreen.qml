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
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        title: qsTr("Earn rewards")
    }

    Flickable {
        id: flick
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        visible: !busyIndicator.visible

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.smallMargin
                rightMargin: Style.smallMargin
            }
            height: listView.contentHeight + 80

            spacing: Style.baseMargin

            Label {
                Layout.topMargin: Style.baseMargin
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
                spacing: Style.baseMargin

                delegate: Delegates.ProjectDelegate {
                    projectItem: listView.model[index]
                    projectIndex: index
                }
            }
        }
    }
}
