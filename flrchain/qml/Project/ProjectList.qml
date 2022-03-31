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

import "qrc:/Delegates" as Delegates

Flickable {
    id: root
    contentHeight: mainColumn.height
    boundsBehavior: Flickable.StopAtBounds
    clip: true

    ColumnLayout {
        id: mainColumn
        anchors {
            left: parent.left
            leftMargin: Style.projectListSideMargins
            right: parent.right
            rightMargin: Style.projectListSideMargins
        }
        spacing: Style.baseMargin

        Label {
            Layout.topMargin: Style.bigMargin
            Layout.bottomMargin: Style.tinyMargin
            font: Style.projectListTitleFont
            color: Style.projectListTitleFontColor
            text: qsTr("Project list (%1)").arg(listView.count)
        }

        ListView {
            id: listView
            model: projectsModel
            interactive: false

            Layout.fillWidth: true
            Layout.preferredHeight: contentHeight
            Layout.bottomMargin: Style.smallMargin

            spacing: Style.baseMargin

            delegate: Delegates.ProjectDelegate {
                width: mainColumn.width
            }
        }
    }
}
