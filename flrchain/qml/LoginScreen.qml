import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

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
            pageManager.enterDashboardScreen();
        }
    }

    Rectangle {
        id: background
        color: Style.shadowedBgColor
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: Style.bigMargin
            anchors.rightMargin: Style.bigMargin
            anchors.topMargin: Style.baseMargin
            anchors.bottomMargin: 16

            Image {
                id: logo
                source: "qrc:/img/logo-login.svg"
                Layout.preferredWidth: 120
                Layout.preferredHeight: 42
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Qt.size(128,42)
            }

            Image {
                id: logoImg
                source: "qrc:/img/trees-login.svg"
                Layout.preferredWidth: 298
                Layout.fillHeight: true
                Layout.maximumHeight: 140
                Layout.preferredHeight: 140
                Layout.topMargin: Style.baseMargin
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Qt.size(298, 141)
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.topMargin: Style.smallMargin
                Layout.preferredHeight: childrenRect.height

                color: Style.bgColor
                radius: 7

                ColumnLayout{
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: Style.baseMargin
                    spacing: 15

                    Label {
                        Layout.topMargin: Style.baseMargin
                        text: qsTr("Login")
                        font.pixelSize: Style.fontLarge
                        color: Style.accentColor
                    }

                    Label {
                        Layout.topMargin: -Style.smallMargin
                        text: qsTr("Welcome back")
                        font.pixelSize: Style.fontTiny
                        font.weight: Font.DemiBold
                        color: Style.baseLabelColor
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.leftMargin: -Style.baseMargin
                        Layout.rightMargin: -Style.baseMargin
                        color: Style.grayBgColor
                        height: 2
                    }

                    Custom.TextInput {
                        id: userEmail
                        placeholderText: qsTr("Please enter your email...")
                        color: errorMode ? Style.errorColor : Style.darkLabelColor
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
                        color: errorMode ? Style.errorColor : Style.darkLabelColor
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
                        font.pixelSize: Style.fontTiny
                        color: Style.errorColor
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
                        bgColor: Style.buttonSecColor

                        onClicked: {
                            pageManager.enterRegistrationScreen()
                        }
                    }

                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.bottomMargin: Style.baseMargin
                        text: qsTr("Forgot password?")
                        font.pixelSize: Style.fontTiny
                        color: Style.accentColor
                    }

                }
            }
        }
    }
}
