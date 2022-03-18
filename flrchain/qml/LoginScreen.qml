import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Page {

    property bool errorMode: false

    Connections {
        target: session

        function onLoginError(error) {
            errorLabel.text = error
            errorMode = true
        }

        function onLoginSuccessful(token) {
            session.getUserInfo()
            pageManager.enterDashboardScreen()
        }
    }

    background: Rectangle {
        color: Style.loginPageBackgroundColor
    }

    Flickable {
        anchors {
            fill: parent
            leftMargin: Style.loginPageSideMargin
            rightMargin: Style.loginPageSideMargin
        }
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds

        ColumnLayout {
            id: mainColumn
            width: parent.width
            spacing: Style.loginPageSpacing

            Image {
                Layout.topMargin: Style.loginPageTopMargin
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Style.loginPageLogoSize
                source: "qrc:/img/logo-login.svg"
            }

            Image {
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Style.loginPageIconSize
                source: "qrc:/img/dashboard-earn-rewards.svg"
            }

            Custom.FormPane {
                Layout.fillWidth: true
                Layout.bottomMargin: 20
                title: qsTr("Login")
                subtitle: qsTr("Welcome Back!")

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Email")
                    }

                    Custom.TextInput {
                        id: userEmailInput
                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                        placeholderText: qsTr("Please enter your email...")
                        inputMethodHints: Qt.ImhEmailCharactersOnly | Qt.ImhLowercaseOnly
                        isValid: !errorMode

                        onTextEdited: {
                            if(errorMode) {
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }
                }

                Column {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        font: Style.loginPanelInputTitleFont
                        color: Style.loginPanelInputTitleFontColor
                        text: qsTr("Password")
                    }

                    Custom.TextInput {
                        id: passwordInput
                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                        placeholderText: qsTr("Please enter your password...")
                        echoMode: TextInput.Password
                        isValid: !errorMode

                        onTextEdited: {
                            if(errorMode){
                                errorMode = false
                                errorLabel.text = ""
                            }
                        }
                    }
                }

                Custom.CheckBox {
                    checked: session.getRememberMe()
                    text: qsTr("Remember me")

                    onToggled: {
                        if (session) {
                            session.setRememberMe(checked)
                        }
                    }
                }

                Label {
                    id: errorLabel
                    Layout.fillWidth: true
                    font: Style.loginPanelErrorMessageFont
                    color: Style.loginPanelErrorMessageFontColor
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                Custom.PrimaryButton {
                    id: signInButton
                    Layout.fillWidth: true
                    enabled: userEmailInput.text.length && passwordInput.text.length
                    text: qsTr("Log In")

                    onClicked: {
                        session.login(userEmailInput.text, passwordInput.text)
                    }
                }

                Custom.SecondaryButton {
                    id: registerButton
                    Layout.fillWidth: true
                    text: qsTr("Register")

                    onClicked: {
                        pageManager.enterRegistrationScreen()
                    }
                }

                Label {
                    Layout.alignment: Qt.AlignHCenter
                    font: Style.loginPanelForgotPasswordFont
                    color: Style.loginPanelForgotPasswordColor
                    text: qsTr("Forgot password?")

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            // TODO
                            console.warn("TODO: not implemented!")
                        }
                    }
                }
            }
        }
    }
}
