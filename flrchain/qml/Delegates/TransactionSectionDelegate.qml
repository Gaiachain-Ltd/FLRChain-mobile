import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

ColumnLayout {
    id: root

    required property string section

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false

        Label {
            id: dateLabel
            font: Style.transactionSectionFont
            color: Style.transactionSectionFontColor
            text: root.section
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.transactionSectionSeparatorHeight
            Layout.alignment: Qt.AlignVCenter
            color: Style.transactionSectionSeparatorColor
        }
    }

    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 20
    }
}
