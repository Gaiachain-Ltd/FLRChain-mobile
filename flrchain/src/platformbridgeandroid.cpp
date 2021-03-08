#include "platformbridgeprivate.h"
#include "platformbridge.h"

#include <QByteArray>
#include "QDebug"

PlatformBridge *sptr_q_ptr = nullptr;

PlatformBridgePrivate::PlatformBridgePrivate(PlatformBridge *parent) :
    QObject(parent),
    q_ptr(parent)
{
    init();
}

void PlatformBridgePrivate::init()
{
    sptr_q_ptr = q_ptr;
}

void PlatformBridgePrivate::deinit()
{
    sptr_q_ptr = Q_NULLPTR;
}

bool PlatformBridgePrivate::nativeEventFilter(const QByteArray &eventType, void *message, long *result)
{
    Q_UNUSED(eventType);
    Q_UNUSED(message);
    Q_UNUSED(result);
    return false;
}

void PlatformBridgePrivate::capture()
{
    QtAndroid::androidActivity().callMethod<void>("capture", "()V");
}

void PlatformBridgePrivate::captureCallback(JNIEnv *env, jobject, jstring path)
{
    if (path == nullptr) {
        qDebug("Media path is null;");
        return;
    }

    if (sptr_q_ptr == nullptr) {
        qDebug(" is null!");
        return;
    }

    const char *nativeString = env->GetStringUTFChars(path, 0);
    QByteArray byteArray;
    byteArray.append(nativeString);
    QString strPath(byteArray);

    sptr_q_ptr->capturedMedia(strPath);
}

void PlatformBridgePrivate::selectFile()
{
    QString mimeTypeToApply;
    mimeTypeToApply = "image/*";

    QAndroidJniObject mimeTypeFilterObj = QAndroidJniObject::fromString(mimeTypeToApply);
    QtAndroid::androidActivity().callMethod<void>("importFile",
                                                  "(Ljava/lang/String;)V",
                                                  mimeTypeFilterObj.object<jstring>());
}

void PlatformBridgePrivate::fileSelectionCallback(JNIEnv *env, jobject, jstring path)
{
    Q_UNUSED(env);

    if (path == nullptr) {
        qDebug("File path is null!");
        return;
    }

    if (sptr_q_ptr == nullptr) {
        qDebug("Sptr is null!");
        return;
    }

    const char *nativeString = env->GetStringUTFChars(path, 0);
    QByteArray byteArray;
    byteArray.append(nativeString);
    QString str = QString::fromUtf8(nativeString);

    sptr_q_ptr->fileSelected(str);
}


void PlatformBridgePrivate::activityClosedCallback(JNIEnv *env, jobject)
{
    Q_UNUSED(env)
    if (sptr_q_ptr != Q_NULLPTR) {

    }
}

static JNINativeMethod flr_activity_methods[] = {
    { "fileSelectionCallback", "(Ljava/lang/String;)V", (void*)&PlatformBridgePrivate::fileSelectionCallback },
    { "activityClosedCallback", "()V", (void*)&PlatformBridgePrivate::activityClosedCallback }
};


// FLRMedia callbacks
static JNINativeMethod media_activity_methods[] = {
    { "captureCallback", "(Ljava/lang/String;)V", (void*)&PlatformBridgePrivate::captureCallback }
};


jint JNI_OnLoad(JavaVM *vm, void *reserved)
{
    Q_UNUSED(reserved)

    JNIEnv *env;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
        return -1;
    }

    env->RegisterNatives(env->FindClass("com/application/flrchain/FLRMedia"), media_activity_methods, 1);
    env->RegisterNatives(env->FindClass("com/application/flrchain/FLRActivity"), flr_activity_methods, 2);

    return JNI_VERSION_1_6;
}
