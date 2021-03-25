## Milo Solutions - project file TEMPLATE
#
#
## (c) Milo Solutions, 2016

include(../version.pri)
include(../mrestapi/mrestapi.pri)
# Warning! QStringBuilder can crash your app! See last point here:
# https://www.kdab.com/uncovering-32-qt-best-practices-compile-time-clazy/
# !!!
DEFINES *= QT_USE_QSTRINGBUILDER
QMAKE_CXXFLAGS += -Werror
QT += quick core network androidextras svg
TEMPLATE = app
CONFIG += c++14
TARGET = template

INCLUDEPATH += src/APICommunication

HEADERS += \
    src/datamanager.h \
    src/filemanager.h \
    src/pagemanager.h \
    src/pages.h \
    src/project.h \
    src/session.h \
    src/settings.h \
    src/task.h \
    src/transaction.h \
    src/user.h \
    src/userptr.h \
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
    src/work.h

SOURCES += src/main.cpp  \
    src/datamanager.cpp \
    src/filemanager.cpp \
    src/pagemanager.cpp \
    src/project.cpp \
    src/session.cpp \
    src/settings.cpp \
    src/task.cpp \
    src/transaction.cpp \
    src/user.cpp \
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
    src/work.cpp

RESOURCES +=  \
    qml/qml.qrc \
    resources/resources.qrc

OTHER_FILES += \
    ../template.doxyfile \
    ../README.md \
    ../Release.md \
    ../.gitignore \
    ../license-Qt.txt \
    ../.gitlab-ci.yml

## Put all build files into build directory
##  This also works with shadow building, so don't worry!
BUILD_DIR = build
OBJECTS_DIR = $$BUILD_DIR
MOC_DIR = $$BUILD_DIR
RCC_DIR = $$BUILD_DIR
UI_DIR = $$BUILD_DIR
DESTDIR = $$BUILD_DIR/bin

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

API_URL = "https://flrchain.milosolutions.com:8000"
DEFINES += APIUrl='"\\\"$$API_URL\\\""'

SSL_PATH = $$PWD/../../openssl/android_openssl-master/latest

contains(ANDROID_ABIS, "armeabi-v7a") {
    ANDROID_EXTRA_LIBS += $$SSL_PATH/arm/libcrypto_1_1.so $$SSL_PATH/arm/libssl_1_1.so
}

contains(ANDROID_ABIS, "arm64-v8a") {
    ANDROID_EXTRA_LIBS += $$SSL_PATH/arm64/libcrypto_1_1.so $$SSL_PATH/arm64/libssl_1_1.so
}

contains(ANDROID_ABIS, "x86") {
    ANDROID_EXTRA_LIBS += $$SSL_PATH/x86/libcrypto_1_1.so $$SSL_PATH/x86/libssl_1_1.so
}

contains(ANDROID_ABIS, "x86_64") {
    ANDROID_EXTRA_LIBS += $$SSL_PATH/x86_64/libcrypto_1_1.so $$SSL_PATH/x86_64/libssl_1_1.so
}
