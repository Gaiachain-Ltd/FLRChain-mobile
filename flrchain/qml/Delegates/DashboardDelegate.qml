import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Pane {
    id: root
    implicitWidth: Style.dashboardDelegateWidth
    implicitHeight: Style.dashboardDelegateHeight

    required property string primaryLabelText
    required property string secondaryLabelText
    required property url iconSource

    signal clicked

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }

    background: Custom.ShadowedRectangle {
        // Custom gradient
        Rectangle {
            anchors.fill: parent
            radius: Style.dashboardDelegateBackgroundRadius
            color: Style.dashboardDelegateBackgroundColor
            border {
                width: Style.dashboardDelegateBackgroundBorderWidth
                color: Style.dashboardDelegateBackgroundBorderColor
            }
            layer.enabled: true
            layer.effect: LinearGradient {
                start: Qt.point(0, 0)
                end: Qt.point(width, height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Style.dashboardDelegateBackgroundGradientStartColor }
                    GradientStop { position: 1.0; color: Style.dashboardDelegateBackgroundGradientEndColor }
                }
            }
        }

        radius: Style.dashboardDelegateBackgroundRadius
        shadowHorizontalOffset: Style.dashboardDelegateShadowHorizontalOffset
        shadowVerticalOffset: Style.dashboardDelegateShadowVerticalOffset
        shadowRadius: Style.dashboardDelegateShadowRadius
        shadowColor: Style.dashboardDelegateShadowColor
    }

    RowLayout {
        anchors {
            left: parent.left
            leftMargin: Style.dashboardDelegateLeftMargin
            right: parent.right
            rightMargin: Style.dashboardDelegateRightMargin
            verticalCenter: parent.verticalCenter
        }
        spacing: 0

        ColumnLayout {
            Layout.fillWidth: false
            Layout.fillHeight: false
            spacing: 0

            Label {
                id: primaryLabel
                font: Style.dashboardDelegatePrimaryLabelFont
                color: Style.dashboardDelegatePrimaryLabelFontColor
                text: root.primaryLabelText
            }

            Label {
                id: secondaryLabel
                font: Style.dashboardDelegateSecondaryLabelFont
                color: Style.dashboardDelegateSecondaryLabelFontColor
                text: root.secondaryLabelText
            }
        }

        // spacer
        Item { Layout.fillWidth: true }

        Image {
            id: icon
            sourceSize: Style.dashboardDelegateIconSize
            source: root.iconSource
        }
    }
}
