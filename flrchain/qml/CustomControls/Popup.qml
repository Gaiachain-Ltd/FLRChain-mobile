import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

Controls.Popup {
    id: popup

    anchors.centerIn: parent
    implicitWidth: parent.width - 2 * Style.popupSideMargins
    topPadding: Style.popupTopBottomPadding
    bottomPadding: Style.popupTopBottomPadding
    leftPadding: Style.popupLeftRightPadding
    rightPadding: Style.popupLeftRightPadding
    modal: true
    dim: true
    focus: true

    property string title: ""
    property string iconSource: ""

    background: ShadowedRectangle {
        color: Style.popupBackgroundColor
    }

    contentItem: ColumnLayout {
        width: parent.availableWidth
        height: parent.availableHeight
        spacing: Style.popupSpacing

        Image {
            Layout.preferredWidth: Style.popupIconSize.width
            Layout.preferredHeight: Style.popupIconSize.height
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Style.popupIconSize
            source: popup.iconSource
        }

        Controls.Label {
            Layout.fillWidth: true
            horizontalAlignment: Controls.Label.AlignHCenter
            font: Style.popupTitleFont
            color: Style.popupTitleFontColor
            text: popup.title
        }
    }
}
