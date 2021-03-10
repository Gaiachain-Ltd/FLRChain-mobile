import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

Item {

    Custom.Header {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        title: qsTr("Project Details")
    }

    Flickable {
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: mainColumn.height

        ColumnLayout {
            id: mainColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Style.baseMargin
            anchors.rightMargin: Style.baseMargin
            spacing: 20

            Label {
                id: title
                Layout.topMargin: Style.baseMargin
                text: qsTr("Eum Repellendus Aut")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Delegates.ProjectDetailsDelegate{
                Layout.topMargin: Style.baseMargin
                Layout.fillWidth: true
                button.onClicked: {
                    joinPopup.open()
                }
            }

            Label {
                Layout.topMargin: Style.baseMargin
                text: qsTr("Tasks (2)")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            ListView {
                id: tasksList
                model: exampleModel
                interactive: false

                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                spacing: 20

                delegate: Delegates.TaskDelegate {
                    width: parent.width
                }
            }

            Label {
                Layout.topMargin: Style.baseMargin
                text: qsTr("Work history")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Delegates.BalanceDelegate {
                Layout.fillWidth: true
                buttonVisible: false
                title: qsTr("Total rewards")
                value: 30
            }

            Custom.ShadowedRectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                Layout.bottomMargin: Style.baseMargin
                Layout.topMargin: Style.smallMargin

                Rectangle{
                    id: contentRect
                    width: parent.width
                    height: childrenRect.height
                    color: Style.bgColor
                    radius: 10

                    ColumnLayout {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: Style.baseMargin
                        anchors.rightMargin: Style.baseMargin
                        spacing: 20

                        Label{
                            Layout.topMargin: Style.baseMargin
                            font.pixelSize: Style.fontSmall
                            font.weight: Font.DemiBold
                            text: qsTr("Earned rewards")
                            color: Style.accentColor
                        }

                        Rectangle {
                            color: Style.sectionColor
                            Layout.preferredHeight: 1
                            Layout.fillWidth: true
                            Layout.leftMargin: -Style.baseMargin
                            Layout.rightMargin: -Style.baseMargin
                        }

                        ListView {
                            id: workList
                            model: exampleModel
                            interactive: false

                            Layout.fillWidth: true
                            Layout.preferredHeight: contentHeight
                            spacing: 20

                            delegate: Delegates.WorkDelegate {
                                width: parent.width
                            }
                        }
                        Item{
                            Layout.fillWidth: true
                        }

                    }
                }
            }
        }
    }

    Popups.JoinProjectPopup{
        id: joinPopup
    }

    ListModel {
        id: exampleModel

        ListElement {
        }
        ListElement {
        }
        ListElement {
        }
    }
}
