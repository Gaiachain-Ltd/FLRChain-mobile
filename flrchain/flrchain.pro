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
QT += quick core network androidextras
TEMPLATE = app
CONFIG += c++14
TARGET = template

INCLUDEPATH += src/APICommunication

HEADERS += \
    src/datamanager.h \
    src/filemanager.h \
    src/project.h \
    src/session.h \
    src/settings.h \
    src/task.h \
    src/user.h \
    src/userptr.h \
    src/APICommunication/restapiclient.h \
    src/APICommunication/apirequest.h \
    src/APICommunication/requests/loginrequest.h \
    src/APICommunication/requests/registerrequest.h \
    src/APICommunication/requests/projectsdatarequest.h \
    src/APICommunication/requests/workdatarequest.h \
    src/APICommunication/requests/userinforequest.h \
    src/platformbridgeprivate.h \
    src/platformbridge.h \
    src/work.h

SOURCES += src/main.cpp  \
    src/datamanager.cpp \
    src/filemanager.cpp \
    src/project.cpp \
    src/session.cpp \
    src/settings.cpp \
    src/task.cpp \
    src/user.cpp \
    src/APICommunication/restapiclient.cpp \
    src/APICommunication/apirequest.cpp \
    src/APICommunication/requests/loginrequest.cpp \
    src/APICommunication/requests/registerrequest.cpp \
    src/APICommunication/requests/projectsdatarequest.cpp \
    src/APICommunication/requests/workdatarequest.cpp \
    src/APICommunication/requests/userinforequest.cpp \
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
