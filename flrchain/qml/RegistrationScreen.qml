import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {

    Connections{
        target: session
        function onRegistrationError(error){
            log.text = qsTr("Registration error")
            log.text = error
        }
    }

    function validateData(){
        if(!name.text.length || !surname.text.length || !userEmail.text.length
                || !password.text.length  || !repeatPassword.text.length) {
            log.text = qsTr("Please fill all fields")
            return
        }
        else if(password.text !== repeatPassword.text) {
            log.text = qsTr("Passwords are not equal")
            return
        }

        session.registerUser(userEmail, password)
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 30
        width: parent.width * 0.9
        spacing: 50

        Text {
            text: "Create an account"
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: name
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            placeholderText: "First name"
        }

        TextField {
            id: surname
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            placeholderText: "Last name"
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

        TextField {
            id: repeatPassword
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            placeholderText: "Repeat password"
            echoMode: TextInput.PasswordEchoOnEdit
        }

        TextArea {
            id: log
            readOnly: true
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Button {
            id: registerButton
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            text: qsTr("Sign Up")

            onClicked: {
                validateData()
            }
        }

        Item{
            Layout.preferredHeight: 50
            Layout.fillWidth: true
        }

        Button {
            id: loginButton
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            text: qsTr("Already have an account?")

            onClicked: {
                page.source = "qrc:/LoginScreen.qml"
            }
        }
    }
}
