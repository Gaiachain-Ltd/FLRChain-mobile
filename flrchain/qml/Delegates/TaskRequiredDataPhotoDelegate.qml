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

    property bool errorMode: false;
    readonly property bool hasValidData: thumbnailListView.count > 0
    readonly property alias photosModel: thumbnailListView.model

    function photos() {
        let photosArray = []

        for (let i = 0; i < photosModel.count; ++i) {
            photosArray.push(photosModel.get(i).photoUrl)
        }

        return photosArray
    }

    Component.onDestruction: {
        photosModel.clear()
    }

    Connections {
        target: dataManager

        function onDisplayPhoto(filePath) {
            photosModel.append({photoUrl: "file:/" + filePath})
        }
    }

    Label {
        Layout.fillWidth: true
        font: Style.semiBoldTinyFont
        color: Style.lightLabelColor
        wrapMode: Label.WordWrap
        text: dataTagName + "*"
    }

    Pane {
        id: thumbnailPane
        Layout.fillWidth: true
        padding: 10

        background: Rectangle {
            implicitHeight: 120
            color: "#F7F9FB"
            radius: 7
            border.color: "red"
            border.width: errorMode ? 1 : 0
        }

        contentItem: ListView {
            id: thumbnailListView
            width: thumbnailPane.availableWidth
            height: thumbnailPane.availableHeight
            boundsBehavior: ListView.StopAtBounds
            orientation: ListView.Horizontal
            spacing: 10
            clip: true

            model: ListModel {}

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
                        photosModel.remove(index)
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
                errorMode = false;
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
                errorMode = false;
                platform.selectFile()
            }
        }
    }
}
