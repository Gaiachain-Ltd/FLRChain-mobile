#include "workmodel.h"
#include "work.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

WorkModel::WorkModel(QObject *parent) :
    QAbstractListModel(parent)
{
    m_customNames[WorkId] = "workId";
    m_customNames[ProjectId] = "projectId";
    m_customNames[Date] = "date";
    m_customNames[PhotoPath] = "photoPath";
    m_customNames[LocalPath] = "localPath";
    m_customNames[Amount] = "amount";
}

int WorkModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_items.count();
}

QHash<int, QByteArray> WorkModel::roleNames() const
{
    return m_customNames;
}

QVariant WorkModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole && index.row() > m_items.count())
        return QVariant();

    const int row = index.row();

    Work *item = m_items.at(row);

    switch(role) {
    case WorkId:
        return item->id();
    case ProjectId:
        return item->projectId();
    case Status:
        return item->status();
    case Date:
        return item->date();
    case PhotoPath:
        return item->photoPath();
    case LocalPath:
        return item->localPath();
    case Amount:
        return item->amount();
    default:
        Q_UNREACHABLE();
        break;
    }

    return QVariant();
}

bool WorkModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(role < Qt::UserRole && index.row() > m_items.count())
        return false;

    const int row = index.row();

    Work *item = m_items.at(row);

    switch(role) {
    case WorkId:
        item->setId(value.toInt());
        break;
    case ProjectId:
        item->setProjectId(value.toInt());
        break;
    case Status:
        item->setStatus(value.toString());
        break;
    case Date:
        item->setDate(value.toString());
        break;
    case PhotoPath:
        item->setPhotoPath(value.toString());
        break;
    case LocalPath:
        item->setLocalPath(value.toString());
        break;
    case Amount:
        item->setAmount(value.toDouble());
        break;
    default:
        return false;
    }

    dataChanged(index, index);
    return true;
}

void WorkModel::parseJsonObject(const QJsonObject &response)
{
    clear();
    beginResetModel();
    QJsonArray workArray = response.value(QLatin1String("results")).toArray();

    double rewardsBalance = 0.0;
    const int arraySize = workArray.count();

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject workObject = workArray.at(i).toObject();

        Work *work = new Work();
        work->setId(workObject.value(QLatin1String("id")).toInt());
        work->setProjectId(workObject.value(QLatin1String("projectId")).toInt());

        work->setStatus(workObject.value(QLatin1String("status")).toString());
        QDateTime date = QDateTime::fromString(workObject.value(QLatin1String("created")).toString(), Qt::ISODate);
        work->setDate(date.toString(QLatin1String("MMMM dd, yyyy")));
        work->setPhotoPath(workObject.value(QLatin1String("photo")).toString());
        work->setAmount(workObject.value(QLatin1String("task")).toObject().value(QLatin1String("reward")).toString().toDouble());
        rewardsBalance += work->amount();

        m_items.append(work);
        emit downloadPhoto(work->photoPath(), work->id());
    }
    emit workReceived(rewardsBalance);
    endResetModel();
}

void WorkModel::clear()
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    endResetModel();
}

int WorkModel::findRowById(const int id) const
{
    int count = rowCount();
    for (int i = 0; i < count; ++i) {
        if (data(index(i, 0), WorkModel::WorkId) == id) {
            return i;
        }
    }

    return -1;
}

void WorkModel::photoDownloadResult(const int id, const QString &path){
    int row = findRowById(id);
    if (row != -1 && !path.isEmpty()) {
        setData(index(row, 0), path, WorkModel::LocalPath);
    }

    if(row == rowCount() - 1){
        emit workUpdated();
    }
}
