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
                    topMargin: Style.baseMargin
                    bottomMargin: Style.smallMargin
                }
                Item{
                    Layout.fillHeight: true
                    Layout.preferredHeight: Style.ultraMargin
                    Layout.maximumHeight: Style.ultraMargin
                    Layout.fillWidth: true
                }

                Image {
                    id: logo
                    source: "qrc:/img/logo-login.svg"
                    Layout.preferredWidth: Style.logoWidth
                    Layout.preferredHeight: Style.logoHeight
                    Layout.alignment: Qt.AlignHCenter
                    sourceSize: Qt.size(Style.logoWidth, Style.logoHeight)
                }

                Image {
                    id: logoImg
                    source: "qrc:/img/trees-login.svg"
                    Layout.preferredWidth: 298
                    Layout.preferredHeight: 140
                    Layout.topMargin: Style.baseMargin
                    Layout.alignment: Qt.AlignHCenter
                    sourceSize: Qt.size(298, 140)
                }

                Rectangle {
                    Layout.fillWidth: true
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
                            text: qsTr("Login")
                            font.pixelSize: Style.fontLarge
                            color: Style.accentColor
                        }

                        Label {
                            Layout.topMargin: -Style.tinyMargin
                            text: qsTr("Welcome Back!")
                            font.pixelSize: Style.fontTiny
                            font.weight: Font.DemiBold
                            color: Style.baseLabelColor
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.leftMargin: -Style.baseMargin
                            Layout.rightMargin: -Style.baseMargin
                            color: Style.grayBgColor
                            height: Style.separatorHeight
                        }

                        Label {
                            text: qsTr("Email")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: userEmail
                            Layout.topMargin: -Style.tinyMargin
                            placeholderText: qsTr("Please enter your email...")
                            color: errorMode ? Style.errorColor : Style.darkLabelColor
                            onTextChanged: {
                                if(errorMode) {
                                    errorMode = false
                                    errorLabel.text = ""
                                }
                            }
                        }

                        Label {
                            text: qsTr("Password")
                            font.pixelSize: Style.fontMicro
                            color: Style.mediumLabelColor
                        }

                        Custom.TextInput {
                            id: password
                            Layout.topMargin: -Style.tinyMargin
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

                        Label {
                            id: errorLabel
                            Layout.topMargin: -Style.smallMargin
                            Layout.fillWidth: true
                            font.pixelSize: Style.fontTiny
                            font.weight: Font.DemiBold
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
                            text: qsTr("Register")
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
}
