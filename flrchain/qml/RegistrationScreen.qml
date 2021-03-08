import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/CustomControls" as Custom

Item {

    property bool errorMode: false

    Connections{
        target: session
        function onRegistrationError(error){
            errorMode = true
            log.text = error
        }

        function onRegistrationSuccessful(){
            stack.pushPage("qrc:/LoginScreen.qml");
        }
    }

    function validateData(){
        if(!name.text.length || !surname.text.length || !userEmail.text.length
                || !password.text.length  || !repeatPassword.text.length) {
            log.text = qsTr("Please fill out all fields")
            return
        }
        else if(password.text !== repeatPassword.text) {
            log.text = qsTr("Passwords are not equal")
            return
        }

        session.registerUser(userEmail.text, password.text)
    }

    Rectangle {
        id: background
        color: "#FAFAFD"
        anchors.fill: parent

        Flickable {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 20
            contentHeight: mainColumn.height
            boundsBehavior: Flickable.StopAtBounds
            clip: true

            ColumnLayout {
                id: mainColumn
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 30
                anchors.rightMargin: 30

                Image {
                    id: logo
                    source: ""
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 42
                    Layout.alignment: Qt.AlignHCenter
                    sourceSize: Qt.size(128,42)
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.topMargin: 30
                    Layout.bottomMargin: 16
                    Layout.preferredHeight: childrenRect.height

                    color: "white"
                    radius: 7
                    ColumnLayout{
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 20
                        spacing: 15

                        Label {
                            Layout.topMargin: 20
                            text: qsTr("Register")
                            font.pixelSize: 20
                            color: "#23BC3D"
                        }

                        Label {
                            text: qsTr("Fill the form, make sure it is correct")
                            font.pixelSize: 12
                            font.weight: Font.DemiBold
                            color: "#778699"
                            Layout.topMargin: -5
                        }

                        Rectangle {
                            color: "#E2E9F0"
                            height: 2
                            Layout.topMargin: 10
                            Layout.fillWidth: true
                            Layout.leftMargin: -20
                            Layout.rightMargin: -20
                        }


                        Custom.TextInput {
                            id: name
                            placeholderText: qsTr("First name")
                        }

                        Custom.TextInput {
                            id: surname
                            placeholderText: qsTr("Last name")
                        }

                        Custom.TextInput {
                            id: userEmail
                            placeholderText: qsTr("Email")
                            color: errorMode ? "#FE2121" : "#253F50"
                            onTextChanged: {
                                if(errorMode){
                                    errorMode = false
                                    log.text = ""
                                }
                            }
                        }

                        Custom.TextInput {
                            id: phone
                            placeholderText: qsTr("Phone")
                        }

                        Custom.TextInput {
                            id: villageName
                            placeholderText: qsTr("Village name")
                        }

                        Custom.TextInput {
                            id: password
                            echoMode: TextInput.Password
                            placeholderText: qsTr("Password")
                        }

                        Custom.TextInput {
                            id: repeatPassword
                            echoMode: TextInput.Password
                            placeholderText: qsTr("Repeat password")
                        }

                        TextArea {
                            id: log
                            readOnly: true
                            font.pixelSize: 12
                            font.weight: Font.DemiBold
                            color: "#FE2121"
                            Layout.fillWidth: true
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        }

                        Custom.Button {
                            id: registerButton
                            text: qsTr("Register")

                            onClicked: {
                                validateData()
                            }
                        }

                        Custom.Button {
                            id: loginButton
                            text: qsTr("Log in")
                            bgColor: "#06BCC1"

                            onClicked: {
                                stack.pop()
                            }
                        }

                        Label {
                            text: qsTr("By creating this account, you agree with our")
                            font.pixelSize: 12
                            color: "#606060"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Label {
                            text: qsTr("Terms & Conditions")
                            font.pixelSize: 12
                            color: "#23BC3D"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: -10
                            Layout.bottomMargin: 20
                        }
                    }
                }
            }
        }
    }

}
