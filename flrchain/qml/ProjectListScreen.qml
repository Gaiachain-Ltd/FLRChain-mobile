import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/ProjectListPage" as ProjectListPage

Page {
    id: projectsScreen

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: true
        visible: false
    }

    Component.onCompleted: {
        busyIndicator.visible = true
        session.getProjectsData()
    }

    Connections {
        target: projectsModel

        function onProjectsReceived() {
            busyIndicator.visible = false
        }
    }

    Connections {
        target: pageManager

        function onBackTriggered() {
            busyIndicator.visible = true
            session.getProjectsData()
        }
    }

    background: null

    header: Custom.Header {
        id: header
        height: Style.headerHeight
        title: qsTr("Earn rewards")
    }

    ColumnLayout {
        anchors.fill: parent
        visible: !busyIndicator.visible

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            Layout.preferredHeight: Style.defaultTabButtonHeight
            spacing: 0

            Custom.TabButton { text: qsTr("My tasks") }
            Custom.TabButton { text: qsTr("Projects") }
        }

        StackLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: tabBar.currentIndex

            ProjectListPage.TaskList {
                Layout.leftMargin: Style.projectListSideMargins
                Layout.rightMargin: Style.projectListSideMargins
            }
            ProjectListPage.ProjectList {
                Layout.leftMargin: Style.projectListSideMargins
                Layout.rightMargin: Style.projectListSideMargins
            }
        }
    }
}
