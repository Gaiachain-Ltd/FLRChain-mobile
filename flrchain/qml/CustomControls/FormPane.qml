import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Pane {
    id: root
    contentSpacing: Style.formPaneVerticalSpacing

    required property string title
    required property string subtitle

    Column {
        Layout.fillWidth: true
        spacing: 5

        Label {
            font: Style.formPaneTitleFont
            color: Style.formPaneTitleFontColor
            text: root.title
        }

        Label {
            font: Style.formPaneSubtitleFont
            color: Style.formPaneSubtitleFontColor
            text: root.subtitle
        }

        Item {
            width: parent.width
            height: 15

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                height: Style.separatorHeight
                color: Style.formPaneSeparatorColor
            }
        }
    }
}
