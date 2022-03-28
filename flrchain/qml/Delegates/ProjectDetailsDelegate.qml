import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom

Pane {
    id: root
    topPadding: Style.projectDetailsPanePadding
    bottomPadding: Style.projectDetailsPanePadding
    leftPadding: Style.projectDetailsPanePadding
    rightPadding: Style.projectDetailsPanePadding

    property alias button: joinButton

    property date deadline: null
    property string description: ""
    property url photo: ""
    property int status: Project.ProjectStatus.Undefined
    property int assignmentStatus: Project.AssignmentStatus.Undefined

    readonly property bool investmentActive: status === Project.ProjectStatus.Active
    readonly property bool investmentClosed: status === Project.ProjectStatus.Closed

    background: Custom.ShadowedRectangle {
        color: Style.paneBackgroundColor
        radius: Style.paneBackgroundRadius
        shadowHorizontalOffset: Style.paneShadowHorizontalOffset
        shadowVerticalOffset: Style.paneShadowVerticalOffset
        shadowRadius: Style.paneShadowRadius
        shadowColor: Style.paneShadowColor

        Custom.StatusLabel {
            anchors {
                top: parent.top
                topMargin: root.topPadding
                right: parent.right
                rightMargin: root.rightPadding
            }
            status: assignmentStatus
        }
    }

    ColumnLayout {
        width: availableWidth
        height: availableHeight
        spacing: Style.projectDetailsContentSpacing

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: Style.projectDetailsSectionSpacing

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Project deadline")
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: Style.iconSize
                spacing: Style.projectDetailsSectionSpacing

                Image {
                    Layout.preferredWidth: Style.iconSize
                    Layout.preferredHeight: Style.iconSize
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    sourceSize: Qt.size(width, height)
                    source: "qrc:/img/icon-calendar.svg"
                }

                Label {
                    id: deadlineLabel
                    Layout.fillWidth: true
                    font: Style.projectDetailsPaneContentFont
                    color: Style.projectDetailsPaneContentFontColor
                    wrapMode: Label.WordWrap
                    text: deadline.toLocaleString(Qt.locale(), "MMMM dd, yyyy")
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: Style.projectDetailsSectionSpacing

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Project status")
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: Style.iconSize
                spacing: Style.projectDetailsSectionSpacing

                Label {
                    id: projectStatusLabel
                    font: Style.projectDetailsPaneContentFont
                    color: Style.projectDetailsPaneContentFontColor
                    wrapMode: Label.WordWrap
                    text:
                    {
                        switch (status) {
                            case Project.ProjectStatus.Fundraising:
                                return qsTr("Fundraising")

                            case Project.ProjectStatus.Active:
                                return qsTr("Active")

                            case Project.ProjectStatus.Closed:
                                return qsTr("Closed")
                        }

                        console.warn("Could not set proper text for project status label:", status)
                        return ""
                    }
                }

                Rectangle {
                    id: projectStatusIndicator
                    Layout.preferredWidth: Style.iconSize
                    Layout.preferredHeight: Style.iconSize
                    radius: Style.investmentStatusIndicatorRadius
                    color:
                    {
                        switch (status) {
                            case Project.ProjectStatus.Fundraising:
                                return Style.projectFundraisingColor

                            case Project.ProjectStatus.Active:
                                return Style.projectActiveColor

                            case Project.ProjectStatus.Closed:
                                return Style.projectClosedColor
                        }

                        console.warn("Could not set proper color for project status label:", status)
                        return "#FFFFFF"
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: Style.projectDetailsSectionSpacing

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Description")
            }

            Label {
                id: descriptionLabel
                Layout.fillWidth: true
                font: Style.projectDetailsPaneContentFont
                color: Style.projectDetailsPaneContentFontColor
                wrapMode: Text.WordWrap
                text: description
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: Style.projectDetailsSectionSpacing
            visible: projectImage.status == Image.Ready

            Label {
                Layout.fillWidth: true
                font: Style.projectDetailsPaneSectionTitleFont
                color: Style.projectDetailsPaneSectionTitleFontColor
                wrapMode: Label.WordWrap
                text: qsTr("Photo")
            }

            Image {
                id: projectImage
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: photo
            }
        }

        Custom.PrimaryButton {
            id: joinButton
            Layout.fillWidth: true
            text: qsTr("Join")
            visible: !investmentClosed && assignmentStatus === Project.AssignmentStatus.New
        }
    }
}
