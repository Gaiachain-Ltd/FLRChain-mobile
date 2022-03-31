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

    Row {
        Layout.alignment: Qt.AlignHCenter

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.smallFontPixelSize
            font.weight: Font.DemiBold
            color: Style.darkLabelColor
            text: qsTr("The work for project: ")
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -Style.smallMargin
            font.pointSize: Style.smallFontPixelSize
            color: Style.darkLabelColor
            font.weight: Font.Bold
            text: projectName
        }
    }

    Row {
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: -Style.baseMargin

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.smallFontPixelSize
            font.weight: Font.DemiBold
            color: Style.darkLabelColor
            text: qsTr("in task: ")
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -Style.smallMargin
            font.pointSize: Style.smallFontPixelSize
            color: Style.darkLabelColor
            font.weight: Font.Bold
            text: taskName
        }
    }

    Label {
        Layout.topMargin: -Style.baseMargin
        Layout.alignment: Qt.AlignHCenter
        font.pointSize: Style.smallFontPixelSize
        font.weight: Font.DemiBold
        color: Style.darkLabelColor
        text: qsTr("has been successfully added")
    }

    Custom.PrimaryButton {
        text: qsTr("Back to project")
        Layout.fillWidth: true

        onClicked: {
            popup.close()
            pageManager.back()
        }
    }

    Item {
        Layout.fillWidth: true
    }
}
