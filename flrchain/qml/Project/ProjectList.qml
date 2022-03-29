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
