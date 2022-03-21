import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

Pane {
    id: root

    property int status: Project.Undefined
    readonly property bool joined: status === Project.Joined
    readonly property bool rejected: status === Project.Rejected
    readonly property bool pending: status === Project.Pending

    topPadding: Style.assignmentStatusLabelTopBottomPadding
    bottomPadding: Style.assignmentStatusLabelTopBottomPadding
    leftPadding: Style.assignmentStatusLabelLeftRightPadding
    rightPadding: Style.assignmentStatusLabelLeftRightPadding
    visible: status !== Project.Undefined

    background: Rectangle {
        radius: Style.assignmentStatusLabelRadius
        color: root.rejected ? Style.errorColor
                             : root.joined ? Style.accentColor
                                           : Style.yellowLabelColor
    }

    Label {
        anchors.centerIn: parent
        font: Style.assignmentStatusLabelFont
        color: Style.assignmentStatusLabelFontColor
        text: rejected ? qsTr("REJECTED")
                       : joined ? qsTr("JOINED")
                                : qsTr("PENDING")
    }
}
