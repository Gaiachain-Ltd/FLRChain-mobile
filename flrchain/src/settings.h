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
