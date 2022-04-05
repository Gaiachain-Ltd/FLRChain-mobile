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
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

Controls.Popup {
    id: popup

    anchors.centerIn: parent
    implicitWidth: parent.width - 2 * Style.popupSideMargins
    topPadding: Style.popupTopBottomPadding
    bottomPadding: Style.popupTopBottomPadding
    leftPadding: Style.popupLeftRightPadding
    rightPadding: Style.popupLeftRightPadding
    modal: true
    dim: true
    focus: true

    property string title: ""
    property string iconSource: ""

    background: ShadowedRectangle {
        color: Style.popupBackgroundColor
    }

    contentItem: ColumnLayout {
        width: parent.availableWidth
        height: parent.availableHeight
        spacing: Style.popupSpacing

        Image {
            Layout.preferredWidth: Style.popupIconSize.width
            Layout.preferredHeight: Style.popupIconSize.height
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Style.popupIconSize
            source: popup.iconSource
            visible: popup.iconSource
        }

        Controls.Label {
            Layout.fillWidth: true
            horizontalAlignment: Controls.Label.AlignHCenter
            font: Style.popupTitleFont
            color: Style.popupTitleFontColor
            text: popup.title
        }
    }
}
