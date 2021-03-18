import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

Item {
    id: detailsScreen
    property int itemId: -1
    property string projectName: ""
    property string projectDeadline: ""
    property string projectDescription: ""
    property string projectStartDate: ""
    property string projectEndDate: ""
    property string projectStatus: ""
    property int projectAssignmentStatus: Project.Undefined
    property var tasks

    Connections{
        target: pageManager
        function onSetupProjectDetailsScreen(projectId){
            itemId = dataManager.projects[projectId].id
            projectName = dataManager.projects[projectId].name
            tasks = dataManager.projects[projectId].tasks
            projectDeadline = dataManager.projects[projectId].deadline
            projectDescription = dataManager.projects[projectId].description
            projectStartDate = dataManager.projects[projectId].investmentStart
            projectEndDate = dataManager.projects[projectId].investmentEnd
            projectStatus = dataManager.projects[projectId].status
            projectAssignmentStatus = dataManager.projects[projectId].assignmentStatus
        }
    }

    Connections{
        target: dataManager
        function onJoinRequestSent(projectId){
            if(projectId === itemId){
                projectAssignmentStatus = Project.Pending
            }
        }
    }

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
                text: projectName
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Delegates.ProjectDetailsDelegate{
                deadline: projectDeadline
                description: projectDescription
                startDate: projectStartDate
                status: projectStatus
                endDate: projectEndDate
                assignmentStatus: projectAssignmentStatus

                Layout.topMargin: Style.baseMargin
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                button.onClicked: {
                    joinPopup.open()
                }
            }

            Label {
                Layout.topMargin: Style.baseMargin
                text: qsTr("Tasks (%1)").arg(tasksList.count)
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            ListView {
                id: tasksList
                model: tasks
                interactive: false

                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                spacing: 20

                delegate: Delegates.TaskDelegate {
                    taskItem: tasks[index]
                    projectName: detailsScreen.projectName
                    width: parent.width
                    buttonVisible: projectAssignmentStatus === Project.Joined && projectStatus === "Ongoing"
                }
            }

            Label {
                Layout.topMargin: Style.baseMargin
                text: qsTr("Work history")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Delegates.BalanceDelegate {
                Layout.fillWidth: true
                buttonVisible: false
                title: qsTr("Total rewards")
                value: 30
            }

            Custom.ShadowedRectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                Layout.bottomMargin: Style.baseMargin
                Layout.topMargin: Style.tinyMargin

                Rectangle{
                    id: contentRect
                    width: parent.width
                    height: childrenRect.height
                    color: Style.bgColor
                    radius: 10

                    ColumnLayout {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: Style.baseMargin
                        anchors.rightMargin: Style.baseMargin
                        spacing: 20

                        Label{
                            Layout.topMargin: Style.baseMargin
                            font.pixelSize: Style.fontSmall
                            font.weight: Font.DemiBold
                            text: qsTr("Earned rewards")
                            color: Style.accentColor
                        }

                        Rectangle {
                            color: Style.sectionColor
                            Layout.preferredHeight: 1
                            Layout.fillWidth: true
                            Layout.leftMargin: -Style.baseMargin
                            Layout.rightMargin: -Style.baseMargin
                        }

                        ListView {
                            id: workList
                            model: exampleModel
                            interactive: false

                            Layout.fillWidth: true
                            Layout.preferredHeight: contentHeight
                            spacing: 20

                            delegate: Delegates.WorkDelegate {
                                width: parent.width
                            }
                        }
                        Item{
                            Layout.fillWidth: true
                        }

                    }
                }
            }
        }
    }

    Popups.JoinProjectPopup {
        id: joinPopup
        projectId: itemId
        projectName: detailsScreen.projectName
    }

    ListModel {
        id: exampleModel

        ListElement {
        }
        ListElement {
        }
        ListElement {
        }
    }
}
