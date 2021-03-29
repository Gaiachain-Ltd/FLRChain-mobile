#ifndef PLATFORMBRIDGE_H
#define PLATFORMBRIDGE_H

#include <QObject>

class PlatformBridgePrivate;
class QAbstractNativeEventFilter;

class PlatformBridge : public QObject
{
    Q_OBJECT

public:

    static PlatformBridge *instance();
    static void dealloc();

    Q_INVOKABLE void capture() const;
    Q_INVOKABLE void selectFile() const;
    Q_INVOKABLE void checkConnection() const;

    QAbstractNativeEventFilter *nativeeventFilter();

    void cleanup();
private:
    PlatformBridge();
    PlatformBridgePrivate *d_ptr;
    static PlatformBridge *m_instance;
    Q_DECLARE_PRIVATE(PlatformBridge)

signals:
    void capturedMedia(const QString &pathToFile) const;
    void fileSelected(const QString &pathToFile) const;
    void networkAvailableChanged(bool internetAvailable) const;
}; // class PlatformBridge

#endif // PLATFORMBRIDGE_H
