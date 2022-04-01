/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

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
    color: Style.backgroundColor

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
