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
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Custom.Pane {
    id: root
    topPadding: Style.projectListDelegatePadding
    bottomPadding: Style.projectListDelegatePadding
    leftPadding: Style.projectListDelegatePadding
    rightPadding: Style.projectListDelegatePadding
    contentSpacing: Style.projectListDelegateSpacing

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false

        Label {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            font: Style.projectListDelegateNameFont
            color: Style.projectListDelegateNameFontColor
            wrapMode: Label.WrapAtWordBoundaryOrAnywhere
            text: projectName
        }

        Custom.StatusLabel {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            status: projectAssignmentStatus
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
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
            text: String("%1: %2").arg(qsTr("Closes")).arg(projectEndDate.toLocaleString(Qt.locale(), "MMMM dd, yyyy"))
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

                    case Project.ProjectStatus.Undefined:
                        return ""
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

                    case Project.ProjectStatus.Undefined:
                        return Style.backgroundColor
                }

                console.warn("Could not set proper color for project status label:", projectStatus)
                return Style.backgroundColor
            }
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        spacing: Style.projectListDelegateDescriptionSpacing

        Label {
            font: Style.projectListDelegateDescriptionTitleFont
            color: Style.projectListDelegateFontColor
            text: qsTr("Description")
        }

        Label {
            id: descriptionLabel
            Layout.fillWidth: true
            font: Style.projectListDelegateDescriptionFont
            color: Style.projectListDelegateFontColor
            wrapMode: Label.WrapAtWordBoundaryOrAnywhere
            text: projectDescription
        }
    }

    Custom.PrimaryButton {
        Layout.fillWidth: true
        text: qsTr("Details")

        onClicked: {
            if (!session.user.optedIn) {
                // refresh user info to see if blockchain is ready
                session.getUserInfo()
            }

            pageManager.enterProjectDetailsScreen(projectId)
        }
    }
}
