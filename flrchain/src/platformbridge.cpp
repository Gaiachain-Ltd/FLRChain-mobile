#include "platformbridge.h"
#include "platformbridgeprivate.h"

PlatformBridge *PlatformBridge::m_instance = Q_NULLPTR;

PlatformBridge::PlatformBridge() :
    QObject(Q_NULLPTR),
    d_ptr(new PlatformBridgePrivate(this))
{
}

PlatformBridge *PlatformBridge::instance()
{
    if (!m_instance) {
        m_instance = new PlatformBridge();
    }
    return m_instance;
}

void PlatformBridge::dealloc()
{
    if (m_instance) {
        delete m_instance;
        m_instance = Q_NULLPTR;
    }
}

QAbstractNativeEventFilter *PlatformBridge::nativeeventFilter()
{
    return d_ptr;
}

void PlatformBridge::capture() const
{
    d_ptr->capture();
}

void PlatformBridge::selectFile() const
{
    d_ptr->selectFile();
}

void PlatformBridge::checkConnection() const
{
    d_ptr->checkConnection();
}

void PlatformBridge::cleanup()
{
    d_ptr->uninit();
    dealloc();
}
