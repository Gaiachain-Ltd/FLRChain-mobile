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
    property int projectStatus: Project.InvestmentUnknown
    property int projectAssignmentStatus: Project.Undefined
    property var tasks
    property var workData
    property int workBalance: 0

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: true
        visible: false
    }

    Component.onCompleted: {
        busyIndicator.visible = true
    }

    Connections{
        target: pageManager
        function onSetupProjectDetailsScreen(projectId){
            session.getProjectDetails(projectId)
            session.getWorkData(projectId)
        }

        function onBackTriggered(){
            busyIndicator.visible = true
            session.getProjectDetails(itemId)
            session.getWorkData(itemId)
        }
    }

    Connections{
        target: dataManager
        function onProjectDetailsReceived(project){
            itemId = project.id
            projectName = project.name
            tasks = project.tasks
            projectDeadline = project.deadline
            projectDescription = project.description
            projectStartDate = project.investmentStart
            projectEndDate = project.investmentEnd
            projectStatus = project.status
            projectAssignmentStatus = project.assignmentStatus
        }

        function onJoinRequestSent(projectId){
            if(projectId === itemId){
                busyIndicator.visible = true
                session.getProjectDetails(projectId)
            }
        }

        function onWorkReceived(workList, rewardsBalance){
            if(workList.length === 0){
                busyIndicator.visible = false
                return;
            }
            workData = workList
            workBalance = rewardsBalance

            for(var i = 0; i< workList.length; ++i)
            {
                session.downloadPhoto(workList[i].photoPath, workList[i].id)
            }
        }
    }

    Connections{
        target: session
        function onPhotoDownloaded(path, workId){
            for(var i = 0; i< workData.length; ++i)
            {
                if(workData[i].id === workId){
                    workData[i].localPath = "file:///" + path

                    if(i === workData.length - 1){
                        busyIndicator.visible = false
                    }
                    return;
                }
            }
        }

        function onFileDownloadError(workId){
            if(workData[workData.length - 1].id === workId){
                busyIndicator.visible = false
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
        visible: !busyIndicator.visible
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
                    buttonVisible: projectAssignmentStatus === Project.Joined && projectStatus === Project.InvestmentOngoing
                }
            }

            ColumnLayout{
                id: workColumn
                Layout.fillWidth: true
                visible: workList.count !== 0

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
                    value: workBalance
                }

                Custom.ShadowedRectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: childrenRect.height
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
                                model: workData
                                interactive: false

                                Layout.fillWidth: true
                                Layout.preferredHeight: contentHeight
                                spacing: 20

                                delegate: Delegates.WorkDelegate {
                                    width: parent.width
                                    localPhotoPath: workData[index].localPath
                                    workItem: workData[index]
                                }
                            }
                            Item{
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }
            Item{
                Layout.fillWidth: true
            }
        }
    }

    Popups.JoinProjectPopup {
        id: joinPopup
        projectId: itemId
        projectName: detailsScreen.projectName
    }
}
