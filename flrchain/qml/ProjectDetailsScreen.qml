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
    property double workBalance: 0.0

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
        target: dataManager
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
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        title: qsTr("Project Details")
    }

    Flickable {
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        contentHeight: mainColumn.height
        visible: !busyIndicator.visible
        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.baseMargin
                rightMargin: Style.baseMargin
            }
            spacing: Style.baseMargin

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
                    if(session.internetConnection){
                        joinPopup.open()
                    }
                    else{
                        pageManager.enterErrorPopup("No Internet Connection")
                    }
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
                spacing: Style.baseMargin

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
                spacing: Style.baseMargin
                visible: workList.count !== 0

                RowLayout {
                    spacing: 5
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.bigMargin
                    Layout.topMargin: Style.baseMargin
                    Label {
                        text: qsTr("Work history")
                        font.pixelSize: Style.fontUltra
                        color: Style.darkLabelColor
                    }

                    Item{
                        Layout.fillWidth: true
                    }

                    Image {
                        source: "qrc:/img/icon-accepted-total.svg"
                        asynchronous: true
                        Layout.preferredWidth: 20
                        Layout.preferredHeight: 20
                        fillMode: Image.PreserveAspectFit
                        sourceSize: Qt.size(width, height)
                    }

                    Label{
                        font.pixelSize: Style.fontBig
                        font.weight: Font.DemiBold
                        text: workData.length
                        color: Style.accentColor
                    }
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
                            anchors {
                                left: parent.left
                                right: parent.right
                                leftMargin: Style.baseMargin
                                rightMargin: Style.baseMargin
                            }
                            spacing: Style.baseMargin

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
                                spacing: Style.baseMargin

                                delegate: Delegates.WorkDelegate {
                                    width: parent.width
                                    workItem: workData[index]
                                    separatorVisible: index !== workList.count - 1
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
