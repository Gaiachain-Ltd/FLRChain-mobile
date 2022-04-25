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

ColumnLayout {
    id: root
    spacing: 0

    property string transactionProjectName
    property int transactionType
    property real transactionAmount
    property bool separatorVisible
    property string transactionNote

    function signType() {
        return transactionType == 1 ? "+" : "-";
    }

    function label() {
        if (transactionNote.startsWith("C|F")) {
            return qsTr("To facilitator");
        } else if (transactionNote.startsWith("C|M")) {
            return qsTr("MTN");
        } else {
            return root.transactionProjectName;
        }
    }

    function rewardName() {
        if (transactionNote.startsWith("W|B")) {
            return qsTr("Batch");
        } else {
            return qsTr("Reward");
        }
    }

    RowLayout {
        Layout.fillWidth: true

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false

            Label {
                id: projectNameLabel
                Layout.fillWidth: true
                font: Style.transactionProjectFont
                color: Style.transactionProjectFontColor
                wrapMode: Label.WordWrap
                text: label()
                visible: text.length > 0
            }

            Label {
                id: transactionTypeLabel
                font: Style.transactionTypeFont
                color: Style.transactionTypeFontColor
                text: root.transactionType == 1 ? rewardName() : qsTr("Cash out")
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Row {
            spacing: 5

            Label {
                id: amountLabel
                font: Style.transactionAmountFont
                color: root.transactionType == 1 ? Style.transactionIncomingColor : Style.transactionOutgoingColor
                text: signType() + root.transactionAmount
            }

            Label {
                font: Style.transactionCurrencyFont
                color: amountLabel.color
                text: "USDC"
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: Style.borderWidth
        Layout.topMargin: 20
        Layout.bottomMargin: 20
        color: Style.sectionColor
        visible: root.separatorVisible
    }
}
