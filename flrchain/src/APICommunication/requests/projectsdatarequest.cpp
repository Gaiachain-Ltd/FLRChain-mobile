#include "projectsdatarequest.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "../project.h"
#include "../task.h"

ProjectsDataRequest::ProjectsDataRequest(const QByteArray &token) : ApiRequest("")
{
    m_priority = Priority::Normal;
    m_type = Type::Get;
    setToken(token);
    connect(this, &ProjectsDataRequest::replyError, this, &ProjectsDataRequest::errorHandler);
}

void ProjectsDataRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void ProjectsDataRequest::parse()
{
    QJsonObject response(m_replyDocument.object());

    QVariantList projectsList;
    QVariantList joinedProjectsList;

    QJsonArray projectsArray = response.value(QLatin1String("projects")).toArray();

    const int arraySize = projectsArray.count();
    if(arraySize == 0) {
        qDebug("No resources available");
        return;
    }

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = projectsArray.at(i).toObject();

        Project *project = new Project();
        project->setId(projectObject.value(QLatin1String("projectId")).toInt());
        project->setName(projectObject.value(QLatin1String("name")).toString());
        project->setJoined(projectObject.value(QLatin1String("joined")).toBool());
        project->setStatus(projectObject.value(QLatin1String("status")).toString());
        project->setDeadline(projectObject.value(QLatin1String("deadline")).toString());
        project->setInvestmentStart(projectObject.value(QLatin1String("investmentStart")).toString());
        project->setInvestmentEnd(projectObject.value(QLatin1String("investmentEnd")).toString());
        project->setDescription(projectObject.value(QLatin1String("description")).toString());
        project->setPhoto(projectObject.value(QLatin1String("photo")).toString());

        QJsonArray tasksArray = projectObject.value(QLatin1String("tasks")).toArray();
        QVariantList tasksList;
        const int tasksArraySize = tasksArray.count();
        for(int i = 0; i < tasksArraySize; ++i) {
            QJsonObject taskObject = tasksArray.at(i).toObject();
            Task *task = new Task();
            task->setProjectId(project->id());
            task->setAction(taskObject.value(QLatin1String("action")).toString());
            task->setReward(taskObject.value(QLatin1String("reward")).toDouble());

            tasksList.append(QVariant::fromValue(task));
        }

        project->setTasks(tasksList);

        projectsList.append(QVariant::fromValue(project));
        if(project->joined()){
            joinedProjectsList.append(QVariant::fromValue(project));
        }
    }

    emit projectsDataReply(projectsList, joinedProjectsList);
}