import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {

    Connections{
        target: session
        function onLoginError(error){
            log.text = qsTr("Login error")
        }
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 30
        width: parent.width * 0.9
        spacing: 50
        Text {
            text: "Sign In With Email"
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: userEmail
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            placeholderText: "Email"
        }

        TextField {
            id: password
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            placeholderText: "Password"
            echoMode: TextInput.PasswordEchoOnEdit
        }

        CheckBox {
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

        Button {
            id: signInButton
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            enabled: userEmail.text.length && password.text.length
            text: qsTr("Sign In")

            onClicked: {
                session.login(userEmail.text, password.text)
            }
        }

        Item{
            Layout.preferredHeight: 50
            Layout.fillWidth: true
        }

        Button {
            id: registerButton
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            text: qsTr("Need an account?")

            onClicked: {
                page.source = "qrc:/RegistrationScreen.qml"
            }
        }
    }
}
