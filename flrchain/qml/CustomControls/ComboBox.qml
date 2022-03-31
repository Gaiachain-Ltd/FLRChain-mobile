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
import QtQuick.Window 2.15
import com.flrchain.style 1.0

Controls.ComboBox {
    id: control
    font: Style.comboBoxFont
    padding: Style.comboBoxPadding
    topPadding: 0
    bottomPadding: 0

    background: Rectangle {
        implicitHeight: Style.comboBoxItemHeight
        color: Style.comboBoxBackgroundColor
        radius: Style.comboBoxBackgroundRadius
    }

    contentItem: Controls.TextField {
        background: null
        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        font: control.font
        color: Style.comboBoxCurrentTextFontColor
        horizontalAlignment: Controls.TextField.AlignHCenter
        verticalAlignment: Controls.TextField.AlignVCenter
        text: control.editable ? control.editText : control.displayText
    }

    popup.bottomPadding: Style.comboBoxPadding
    popup.background: Rectangle {
        color: Style.comboBoxBackgroundColor
        radius: Style.comboBoxBackgroundRadius

        Rectangle {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: -parent.radius
            }
            height: 2 * parent.radius
            color: parent.color
        }
    }
    popup.contentItem: ListView {
        clip: true
        implicitHeight: contentHeight
        model: control.delegateModel
        currentIndex: control.highlightedIndex
        highlightMoveDuration: 0
        spacing: Style.comboBoxItemSpacing
    }

    delegate: Controls.ItemDelegate {
        anchors.horizontalCenter: parent.horizontalCenter
        width: ListView.view.width - control.leftPadding - control.rightPadding
        font: control.font
        palette.text: Style.comboBoxDelegateTextFontColor
        palette.highlightedText: Style.comboBoxDelegateTextFontColor
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData

        background: Rectangle {
            implicitHeight: Style.comboBoxItemHeight
        }
    }

    indicator: Image {
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        rotation: control.down ? 180 : 0
        sourceSize: Qt.size(15, 8)
        source: "qrc:/img/dropdown-arrow-down.svg"
    }
}
