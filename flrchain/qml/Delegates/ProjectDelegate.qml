import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Custom.Pane {
    id: root
    padding: Style.projectListDelegatePadding

    readonly property bool accepted: projectAssignmentStatus === Project.AssignmentStatus.Accepted
    readonly property bool undefinedStatus: projectAssignmentStatus === Project.AssignmentStatus.Undefined

    readonly property bool investmentFundraising: projectStatus === Project.ProjectStatus.Fundraising
    readonly property bool investmentActive: projectStatus === Project.ProjectStatus.Active
    readonly property bool investmentClosed: projectStatus === Project.ProjectStatus.Closed

    ColumnLayout {
        width: root.availableWidth
        spacing: Style.projectListDelegateSpacing

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false

            Label {
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                font: Style.projectListDelegateNameFont
                color: Style.projectListDelegateNameFontColor
                text: projectName
            }

            Item { Layout.fillWidth: true }

            Custom.StatusLabel {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                status: projectAssignmentStatus
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.iconSize
            spacing: Style.microMargin

            Image {
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.preferredWidth: Style.projectListDelegateIconSize.width
                Layout.preferredHeight: Style.projectListDelegateIconSize.height
                sourceSize: Style.projectListDelegateIconSize
                asynchronous: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/img/icon-calendar.svg"
            }

            Label {
                id: projectDeadlineLabel
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                font: Style.projectListDelegateDateFont
                color: Style.projectListDelegateFontColor
                text: String("%1: %2").arg(qsTr("Closes")).arg(projectEndDate)
            }

            Item { Layout.fillWidth: true }

            Label {
                id: investmentStatusLabel
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                font: Style.projectListDelegateDateFont
                color: "#414D55"
                text:
                {
                    switch (projectStatus) {
                    case Project.ProjectStatus.Fundraising:
                        return qsTr("Fundraising")

                    case Project.ProjectStatus.Active:
                        return qsTr("Active")

                    case Project.ProjectStatus.Closed:
                        return qsTr("Closed")
                    }

                    console.warn("Could not set proper text for project status label:", projectStatus)
                    return ""
                }
            }

            Rectangle {
                id: investmentStatusIndicator
                Layout.preferredWidth: Style.investmentStatusIndicatorSize.width
                Layout.preferredHeight: Style.investmentStatusIndicatorSize.height
                radius: Style.investmentStatusIndicatorRadius
                color:
                {
                    switch (projectStatus) {
                    case Project.ProjectStatus.Fundraising:
                        return Style.projectFundraisingColor

                    case Project.ProjectStatus.Active:
                        return Style.projectActiveColor

                    case Project.ProjectStatus.Closed:
                        return Style.projectClosedColor
                    }

                    console.warn("Could not set proper color for project status label:", projectStatus)
                    return "#FFFFFF"
                }
            }
        }

        Column {
            Layout.fillWidth: true
            spacing: Style.projectListDelegateDescriptionSpacing

            Label {
                Layout.topMargin: Style.baseMargin
                font: Style.projectListDelegateDescriptionTitleFont
                color: Style.projectListDelegateFontColor
                text: qsTr("Description")
            }

            Label {
                id: descriptionLabel
                Layout.fillWidth: true
                font: Style.projectListDelegateDescriptionFont
                color: Style.mediumLabelColor
                maximumLineCount: 3
                elide: Text.ElideRight
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: projectDescription
            }
        }

        Custom.PrimaryButton {
            Layout.fillWidth: true
            backgroundColor: !investmentClosed && (accepted || undefinedStatus) ? Style.accentColor : Style.buttonSecColor
            text: !investmentClosed ? undefinedStatus ? qsTr("Join") : accepted && investmentActive ? qsTr("Earn reward") : qsTr("Details") : qsTr("Details")

            onClicked: {
                if (!session.user.optedIn) {
                    //Refresh user info:
                    session.getUserInfo()
                }
                pageManager.enterProjectDetailsScreen(projectId)
            }
        }
    }
}
