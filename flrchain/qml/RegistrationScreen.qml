import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/CustomControls" as Custom

Item {

    Connections{
        target: session
        function onRegistrationError(error){
            // log.text = qsTr("Registration error")
            // log.text = error
        }

        function onRegistrationSuccessful(){
            stack.pushPage("qrc:/LoginScreen.qml");
        }
    }

    function validateData(){
        if(!name.text.length || !surname.text.length || !userEmail.text.length
                || !password.text.length  || !repeatPassword.text.length) {
            //  log.text = qsTr("Please fill all fields")
            return
        }
        else if(password.text !== repeatPassword.text) {
            //  log.text = qsTr("Passwords are not equal")
            return
        }

        session.registerUser(userEmail, password)
    }

    Rectangle {
        id: background
        color: "#FAFAFD"
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: 30
            anchors.rightMargin: 30
            anchors.topMargin: 20
            anchors.bottomMargin: 16

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
                Layout.topMargin: 10
                Layout.fillHeight: true

                color: "white"
                radius: 7
                ColumnLayout{
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    Label {
                        text: qsTr("Register")
                        font.pixelSize: 20
                        color: "#23BC3D"
                    }

                    Label {
                        text: qsTr("Fill the form, make sure it is correct")
                        font.pixelSize: 12
                        font.weight: Font.DemiBold
                        color: "#778699"
                        Layout.topMargin: -10
                    }

                    Rectangle {
                        color: "#E2E9F0"
                        height: 2
                        Layout.fillWidth: true
                        Layout.leftMargin: -20
                        Layout.rightMargin: -20
                    }


                    Custom.TextInput {
                        id: firstName
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("First name")
                    }

                    Custom.TextInput {
                        id: lastName
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("Last name")
                    }

                    Custom.TextInput {
                        id: email
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("Email")
                    }

                    Custom.TextInput {
                        id: phone
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("Phone")
                    }

                    Custom.TextInput {
                        id: villageName
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("Village name")
                    }

                    Custom.TextInput {
                        id: password
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("Password")
                    }

                    Custom.TextInput {
                        id: repeatPassword
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("Repeat password")
                    }

                    Custom.Button {
                        id: registerButton
                        Layout.fillWidth: true
                        Layout.preferredHeight: 42
                        text: qsTr("Register")

                        onClicked: {
                            validateData()
                        }
                    }

                    Custom.Button {
                        id: loginButton
                        Layout.fillWidth: true
                        Layout.preferredHeight: 42
                        text: qsTr("Log in")

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
                    }
                }
            }
        }
    }
}
