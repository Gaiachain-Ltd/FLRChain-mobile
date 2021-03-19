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
    void deinit();

    void capture();
    void selectFile();
public:
    bool nativeEventFilter(const QByteArray &eventType, void *message, long *result);

    static void captureCallback(JNIEnv *env, jobject, jstring path);
    static void backButtonCallback(JNIEnv *env, jobject);
    static void fileSelectionCallback(JNIEnv *env, jobject, jstring path);
    static void activityClosedCallback(JNIEnv *env, jobject);
    static void networkAvailableCallback(JNIEnv *env, jobject, jboolean isAvailable);
private:
    bool m_internetAvailable = false;

}; // class PlatformBridgePrivate

#endif // PLATFORMBRIDGEPRIVATE_H
