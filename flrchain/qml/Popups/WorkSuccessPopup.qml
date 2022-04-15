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

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Successfully added")
    iconSource: "qrc:/img/icon-success.svg"

    property string taskName: ""
    property string projectName: ""

    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        spacing: 0

        Label {
            Layout.fillWidth: true
            horizontalAlignment: Label.AlignHCenter
            font: Style.regularSmallFont
            color: Style.darkLabelColor
            wrapMode: Label.WordWrap
            text: String("%1: %2").arg(qsTr("The work for project")).arg(projectName)
        }

        Label {
            Layout.fillWidth: true
            horizontalAlignment: Label.AlignHCenter
            font: Style.regularSmallFont
            color: Style.darkLabelColor
            wrapMode: Label.WordWrap
            text: String("%1: %2").arg(qsTr("in task")).arg(taskName)
        }

        Label {
            Layout.fillWidth: true
            horizontalAlignment: Label.AlignHCenter
            font: Style.regularSmallFont
            color: Style.darkLabelColor
            wrapMode: Label.WordWrap
            text: qsTr("has been successfully added")
        }
    }

    buttons: Custom.PrimaryButton {
        Layout.fillWidth: true
        text: qsTr("Back to project")

        onClicked: {
            popup.close()
            pageManager.back()
        }
    }
}
