import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

Page {
    id: root

    readonly property Project project: dataManager.detailedProject
    readonly property int projectId: project ? project.id : -1
    readonly property string projectName: project ? project.name : "N/A"
    readonly property string projectDescription: project ? project.description : "N/A"
    readonly property string projectPhoto: project ? project.photo : null
    readonly property date projectStartDate: project ? project.startDate : new Date
    readonly property date projectEndDate: project ? project.endDate : new Date
    readonly property int projectStatus: project ? project.status : Project.ProjectStatus.Undefined
    readonly property int projectAssignmentStatus: project ? project.assignmentStatus : Project.AssignmentStatus.Undefined
    readonly property var projectActions: project ? project.actions : []

    readonly property bool projectIsActive: projectStatus === Project.ProjectStatus.Active
    readonly property bool userHasJoined: projectAssignmentStatus === Project.AssignmentStatus.Accepted

    property bool projectInvestmentConfirmed: false
    property var tasks
    property var workData
    property double workBalance: 0.0

    Custom.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }

    Popups.JoinProjectPopup {
        id: joinPopup
        projectId: root.projectId
        projectName: root.projectName
    }

    Component.onCompleted: {
        busyIndicator.visible = true
    }

    Connections {
        target: pageManager

        function onSetupProjectDetailsScreen(projectId) {
            dataManager.loadProjectDetails(projectId)
        }

        function onBackTriggered() {
            busyIndicator.visible = true
            session.getProjectDetails(projectId)
        }
    }

    Connections {
        target: dataManager

        function onDetailedProjectChanged() {
            session.getWorkData(root.projectId)
        }

        function onJoinRequestSent(projectId) {
            if (projectId === projectId) {
                session.getProjectDetails(projectId)
            }
        }
    }

    Connections {
        target: workModel

        function onWorkReceived(rewardsBalance) {
            if (workModel.rowCount() === 0) {
                busyIndicator.visible = false
                return;
            }
            workBalance = rewardsBalance
        }

        function onWorkUpdated() {
            busyIndicator.visible = false
        }
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Project Details")
    }

    Flickable {
        anchors.fill: parent
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        visible: !busyIndicator.visible

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.projectDetailsSideMargins
                rightMargin: Style.projectDetailsSideMargins
            }
            spacing: Style.projectDetailsContentSpacing

            Label {
                id: title
                Layout.topMargin: Style.projectDetailsTopBottomMargin
                font: Style.projectDetailsTitleFont
                color: Style.projectDetailsTitleFontColor
                wrapMode: Label.WordWrap
                text: projectName
            }

            Delegates.ProjectDetailsDelegate {
                Layout.fillWidth: true

                deadline: projectEndDate
                description: projectDescription
                status: projectStatus
                assignmentStatus: projectAssignmentStatus
                photo: projectPhoto

                button.onClicked: {
                    console.log(projectEndDate.toLocaleString(Qt.locale(), "MMMM dd, yyyy"))

                    if (session.internetConnection) {
                        joinPopup.open()
                    } else {
                        pageManager.enterErrorPopup("No Internet Connection")
                    }
                }
            }

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsTitleFont
                color: Style.projectDetailsTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Tasks")
            }

            ListView {
                id: projectActionsList
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                Layout.bottomMargin: Style.projectDetailsTopBottomMargin
                spacing: 20
                interactive: false
                model: projectActions

                delegate: Delegates.ProjectActionListDelegate {
                    width: ListView.view.width
                    actionName: model.actionName
                    actionNumber: model.index + 1
                    actionMilestones: model.actionMilestones
                }
            }
        }
    }
}
