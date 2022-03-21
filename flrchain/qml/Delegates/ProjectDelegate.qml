import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Custom.Pane {
    id: root
    padding: Style.projectListDelegatePadding

    readonly property bool joined: assignmentStatus === Project.Joined
    readonly property bool undefinedStatus: assignmentStatus === Project.Undefined
    readonly property bool investmentOngoing: status === Project.InvestmentOngoing
    readonly property bool investmentFinished: status === Project.InvestmentFinished

    readonly property color investmentStatusColor: investmentOngoing ? Style.accentColor
                                                                     : investmentFinished ? Style.errorColor
                                                                                          : Style.yellowLabelColor

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
                text: model.name
            }

            Item { Layout.fillWidth: true }

            Custom.StatusLabel {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                status: model.assignmentStatus
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
                text: String("%1: %2").arg(qsTr("Closes")).arg(model.deadline)
            }

            Item { Layout.fillWidth: true }

            Label {
                id: investmentStatusLabel
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                font: Style.projectListDelegateDateFont
                color: investmentStatusColor
                text: investmentOngoing ? qsTr("Ongoing")
                                        : investmentFinished ? qsTr("Finished")
                                                             : qsTr("Pending")
            }

            Rectangle {
                id: investmentStatusIndicator
                Layout.preferredWidth: Style.investmentStatusIndicatorSize.width
                Layout.preferredHeight: Style.investmentStatusIndicatorSize.height
                radius: Style.investmentStatusIndicatorRadius
                color: investmentStatusColor
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
                text: model.description
            }
        }

        Custom.PrimaryButton {
            Layout.fillWidth: true
            backgroundColor: !investmentFinished && (joined || undefinedStatus) ? Style.accentColor : Style.buttonSecColor
            text: !investmentFinished ? undefinedStatus ? qsTr("Join") : joined && investmentOngoing ? qsTr("Earn reward") : qsTr("Details") : qsTr("Details")

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
