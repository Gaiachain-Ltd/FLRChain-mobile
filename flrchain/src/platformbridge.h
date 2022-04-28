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

    Q_INVOKABLE void scan() const;
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
    void scannerReady() const;
}; // class PlatformBridge

#endif // PLATFORMBRIDGE_H
