#ifndef DATATAG_H
#define DATATAG_H

#include <QObject>

#include "typedefs.h"

class DataTag : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString name CONSTANT)
    Q_PROPERTY(Type type READ type CONSTANT)
    Q_PROPERTY(QString unit READ unit CONSTANT)

public:
    enum class Type : int
    {
        Text,
        Number,
        Area,
        Photo
    };
    Q_ENUM(Type)

    explicit DataTag(const int id,
                     const QString &name,
                     const Type type,
                     const QString &unit,
                     QObject *parent = nullptr);

    int id() const;
    QString name() const;
    Type type() const;
    QString unit() const;

    static DataTagPtr createFromJson(const QJsonObject &dataTagObject);

private:
    int m_id;
    QString m_name;
    Type m_type;
    QString m_unit;
};

Q_DECLARE_METATYPE(DataTag*)
Q_DECLARE_METATYPE(DataTagPtr)
Q_DECLARE_METATYPE(DataTagList)

#endif // DATATAG_H
