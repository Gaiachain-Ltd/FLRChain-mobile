#include "platformbridge.h"
#include "platformbridgeprivate.h"

PlatformBridge::PlatformBridge() :
    QObject(Q_NULLPTR),
    d_ptr(new PlatformBridgePrivate(this))
{
}

PlatformBridge *PlatformBridge::instance()
{
    static PlatformBridge instance;
    return &instance;
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

bool PlatformBridge::internetAvailable() const
{
    return d_ptr->m_internetAvailable;
}

void PlatformBridge::setInternetAvailable(const bool internetAvailable)
{
    d_ptr->m_internetAvailable = internetAvailable;
    emit internetAvailableChanged(internetAvailable);
}
