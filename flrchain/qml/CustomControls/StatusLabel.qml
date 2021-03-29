import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

Rectangle{
    property int status: Project.Undefined
    property bool joined: status === Project.Joined
    property bool rejected: status === Project.Rejected
    property bool pending: status === Project.Pending

    height: 21
    width: label.width + Style.smallMargin
    color: rejected ? Style.errorColor : joined ? Style.accentColor : Style.yellowLabelColor
    radius: 4
    visible: status !== Project.Undefined

    Label{
        id: label
        anchors.centerIn: parent
        font.pixelSize: Style.fontTiny
        font.weight: Font.DemiBold
        text: rejected ? qsTr("Rejected") : joined ? qsTr("Joined") : qsTr("Pending request")
        color: Style.bgColor
    }
}
