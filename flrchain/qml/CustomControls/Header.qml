import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Pane {
    id: root
    padding: 0

    required property string title
    property bool backButtonVisible: true

    Custom.InternetConnectionIssueBanner {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: session.internetConnection ? 0 : -height
        }

        visible: anchors.bottomMargin < 0

        Behavior on anchors.bottomMargin {
            NumberAnimation {
                duration: 500
            }
        }
    }

    Rectangle {
        id: headerContainer
        width: parent.width
        height: Style.headerHeight
        color: Style.headerBackgroundColor

        IconButton {
            id: backButton
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }
            width: Style.backButtonClickAreaWidth
            iconSize: Style.backButtonIconSize
            iconSrc: "qrc:/img/icon-back.svg"
            visible: backButtonVisible

            onClicked: {
                pageManager.back()
            }
        }

        Label {
            id: titleLabel
            anchors.centerIn: parent
            font: Style.headerTitleFont
            color: Style.headerTitleFontColor
            text: title
        }

        IconButton {
            id: menuButton
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }
            width: Style.menuButtonClickAreaWidth
            iconSize: Style.menuButtonIconSize
            iconSrc: "qrc:/img/icon-menu.svg"

            onClicked: {
                menu.open()
                session.getUserInfo()
            }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: Style.separatorHeight
            color: Style.grayBgColor
        }
    }
}
