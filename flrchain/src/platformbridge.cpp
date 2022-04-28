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

void PlatformBridge::scan() const
{
    d_ptr->scan();
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
