import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0

Rectangle {
    height: Style.internetConnectionIssueBannerHeight
    color: Style.internetConnectionIssueBannerColor

    RowLayout {
        anchors.centerIn: parent
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignVCenter
            sourceSize: Style.internetConnectionIssueIconSize
            source: "qrc:/img/icon-popup-faile.svg"
        }

        Label {
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("No Internet Connection")
            font: Style.internetConnectionIssueBannerFont
            color: Style.internetConnectionIssueLabelColor
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: Style.separatorHeight
        color: Style.grayBgColor
    }
}
