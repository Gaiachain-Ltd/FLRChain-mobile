import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/CustomControls" as Custom

Item {

    Connections{
        target: session
        function onLoginError(error){
            log.text = qsTr("Login error")
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
                Layout.preferredHeight: 0.65 * mainWindow.height
                color: "white"
                radius: 7

                ColumnLayout{
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Label {
                        text: qsTr("Login")
                        font.pixelSize: 20
                        color: "#23BC3D"
                    }

                    Label {
                        text: qsTr("Welcome back")
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
                        id: userEmail
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("Please enter your email...")
                    }

                    Custom.TextInput {
                        id: password
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        placeholderText: qsTr("Please enter your password...")
                        echoMode: TextInput.Password
                    }

                    Custom.CheckBox {
                        checked: session.getRememberMe()
                        text: qsTr("Remember me")
                        onCheckedChanged: {
                            session.setRememberMe(checked)
                        }
                    }

                    TextArea {
                        id: log
                        readOnly: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    Custom.Button {
                        id: signInButton
                        Layout.fillWidth: true
                        Layout.preferredHeight: 42
                        enabled: userEmail.text.length && password.text.length
                        text: qsTr("Log In")

                        onClicked: {
                            session.login(userEmail.text, password.text)
                        }
                    }

                    Custom.Button {
                        id: registerButton
                        Layout.fillWidth: true
                        Layout.preferredHeight: 42
                        text: qsTr("Need an account?")
                        bgColor: "#06BCC1"

                        onClicked: {
                            stack.pushPage("qrc:/RegistrationScreen.qml");
                        }
                    }

                    Label {
                        text: qsTr("Forgot password?")
                        font.pixelSize: 12
                        color: "#23BC3D"
                        Layout.alignment: Qt.AlignHCenter
                    }

                }
            }
        }
    }
}
