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

#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

class Settings
{
    Q_GADGET

public:
    enum SettingsType
    {
      RememberMe,
      Token
    }; // enum SettingsType
    Q_ENUM(SettingsType)

    static Settings *instance();
    static void dealloc();

    Settings(const Settings &) = delete;
    void operator=(const Settings &) = delete;
    QVariant getValue(SettingsType type) const;
    void setValue(SettingsType type, const QVariant &value);
    static QString typeToString(SettingsType type);

private:
    Settings();
    static Settings *m_instance;

    QVariant getSettingsValue(QSettings *sett, const SettingsType type, const QVariant &defaultValue) const;

}; // class Settings


#endif // SETTINGS_H
