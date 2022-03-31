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

#include "settings.h"

#include <QMetaObject>
#include <QMetaEnum>

Settings *Settings::m_instance = Q_NULLPTR;

Settings *Settings::instance()
{
    if (!m_instance) {
        m_instance = new Settings();
    }
    return m_instance;
}

void Settings::dealloc()
{
    if (m_instance) {
        delete m_instance;
        m_instance = Q_NULLPTR;
    }
}

Settings::Settings()
{
}

QVariant Settings::getSettingsValue(QSettings *sett,
                                    const Settings::SettingsType type,
                                    const QVariant &defaultValue) const
{
    const QString key(typeToString(type));

    return sett->value(key, defaultValue);
}

QVariant Settings::getValue(Settings::SettingsType type) const
{
    QSettings settings(QStringLiteral("FLRChain"));

    switch (type)
    {
    case RememberMe:
        return getSettingsValue(&settings, type, false);
    case Token:
        return getSettingsValue(&settings, type, QString());

    default:
        return getSettingsValue(&settings, type, QVariant());
    }
}

void Settings::setValue(Settings::SettingsType type, const QVariant &value)
{
    QSettings settings(QStringLiteral("FLRChain"));
    settings.setValue(typeToString(type), value);
}

QString Settings::typeToString(Settings::SettingsType type)
{
    const QMetaObject smo = Settings::staticMetaObject;
    const int indexOfType = smo.indexOfEnumerator("SettingsType");
    const QMetaEnum enumerator = smo.enumerator(indexOfType);
    return QString(enumerator.valueToKey(type));
}
