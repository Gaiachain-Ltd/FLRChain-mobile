/*******************************************************************************
Copyright (C) 2017 Milo Solutions
Contact: https://www.milosolutions.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*******************************************************************************/

#include <QLoggingCategory>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "session.h"
#include "restapiclient.h"
#include "platformbridge.h"
#include "datamanager.h"
#include "user.h"
#include "pages.h"
#include "pagemanager.h"
#include "project.h"
#include "settings.h"

void cleanUp() {
   PlatformBridge::instance()->cleanup();
   PageManager::dealloc();
   Settings::dealloc();
}

int main(int argc, char *argv[]) {

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setApplicationVersion(AppVersion);
    app.setOrganizationName("Milo Solutions");
    app.setOrganizationDomain("milosolutions.com");
    app.setApplicationName("FLRChain");

    qAddPostRoutine(cleanUp);
    QQmlApplicationEngine engine;

    RestAPIClient client;

    Session session;
    DataManager dataManager;
    session.setDataManager(&dataManager);
    session.setClient(&client);
    engine.rootContext()->setContextProperty("session", QVariant::fromValue(&session));
    engine.rootContext()->setContextProperty("platform", PlatformBridge::instance());
    engine.rootContext()->setContextProperty("dataManager", QVariant::fromValue(&dataManager));
    engine.rootContext()->setContextProperty("pageManager", QVariant::fromValue(PageManager::instance()));
    engine.rootContext()->setContextProperty("projectsModel", dataManager.projectsModel());
    engine.rootContext()->setContextProperty("transactionsModel", dataManager.transactionsModel());
    engine.rootContext()->setContextProperty("workModel", dataManager.workModel());
//    engine.rootContext()->setContextProperty("tasksModel", dataManager.tasksModel());

    qmlRegisterType<User>("com.flrchain.objects", 1, 0, "User");
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/AppStyle.qml")), "com.flrchain.style", 1, 0, "Style");
    qmlRegisterUncreatableType<Pages>("com.flrchain.objects", 1, 0, "Pages", "Pages");
    qmlRegisterUncreatableType<Project>("com.flrchain.objects", 1, 0, "Project", "");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
