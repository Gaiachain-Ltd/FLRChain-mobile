/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0
import com.milosolutions.AppNavigation 1.0

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates

AppPage {
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
                    AppNavigationController.enterPage(AppNavigation.ProjectListPage)
                }
            }

            Delegates.DashboardDelegate {
                Layout.fillWidth: true

                primaryLabelText: qsTr("My wallet")
                secondaryLabelText: qsTr("Balance") + String(": %1 USDC").arg(walletBalance)
                iconSource: "qrc:/img/dashboard-wallet.svg"

                onClicked: {
                    AppNavigationController.enterPage(AppNavigation.WalletPage)
                }
            }

            Delegates.DashboardDelegate {
                Layout.fillWidth: true

                primaryLabelText: qsTr("My profile")
                secondaryLabelText: session && session.user ? session.user.firstName + " " + session.user.lastName : ""
                iconSource: "qrc:/img/dashboard-my-profile.svg"

                onClicked: {
                    AppNavigationController.enterPage(AppNavigation.ProfilePage)
                }
            }
        }
    }
}
