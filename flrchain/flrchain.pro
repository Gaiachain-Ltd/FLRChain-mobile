# Copyright (C) 2022  Milo Solutions
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

include(../version.pri)

# Warning! QStringBuilder can crash your app! See last point here:
# https://www.kdab.com/uncovering-32-qt-best-practices-compile-time-clazy/
# !!!
DEFINES *= QT_USE_QSTRINGBUILDER
QMAKE_CXXFLAGS += -Werror

QT += quick core network svg
android: QT += androidextras

TEMPLATE = app
CONFIG += c++14
TARGET = FLRChain

INCLUDEPATH += \
    src \
    src/APICommunication \
    src/Models

HEADERS += \
    src/APICommunication/apimultipartrequest.h \
    src/APICommunication/requests/changepasswordrequest.h \
    src/APICommunication/requests/createactivityrequest.h \
    src/APICommunication/requests/facilitatorcashoutrequest.h \
    src/APICommunication/requests/facilitatorlistrequest.h \
    src/APICommunication/requests/mytasksrequest.h \
    src/APICommunication/requests/resetpasswordrequest.h \
    src/APICommunication/requests/saveuserinforequest.h \
    src/APICommunication/requests/sendactivityphotorequest.h \
    src/APICommunication/requests/sendworkjob.h \
    src/APICommunication/requests/walletqrcoderequest.h \
    src/Models/action.h \
    src/Models/actionmodel.h \
    src/Models/datatag.h \
    src/Models/datatagmodel.h \
    src/Models/milestone.h \
    src/Models/milestonemodel.h \
    src/Models/projectmodel.h \
    src/Models/taskmodel.h \
    src/datamanager.h \
    src/favouritetaskstorage.h \
    src/filemanager.h \
    src/session.h \
    src/settings.h \
    src/APICommunication/restapiclient.h \
    src/APICommunication/apirequest.h \
    src/APICommunication/requests/loginrequest.h \
    src/APICommunication/requests/registerrequest.h \
    src/APICommunication/requests/projectsdatarequest.h \
    src/APICommunication/requests/workdatarequest.h \
    src/APICommunication/requests/userinforequest.h \
    src/APICommunication/requests/joinprojectrequest.h \
    src/APICommunication/requests/cashoutrequest.h \
    src/APICommunication/requests/transactionhistoryrequest.h \
    src/APICommunication/requests/walletbalancerequest.h \
    src/APICommunication/requests/projectdetailsrequest.h \
    src/APICommunication/requests/getimagerequest.h \
    src/APICommunication/requests/sendworkrequest.h \
    src/platformbridgeprivate.h \
    src/platformbridge.h \
    src/Models/transactionsmodel.h \
    src/Models/workmodel.h \
    src/Models/transaction.h \
    src/Models/task.h \
    src/Models/project.h \
    src/Models/user.h \
    src/Models/work.h \
    src/types.h \
    src/AppNavigationData.h

SOURCES += src/main.cpp  \
    src/APICommunication/apimultipartrequest.cpp \
    src/APICommunication/requests/changepasswordrequest.cpp \
    src/APICommunication/requests/createactivityrequest.cpp \
    src/APICommunication/requests/facilitatorcashoutrequest.cpp \
    src/APICommunication/requests/facilitatorlistrequest.cpp \
    src/APICommunication/requests/mytasksrequest.cpp \
    src/APICommunication/requests/resetpasswordrequest.cpp \
    src/APICommunication/requests/saveuserinforequest.cpp \
    src/APICommunication/requests/sendactivityphotorequest.cpp \
    src/APICommunication/requests/sendworkjob.cpp \
    src/APICommunication/requests/walletqrcoderequest.cpp \
    src/Models/action.cpp \
    src/Models/actionmodel.cpp \
    src/Models/datatag.cpp \
    src/Models/datatagmodel.cpp \
    src/Models/milestone.cpp \
    src/Models/milestonemodel.cpp \
    src/Models/projectmodel.cpp \
    src/Models/taskmodel.cpp \
    src/datamanager.cpp \
    src/favouritetaskstorage.cpp \
    src/filemanager.cpp \
    src/session.cpp \
    src/settings.cpp \
    src/APICommunication/restapiclient.cpp \
    src/APICommunication/apirequest.cpp \
    src/APICommunication/requests/loginrequest.cpp \
    src/APICommunication/requests/registerrequest.cpp \
    src/APICommunication/requests/projectsdatarequest.cpp \
    src/APICommunication/requests/workdatarequest.cpp \
    src/APICommunication/requests/userinforequest.cpp \
    src/APICommunication/requests/joinprojectrequest.cpp \
    src/APICommunication/requests/cashoutrequest.cpp \
    src/APICommunication/requests/transactionhistoryrequest.cpp \
    src/APICommunication/requests/walletbalancerequest.cpp \
    src/APICommunication/requests/projectdetailsrequest.cpp \
    src/APICommunication/requests/getimagerequest.cpp \
    src/APICommunication/requests/sendworkrequest.cpp \
    src/platformbridgeandroid.cpp \
    src/platformbridge.cpp \
    src/Models/transactionsmodel.cpp \
    src/Models/workmodel.cpp \
    src/Models/transaction.cpp \
    src/Models/task.cpp \
    src/Models/project.cpp \
    src/Models/user.cpp \
    src/Models/work.cpp

RESOURCES +=  \
    fonts/fonts.qrc \
    qml/qml.qrc \
    images/images.qrc

OTHER_FILES += \
    ../FLRChain.doxyfile.in \
    ../README.md \
    ../.gitignore \
    ../.gitlab-ci.yml

## Platforms

## Modules

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml \
    android/src/com/application/flrchain/FLRActivity.java

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

dev {
    API_URL = "https://dev.flrchain.milosolutions.com:8000"
} else {
    API_URL = "https://flrchain.milosolutions.com:8000"
}
DEFINES += APIUrl='"\\\"$$API_URL\\\""'

include(../addons/android_openssl/openssl.pri)
include(../addons/mrestapi/mrestapi.pri)
include(../addons/SortFilterProxyModel/SortFilterProxyModel.pri)
include(../addons/qml-app-navigation/AppNavigation/AppNavigation.pri)
