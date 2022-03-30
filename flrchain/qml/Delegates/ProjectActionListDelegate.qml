import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0
import SortFilterProxyModel 0.2

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates

Pane {
    id: root
    padding: 0
    background: null

    property int actionNumber
    property string actionName
    property var actionMilestones

    contentItem: ColumnLayout {
        width: parent.availableWidth
        spacing: 5

        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            Label {
                font: Qt.font({family: Style.appFontFamily, styleName: "Regular", pixelSize: 16})
                color: "#414D55"
                text: String("%1 %2: ").arg(qsTr("FLR Action")).arg(root.actionNumber)
            }

            Label {
                Layout.fillWidth: true
                font: Qt.font({family: Style.appFontFamily, styleName: "SemiBold", pixelSize: 16})
                color: "#414D55"
                wrapMode: Label.WordWrap
                text: root.actionName
            }
        }

        ListView {
            Layout.fillWidth: true
            Layout.preferredHeight: contentHeight
            spacing: 20
            interactive: false

            model: SortFilterProxyModel {
                sourceModel: root.actionMilestones
                filters: [
                    ValueFilter {
                        enabled: showFavouritesOnly
                        roleName: "milestoneHasFavouriteTask"
                        value: true
                    }
                ]
            }

            delegate: Delegates.ProjectMilestoneListDelegate {
                width: ListView.view.width
                actionNumber: root.actionNumber
                milestoneNumber: model.index + 1
                milestoneName: model.milestoneName
                milestoneTasks: model.milestoneTasks
            }
        }
    }
}
