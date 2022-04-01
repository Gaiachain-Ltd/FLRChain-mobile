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
import QtGraphicalEffects 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Column {
    spacing: Style.baseMargin
    property bool separatorVisible: true

    Rectangle {
        color: "transparent"
        height: Style.workImgHeight
        width: parent.width
        radius: Style.rectangleRadius

        Custom.RoundedImage {
            id: img
            source: localPath !== "" ? "file:///" + localPath : localPath
            anchors.fill: parent
        }

        Rectangle{
            anchors {
                bottom: parent.top
                bottomMargin: -Style.tinyMargin
                left: parent.left
                leftMargin: Style.baseMargin
            }
            height: Style.statusLabelHeight
            width: childrenRect.width + Style.baseMargin
            color: Style.accentColor
            radius: Style.labelRadius

            Image {
                id: iconAccepted
                anchors.left: parent.left
                anchors.leftMargin: Style.tinyMargin
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/img/icon-accepted.svg"
                asynchronous: true
                width: 13
                height: 10
                fillMode: Image.PreserveAspectFit
                sourceSize: Qt.size(width, height)
            }

            Label{
                anchors.left: iconAccepted.right
                anchors.leftMargin: Style.tinyMargin
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Style.tinyFontPixelSize
                font.weight: Font.DemiBold
                text: qsTr("Accepted")
                color: Style.backgroundColor
            }
        }

        Rectangle{
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            height: Style.iconButtonHeight
            width: rewardLabel.width + Style.baseMargin
            color: Style.accentColor
            radius: Style.labelRadius

            Label{
                id: rewardLabel
                anchors.centerIn: parent
                font.pixelSize: Style.largeFontPixelSize
                font.weight: Font.Bold
                text: qsTr("%1 USDC").arg(amount)
                color: Style.backgroundColor
            }
        }
    }

    RowLayout {
        spacing: Style.microMargin
        width: parent.width
        height: Style.iconSize
        Image {
            source: "qrc:/img/icon-calendar.svg"
            asynchronous: true
            Layout.preferredWidth: Style.iconSize
            Layout.preferredHeight: Style.iconSize
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(width, height)
        }

        Label{
            font.pixelSize: Style.tinyFontPixelSize
            font.weight: Font.DemiBold
            text: date
            color: Style.lightLabelColor
        }

        Item{
            Layout.fillWidth: true
        }
    }

    Rectangle{
        height: Style.borderWidth
        width: parent.width
        color: Style.sectionColor
        visible: separatorVisible
    }
}
