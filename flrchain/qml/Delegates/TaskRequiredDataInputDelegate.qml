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

ColumnLayout {
    id: root

    Label {
        Layout.fillWidth: true
        font: Style.semiBoldTinyFont
        color: Style.lightLabelColor
        wrapMode: Label.WordWrap
        text: dataTagName
    }

    Loader {
        Layout.fillWidth: true

        sourceComponent:
        {
            switch (dataTagType)
            {
                case DataTag.Type.Text:
                    return inputTextComponent

                case DataTag.Type.Number:
                    return numberInputComponent

                case DataTag.Type.Area:
                    return areaTextComponent
            }

            return null
        }
    }

    Component {
        id: inputTextComponent

        Custom.TextInput {
            placeholderText: qsTr("Type text...")
        }
    }

    Component {
        id: numberInputComponent

        Custom.TextInput {
            placeholderText: qsTr("Type number...")
            inputMethodHints: Qt.ImhDigitsOnly
        }
    }

    Component {
        id: areaTextComponent

        Custom.TextInput {
            placeholderText: qsTr("Type area...")
        }
    }
}
