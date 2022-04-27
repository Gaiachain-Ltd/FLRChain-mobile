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

#include <QLoggingCategory>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "session.h"
#include "restapiclient.h"
#include "platformbridge.h"
#include "datamanager.h"
#include "user.h"
#include "project.h"
#include "task.h"
#include "settings.h"
#include "projectmodel.h"
#include "transactionsmodel.h"
#include "workmodel.h"
#include "QZXing.h"

void cleanUp() {
   PlatformBridge::instance()->cleanup();
   Settings::dealloc();
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setApplicationVersion(AppVersion);
    app.setOrganizationName("Gaiachain Lab");
    app.setOrganizationDomain("gaiachainlab.org.uk");
    app.setApplicationName("FLRChain");

    qAddPostRoutine(cleanUp);
    QQmlApplicationEngine engine;

    RestAPIClient client;
    DataManager dataManager;
    Session session;
    session.setClient(&client);
    session.setDataManager(&dataManager);

    engine.rootContext()->setContextProperty("session", QVariant::fromValue(&session));
    engine.rootContext()->setContextProperty("platform", PlatformBridge::instance());
    engine.rootContext()->setContextProperty("dataManager", QVariant::fromValue(&dataManager));
    engine.rootContext()->setContextProperty("projectsModel", QVariant::fromValue(dataManager.projectsModel()));
    engine.rootContext()->setContextProperty("transactionsModel", QVariant::fromValue(dataManager.transactionsModel()));
    engine.rootContext()->setContextProperty("workModel", QVariant::fromValue(dataManager.workModel()));

    qmlRegisterType<User>("com.flrchain.objects", 1, 0, "User");
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/AppStyle.qml")), "com.flrchain.style", 1, 0, "Style");
    qmlRegisterUncreatableType<Project>("com.flrchain.objects", 1, 0, "Project", "");
    qmlRegisterUncreatableType<Task>("com.flrchain.objects", 1, 0, "Task", "");

    QZXing::registerQMLTypes();

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
