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

Rectangle {
    height: Style.internetConnectionIssueBannerHeight
    color: Style.internetConnectionIssueBannerColor

    RowLayout {
        anchors.centerIn: parent
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignVCenter
            sourceSize: Style.internetConnectionIssueIconSize
            source: "qrc:/img/icon-popup-faile.svg"
        }

        Label {
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("No Internet Connection")
            font: Style.internetConnectionIssueBannerFont
            color: Style.internetConnectionIssueLabelColor
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: Style.separatorHeight
        color: Style.separatorColor
    }
}
