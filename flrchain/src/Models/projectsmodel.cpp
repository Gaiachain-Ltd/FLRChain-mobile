#include "projectsmodel.h"
#include "project.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

ProjectsModel::ProjectsModel(QObject *parent) :
    QAbstractListModel(parent)
{
    m_customNames[ProjectId] = "projectId";
    m_customNames[Name] = "name";
    m_customNames[Description] = "description";
    m_customNames[Status] = "status";
    m_customNames[Deadline] = "deadline";
    m_customNames[InvestmentStart] = "investmentStart";
    m_customNames[InvestmentEnd] = "investmentEnd";
    m_customNames[Photo] = "photo";
    m_customNames[AssignmentStatus] = "assignmentStatus";
}

int ProjectsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_items.count();
}

QHash<int, QByteArray> ProjectsModel::roleNames() const
{
    return m_customNames;
}

QVariant ProjectsModel::data(const QModelIndex &index, int role) const
{
    if (role < Qt::UserRole && index.row() > m_items.count())
         return QVariant();

    const int row = index.row();

    Project *item = m_items.at(row);

    switch (role) {
    case ProjectId:
        return item->id();
    case Name:
        return item->name();
    case Description:
        return item->description();
    case Status:
        return static_cast<int>(item->status());
    case Deadline:
        return item->deadline();
    case InvestmentStart:
        return item->investmentStart();
    case Photo:
        return item->photo();
    case InvestmentEnd:
        return item->investmentEnd();
    case AssignmentStatus:
        return static_cast<int>(item->assignmentStatus());
    default:
        Q_UNREACHABLE();
        break;
    }

    return QVariant();
}

bool ProjectsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (role < Qt::UserRole && index.row() > m_items.count())
         return false;

    const int row = index.row();

    Project *item = m_items.at(row);

    switch (role) {
    case ProjectId:
        item->setId(value.toInt());
        break;
    case Name:
        item->setName(value.toString());
        break;
    case Description:
        item->setDescription(value.toString());
        break;
    case Status:
        item->setStatus(static_cast<Project::ProjectStatus>(value.toInt()));
        break;
    case Deadline:
        item->setDeadline(value.toString());
        break;
    case InvestmentStart:
        item->setInvestmentStart(value.toString());
        break;
    case Photo:
        item->setPhoto(value.toString());
        break;
    case InvestmentEnd:
        item->setInvestmentEnd(value.toString());
        break;
    case AssignmentStatus:
        item->setAssignmentStatus(static_cast<Project::AssignmentStatus>(value.toInt()));
        break;
    default:
        return false;
    }

    dataChanged(index, index);
    return true;
}

void ProjectsModel::parseJsonObject(const QJsonObject &response)
{
    clear();
    beginResetModel();
    QJsonArray projectsArray = response.value(QLatin1String("results")).toArray();

    const int arraySize = projectsArray.count();

    for (int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = projectsArray.at(i).toObject();

        Project *project = new Project();
        project->setId(projectObject.value(QLatin1String("id")).toInt());
        project->setName(projectObject.value(QLatin1String("title")).toString());
        project->setDescription(projectObject.value(QLatin1String("description")).toString());
        project->setPhoto(projectObject.value(QLatin1String("image")).toString());
        project->setStatus(static_cast<Project::ProjectStatus>(projectObject.value(QLatin1String("status")).toInt()));

        const QDateTime start = QDateTime::fromString(projectObject.value(QLatin1String("start")).toString(), Qt::ISODate);
        project->setInvestmentStart(start.toString(QLatin1String("MMMM dd, yyyy")));
        const QDateTime end = QDateTime::fromString(projectObject.value(QLatin1String("end")).toString(), Qt::ISODate);
        project->setInvestmentEnd(end.toString(QLatin1String("MMMM dd, yyyy")));
        project->setDeadline(end.toString(QLatin1String("MMMM dd, yyyy")));

        if (projectObject.value(QLatin1String("assignment_status")).isNull()){
            project->setAssignmentStatus(Project::AssignmentStatus::New);
        } else {
            project->setAssignmentStatus(static_cast<Project::AssignmentStatus>(projectObject.value(QLatin1String("assignment_status")).toInt()));
        }

        m_items.append(project);
    }
    emit projectsReceived();
    endResetModel();
}

void ProjectsModel::clear()
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    endResetModel();
}
