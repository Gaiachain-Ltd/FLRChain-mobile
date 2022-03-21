import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates

Page {
    id: root

    property double walletBalance: 0.0
    property int projectsCount: 0

    Component.onCompleted: {
        session.getWalletBalance()
        session.getProjectsData()
    }

    Connections {
        target: dataManager

        function onWalletBalanceReceived(balance) {
            walletBalance = balance
        }
    }

    Connections {
        target: projectsModel

        function onProjectsReceived(){
            projectsCount = projectsModel.rowCount()
        }
    }

    Connections {
        target: pageManager

        function onBackTriggered(){
            session.getWalletBalance()
            session.getProjectsData()
        }
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        backButtonVisible: false
        title: qsTr("Dashboard")
    }

    Flickable {
        anchors {
            fill: parent
            topMargin: Style.dashboardListTopMargin
        }
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.dashboardListSideMargin
                rightMargin: Style.dashboardListSideMargin
            }
            spacing: Style.dashboardListDelegateSpacing

            Delegates.DashboardDelegate {
                Layout.fillWidth: true

                primaryLabelText: qsTr("Earn rewards")
                secondaryLabelText: String("%1 ").arg(projectsCount) + qsTr("projects")
                iconSource: "qrc:/img/dashboard-earn-rewards.svg"

                onClicked: {
                    pageManager.enterProjectListScreen()
                }
            }

            Delegates.DashboardDelegate {
                Layout.fillWidth: true

                primaryLabelText: qsTr("My wallet")
                secondaryLabelText: qsTr("Balance") + String(": %1 USDC").arg(walletBalance)
                iconSource: "qrc:/img/dashboard-wallet.svg"

                onClicked: {
                    pageManager.enterWalletScreen()
                }
            }

            Delegates.DashboardDelegate {
                Layout.fillWidth: true

                primaryLabelText: qsTr("My profile")
                secondaryLabelText: session && session.user ? session.user.firstName + " " + session.user.lastName : ""
                iconSource: "qrc:/img/dashboard-my-profile.svg"

                onClicked: {
                    // TODO: open my profile page
                    console.warn("TODO: not implemented!")
                }
            }
        }
    }
}
