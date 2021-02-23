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
