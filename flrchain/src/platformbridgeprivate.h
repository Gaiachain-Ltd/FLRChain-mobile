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

#ifndef PLATFORMBRIDGEPRIVATE_H
#define PLATFORMBRIDGEPRIVATE_H

#include "platformbridge.h"

#include <QObject>
#include <QAbstractNativeEventFilter>

#include <QtAndroid>

class PlatformBridgePrivate : public QObject, public QAbstractNativeEventFilter
{
    Q_OBJECT

    PlatformBridge *q_ptr;
    Q_DECLARE_PUBLIC(PlatformBridge)

    PlatformBridgePrivate(PlatformBridge *parent = Q_NULLPTR);

    void init();
    void uninit();

    void capture();
    void selectFile();
    void checkConnection();
public:
    bool nativeEventFilter(const QByteArray &eventType, void *message, long *result);

    static void captureCallback(JNIEnv *env, jobject, jstring path);
    static void backButtonCallback(JNIEnv *env, jobject);
    static void fileSelectionCallback(JNIEnv *env, jobject, jstring path);
    static void activityClosedCallback(JNIEnv *env, jobject);
    static void networkAvailableCallback(JNIEnv *env, jobject, jboolean isAvailable);

}; // class PlatformBridgePrivate

#endif // PLATFORMBRIDGEPRIVATE_H
