import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {

    property bool errorMode: false

    Connections{
        target: session
        function onRegistrationError(error){
            errorMode = true
            errorLabel.text = error
        }

        function onRegistrationSuccessful(){
            pageManager.enterLoginScreen();
        }
    }

    function validateData(){
        if(!name.text.length || !surname.text.length || !userEmail.text.length
                || !password.text.length  || !repeatPassword.text.length) {
            errorLabel.text = qsTr("Please fill out all fields")
            return
        }
        else if(password.text !== repeatPassword.text) {
            errorLabel.text = qsTr("Passwords are not equal")
            return
        }

        session.registerUser(userEmail.text, password.text, name.text,
                             surname.text, phone.text, villageName.text)
    }

    Rectangle {
        id: background
        color: Style.shadowedBgColor
        anchors.fill: parent

        Flickable {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                topMargin: Style.baseMargin
            }
            contentHeight: mainColumn.height
            boundsBehavior: Flickable.StopAtBounds

            ColumnLayout {
                id: mainColumn
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Style.smallMargin
                    rightMargin: Style.smallMargin
                }
                Image {
                    id: logo
                    source: "qrc:/img/logo-login.svg"
                    Layout.topMargin: Style.bigMargin
                    Layout.preferredWidth: Style.logoWidth
                    Layout.preferredHeight: Style.logoHeight
                    Layout.alignment: Qt.AlignHCenter
                    sourceSize: Qt.size(Style.logoWidth, Style.logoHeight)
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.topMargin: Style.bigMargin
                    Layout.bottomMargin: Style.smallMargin
                    Layout.preferredHeight: childrenRect.height

                    color: Style.bgColor
                    radius: Style.baseRadius
                    ColumnLayout{
                        anchors {
                            left: parent.left
                            right: parent.right
                            margins: Style.baseMargin
                        }
                        spacing: Style.smallMargin

                        Label {
                            Layout.topMargin: Style.baseMargin
                            text: qsTr("Register")
                            font.pixelSize: Style.fontLarge
                            color: Style.accentColor
                        }

                        Label {
                            text: qsTr("Fill the form, make sure it is correct")
                            font.pixelSize: Style.fontTiny
                            font.weight: Font.DemiBold
                            color: Style.baseLabelColor
                            Layout.topMargin: -Style.tinyMargin
                        }

                        Rectangle {
                            color: Style.grayBgColor
                            height: Style.separatorHeight
                            Layout.fillWidth: true
                            Layout.leftMargin: -Style.baseMargin
                            Layout.rightMargin: -Style.baseMargin
                        }

                        Label {
                            text: qsTr("First name")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: name
                            Layout.topMargin: -Style.tinyMargin
                            placeholderText: qsTr("First name")
                        }

                        Label {
                            text: qsTr("Last name")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: surname
                            Layout.topMargin: -Style.tinyMargin
                            placeholderText: qsTr("Last name")
                        }

                        Label {
                            text: qsTr("Email")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: userEmail
                            Layout.topMargin: -Style.tinyMargin
                            placeholderText: qsTr("Email")
                            color: errorMode ? Style.errorColor : Style.darkLabelColor
                            onTextChanged: {
                                if(errorMode){
                                    errorMode = false
                                    errorLabel.text = ""
                                }
                            }
                        }

                        Label {
                            text: qsTr("Phone")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: phone
                            Layout.topMargin: -Style.tinyMargin
                            placeholderText: qsTr("Phone")
                        }

                        Label {
                            text: qsTr("Village name")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: villageName
                            Layout.topMargin: -Style.tinyMargin
                            placeholderText: qsTr("Village name")
                        }

                        Label {
                            text: qsTr("Password")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: password
                            Layout.topMargin: -Style.tinyMargin
                            echoMode: TextInput.Password
                            placeholderText: qsTr("Password")
                        }

                        Label {
                            text: qsTr("Re-password")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: repeatPassword
                            Layout.topMargin: -Style.tinyMargin
                            echoMode: TextInput.Password
                            placeholderText: qsTr("Repeat password")
                        }

                        Label {
                            id: errorLabel
                            font.pixelSize: Style.fontTiny
                            font.weight: Font.DemiBold
                            color: Style.errorColor
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
                            bgColor: Style.buttonSecColor

                            onClicked: {
                                pageManager.enterLoginScreen()
                            }
                        }

                        Label {
                            text: qsTr("By creating this account, you agree with our")
                            font.pixelSize: Style.fontTiny
                            color: Style.grayLabelColor
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Label {
                            text: qsTr("Terms & Conditions")
                            font.pixelSize: Style.fontTiny
                            color: Style.accentColor
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: -Style.tinyMargin
                            Layout.bottomMargin: Style.baseMargin
                        }
                    }
                }
            }
        }
    }
}
