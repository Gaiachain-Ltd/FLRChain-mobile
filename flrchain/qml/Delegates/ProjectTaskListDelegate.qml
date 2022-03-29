import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Pane {
    id: root
    topPadding: Style.panePadding
    bottomPadding: Style.panePadding
    leftPadding: Style.panePadding
    rightPadding: Style.panePadding

    property int actionNumber
    property int milestoneNumber
    property int taskNumber
    property int taskId
    property string taskName
    property real taskReward
    property real taskBatch
    property bool taskFavourite

    background: Custom.ShadowedRectangle {
        color: Style.paneBackgroundColor
        radius: Style.paneBackgroundRadius
        shadowHorizontalOffset: Style.paneShadowHorizontalOffset
        shadowVerticalOffset: Style.paneShadowVerticalOffset
        shadowRadius: Style.paneShadowRadius
        shadowColor: Style.paneShadowColor

        RowLayout {
            id: favLayout
            anchors {
                top: parent.top
                topMargin: root.topPadding
                right: parent.right
                rightMargin: root.rightPadding
            }
            spacing: 5
            visible: userHasJoined

            Label {
                Layout.alignment: Qt.AlignVCenter
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                text: root.isFavourite ? qsTr("Remove") : qsTr("Add")
            }

            Custom.IconButton {
                Layout.alignment: Qt.AlignTop
                Layout.preferredWidth: Style.projectTaskFavouriteButtonSize.width
                Layout.preferredHeight: Style.projectTaskFavouriteButtonSize.height
                iconSize: Style.projectTaskFavouriteButtonSize
                iconSource: root.isFavourite ? "qrc:/img/icon-remove-fav.svg"
                                             : "qrc:/img/icon-add-fav.svg"

                onClicked: {
                    // TODO

                    console.warn("TODO: not implemented")
                }
            }
        }
    }

    ColumnLayout {
        width: root.availableWidth
        spacing: 10

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 5

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: String("%1 %2.%3.%4").arg(qsTr("Task")).arg(root.actionNumber).arg(root.milestoneNumber).arg(root.taskNumber)
            }

            Label {
                id: taskNameLabel
                Layout.fillWidth: true
                font: Style.projectDetailsPaneContentFont
                color: Style.projectDetailsPaneContentFontColor
                wrapMode: Label.WordWrap
                text: root.taskName
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 5

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Reward")
            }

            Label {
                id: taskRewardLabel
                Layout.fillWidth: true
                font: Style.projectDetailsPaneContentFont
                color: Style.projectDetailsPaneContentFontColor
                wrapMode: Label.WordWrap
                text: root.taskReward + " USDC"
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 5

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Batch")
            }

            Label {
                id: taskBatchLabel
                Layout.fillWidth: true
                font: Style.projectDetailsPaneContentFont
                color: Style.projectDetailsPaneContentFontColor
                wrapMode: Label.WordWrap
                text: String("%1 USDC (%2)").arg(root.taskBatch).arg(qsTr("evenly divided among all participants"))
            }
        }

        Custom.PrimaryButton {
            Layout.fillWidth: true
            visible: userHasJoined && projectIsActive
            text: qsTr("Earn reward")

            onClicked: {
                // TODO: open earn reward screen

                console.warn("TOOD: not implemented")
            }
        }
    }
}
