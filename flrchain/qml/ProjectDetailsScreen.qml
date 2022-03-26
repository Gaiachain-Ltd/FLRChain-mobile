import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

Page {
    id: detailsScreen
    property int itemId: -1
    property string projectName: ""
    property string projectDeadline: ""
    property string projectDescription: ""
    property string projectStartDate: ""
    property string projectEndDate: ""
    property bool projectInvestmentConfirmed: false
    property int projectStatus: Project.ProjectStatus.Undefined
    property int projectAssignmentStatus: Project.AssignmentStatus.Undefined
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

    Connections {
        target: pageManager
        function onSetupProjectDetailsScreen(projectId){
            session.getProjectDetails(projectId)
        }

        function onBackTriggered(){
            busyIndicator.visible = true
            session.getProjectDetails(itemId)
        }
    }

    Connections {
        target: dataManager
        function onProjectDetailsReceived(project){
            itemId = project.id
            projectName = project.name
            projectDeadline = project.deadline
            projectDescription = project.description
            projectStartDate = project.investmentStart
            projectEndDate = project.investmentEnd
            projectStatus = project.status
            projectAssignmentStatus = project.assignmentStatus
            projectInvestmentConfirmed = project.confirmed
            session.getWorkData(itemId)
        }

        function onJoinRequestSent(projectId){
            if(projectId === itemId){
                session.getProjectDetails(projectId)
            }
        }
    }

    Connections {
        target: workModel

        function onWorkReceived(rewardsBalance){
            if(workModel.rowCount() === 0){
                busyIndicator.visible = false
                return;
            }
            workBalance = rewardsBalance
        }

        function onWorkUpdated(){
            busyIndicator.visible = false;
        }
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Project Details")
    }

    Flickable {
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        anchors.fill: parent
        contentHeight: mainColumn.height
        visible: !busyIndicator.visible

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.smallMargin
                rightMargin: Style.smallMargin
            }
            spacing: Style.baseMargin

            Label {
                id: title
                Layout.topMargin: Style.bigMargin
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
                Layout.topMargin: Style.tinyMargin
                text: qsTr("Tasks (%1)").arg(tasksList.count)
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            ListView {
                id: tasksList
//                model: tasksModel
                interactive: false

                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                spacing: Style.baseMargin

                delegate: Delegates.TaskDelegate {
                    projectName: detailsScreen.projectName
                    projectInvestmentConfirmed: detailsScreen.projectInvestmentConfirmed
                    width: mainColumn.width
                    buttonVisible: projectAssignmentStatus === Project.AssignmentStatus.Accepted &&
                                   projectStatus === Project.ProjectStatus.Active
                }
            }

            ColumnLayout{
                id: workColumn
                Layout.fillWidth: true
                spacing: Style.baseMargin
                visible: workList.count !== 0

                RowLayout {
                    spacing: Style.microMargin
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.bigMargin
                    Layout.topMargin: Style.tinyMargin
                    Label {
                        text: qsTr("Work history")
                        font.pixelSize: Style.fontUltra
                        color: Style.darkLabelColor
                    }

                    Item{
                        Layout.fillWidth: true
                        Layout.preferredHeight: Style.tinyMargin
                    }

                    Image {
                        source: "qrc:/img/icon-accepted-total.svg"
                        asynchronous: true
                        Layout.preferredWidth: Style.iconMedium
                        Layout.preferredHeight: Style.iconMedium
                        fillMode: Image.PreserveAspectFit
                        sourceSize: Qt.size(width, height)
                    }

                    Label{
                        font.pixelSize: Style.fontBig
                        font.weight: Font.DemiBold
                        text: workList.count
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
                    Layout.preferredHeight: workContainer.height

                    Layout.topMargin: Style.tinyMargin

                    Rectangle{
                        id: contentRect
                        width: parent.width
                        height: workContainer.height
                        color: Style.bgColor
                        radius: Style.rectangleRadius

                        ColumnLayout {
                            id: workContainer
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
                                Layout.preferredHeight: Style.borderWidth
                                Layout.fillWidth: true
                                Layout.leftMargin: -Style.baseMargin
                                Layout.rightMargin: -Style.baseMargin
                            }

                            ListView {
                                id: workList
                                model: workModel
                                interactive: false

                                Layout.fillWidth: true
                                Layout.preferredHeight: contentHeight
                                spacing: Style.baseMargin

                                delegate: Delegates.WorkDelegate {
                                    width: workContainer.width
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
