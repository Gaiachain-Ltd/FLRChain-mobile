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

import "qrc:/AppNavigation"

AppPopup {
    id: popup
    anchors.centerIn: parent
    implicitWidth: parent.width - 2 * Style.popupSideMargins
    modal: true
    dim: true
    focus: true
    clip: true
    closePolicy: Controls.Dialog.NoAutoClose
    spacing: 0

    property string iconSource: ""
    default property alias content: contentColumn.data
    property alias buttons: buttonsLayout.data

    background: ShadowedRectangle {
        color: Style.popupBackgroundColor
    }

    header: Controls.Pane {
        width: popup.availableWidth
        topPadding: Style.popupLeftRightPadding
        leftPadding: Style.popupLeftRightPadding
        rightPadding: Style.popupLeftRightPadding
        background: null

        ColumnLayout {
            width: parent.width
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
                wrapMode: Controls.Label.WordWrap
                text: popup.title
            }
        }
    }

    contentItem: Controls.ScrollView {
        width: popup.availableWidth
        height: Math.min(contentHeight, popup.availableHeight - popup.header.height - popup.footer.height)
        contentWidth: availableWidth
        contentHeight: contentColumn.height
        padding: 0
        clip: true

        palette.dark: Style.accentColor
        palette.mid: Style.accentColor

        ColumnLayout {
            id: contentColumn
            width: parent.width
            spacing: Style.popupSpacing
        }
    }

    footer: Controls.Pane {
        id: popupFooter
        width: popup.width
        leftPadding: Style.popupLeftRightPadding
        rightPadding: Style.popupLeftRightPadding
        bottomPadding: Style.popupLeftRightPadding
        background: null

        contentItem: ColumnLayout {
            id: buttonsLayout
            width: popupFooter.availableWidth
            spacing: 10
        }
    }
}
