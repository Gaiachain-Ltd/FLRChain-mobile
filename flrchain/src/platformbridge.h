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

    Q_INVOKABLE void capture() const;
    Q_INVOKABLE void selectFile() const;

    QAbstractNativeEventFilter *nativeeventFilter();

private:
   PlatformBridge();
   PlatformBridgePrivate *d_ptr;
   Q_DECLARE_PRIVATE(PlatformBridge)

signals:
    void capturedMedia(const QString &pathToFile) const;
    void fileSelected(const QString &pathToFile) const;

}; // class PlatformBridge

#endif // PLATFORMBRIDGE_H
