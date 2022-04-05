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

ColumnLayout {
    id: root

    property alias photosModel: thumbnailListView.model

    signal deletePhotoAt(int index)

    Label {
        Layout.fillWidth: true
        font: Style.semiBoldTinyFont
        color: Style.lightLabelColor
        wrapMode: Label.WordWrap
        text: dataTagName
    }

    Pane {
        id: thumbnailPane
        Layout.fillWidth: true
        padding: 10

        background: Rectangle {
            implicitHeight: 120
            color: "#F7F9FB"
            radius: 7
        }

        contentItem: ListView {
            id: thumbnailListView
            width: thumbnailPane.availableWidth
            height: thumbnailPane.availableHeight
            boundsBehavior: ListView.StopAtBounds
            orientation: ListView.Horizontal
            spacing: 10
            clip: true

            delegate: Image {
                width: 100
                height: ListView.view.height
                source: modelData

                Custom.IconButton {
                    anchors {
                        top: parent.top
                        right: parent.right
                    }
                    width: 26
                    height: 26
                    iconSize: Qt.size(16, 16)
                    iconSource: "qrc:/img/icon-delete.svg"

                    onClicked: {
                        root.deletePhotoAt(index)
                    }
                }
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        spacing: 10

        Custom.SecondaryButton {
            Layout.fillWidth: true
            icon.source: "qrc:/img/icon-camera.svg"
            icon.width: 21
            icon.height: 16
            icon.color: labelColor
            font: Style.semiBoldTinyFont
            text: qsTr("Take picture")

            onClicked: {
                platform.capture()
            }
        }

        Custom.SecondaryButton {
            Layout.fillWidth: true
            icon.source: "qrc:/img/icon-gallery.svg"
            icon.width: 21
            icon.height: 16
            icon.color: labelColor
            font: Style.semiBoldTinyFont
            text: qsTr("Select from gallery")

            onClicked: {
                platform.selectFile()
            }
        }
    }
}
