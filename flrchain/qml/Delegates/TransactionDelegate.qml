import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

ColumnLayout {
    id: root
    spacing: 0

    property string transactionProjectName
    property int transactionType
    property real transactionAmount
    property bool separatorVisible

    function signType() {
        switch(transactionType) {
        case 9:
            return "-";
        default:
            return "+";
        }
    }

    RowLayout {
        Layout.fillWidth: true

        Column {
            Label {
                id: projectNameLabel
                font: Style.transactionProjectFont
                color: Style.transactionProjectFontColor
                text: root.transactionProjectName
                visible: text.length > 0
            }

            Label {
                id: transactionTypeLabel
                font: Style.transactionTypeFont
                color: Style.transactionTypeFontColor
                text: root.transactionType == 9 ? qsTr("Cash out") : qsTr("Reward")
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Row {
            spacing: 5

            Label {
                id: amountLabel
                font: Style.transactionAmountFont
                color: root.transactionType == 9 ? Style.transactionOutgoingColor : Style.transactionIncomingColor
                text: signType() + root.transactionAmount
            }

            Label {
                font: Style.transactionCurrencyFont
                color: amountLabel.color
                text: "USDC"
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: Style.borderWidth
        Layout.topMargin: 20
        Layout.bottomMargin: 20
        color: Style.sectionColor
        visible: root.separatorVisible
    }
}
