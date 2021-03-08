import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/CustomControls" as Custom

Item {

    property bool errorMode: false

    Connections{
        target: session
        function onLoginError(error){
            errorLabel.text = error
            errorMode = true
        }

        function onLoginSuccessful(token){
            stack.clear();
            stack.pushPage("qrc:/Dashboard.qml");
        }
    }

    Rectangle {
        id: background
        color: "#FAFAFD"
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
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

            Image {
                id: logoImg
                source: ""
                Layout.preferredWidth: 298
                Layout.fillHeight: true
                Layout.maximumHeight: 140
                Layout.preferredHeight: 140
                Layout.topMargin: 20
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Qt.size(298, 140)
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.topMargin: 10
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
                        text: qsTr("Login")
                        font.pixelSize: 20
                        color: "#23BC3D"
                    }

                    Label {
                        Layout.topMargin: -10
                        text: qsTr("Welcome back")
                        font.pixelSize: 12
                        font.weight: Font.DemiBold
                        color: "#778699"
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.leftMargin: -20
                        Layout.rightMargin: -20
                        color: "#E2E9F0"
                        height: 2
                    }

                    Custom.TextInput {
                        id: userEmail
                        placeholderText: qsTr("Please enter your email...")
                        color: errorMode ? "#FE2121" : "#253F50"
                        onTextChanged: {
                            if(errorMode) {
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }

                    Custom.TextInput {
                        id: password
                        placeholderText: qsTr("Please enter your password...")
                        echoMode: TextInput.Password
                        color: errorMode ? "#FE2121" : "#253F50"
                        onTextChanged: {
                            if(errorMode){
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }

                    Custom.CheckBox {
                        checked: session.getRememberMe()
                        text: qsTr("Remember me")
                        onCheckedChanged: {
                            session.setRememberMe(checked)
                        }
                    }

                    TextArea {
                        id: errorLabel
                        readOnly: true
                        Layout.fillWidth: true
                        font.pixelSize: 12
                        color: "#FE2121"
                    }

                    Custom.Button {
                        id: signInButton
                        enabled: userEmail.text.length && password.text.length
                        text: qsTr("Log In")

                        onClicked: {
                            session.login(userEmail.text, password.text)
                        }
                    }

                    Custom.Button {
                        id: registerButton
                        text: qsTr("Need an account?")
                        bgColor: "#06BCC1"

                        onClicked: {
                            stack.pushPage("qrc:/RegistrationScreen.qml");
                        }
                    }

                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.bottomMargin: 20
                        text: qsTr("Forgot password?")
                        font.pixelSize: 12
                        color: "#23BC3D"
                    }

                }
            }
        }
    }
}
