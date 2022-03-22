import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/Popups" as Popups

ApplicationWindow {
    id: mainWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    color: Style.bgColor

    onClosing: {
        close.accepted = false;
        pageManager.back()
    }

    Component.onCompleted: {
        session.getUserInfo()
    }

    Menu { id: menu }

    Popups.ConfirmLogoutPopup { id: logoutPopup }
    Popups.ErrorPopup { id: errorPopup }
    Popups.SuccessPopup { id: successPopup }

    PagesView {
        id: stack
        anchors.fill: parent
    }

    FontLoader { source: "qrc:/font/OpenSans-Bold.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-BoldItalic.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-ExtraBold.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-ExtraBoldItalic.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-Italic.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-Light.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-LightItalic.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-Medium.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-MediumItalic.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-Regular.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-SemiBold.ttf" }
    FontLoader { source: "qrc:/font/OpenSans-SemiBoldItalic.ttf" }
}
