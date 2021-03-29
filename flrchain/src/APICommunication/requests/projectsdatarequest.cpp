#include "projectsdatarequest.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "project.h"
#include "task.h"

ProjectsDataRequest::ProjectsDataRequest(const QByteArray &token) : ApiRequest("projects")
{
    setPriority(Priority::Normal);
    setType(Type::Get);
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

    QJsonArray projectsArray = response.value(QLatin1String("results")).toArray();

    const int arraySize = projectsArray.count();
    if(arraySize == 0) {
        qDebug("No resources available");
        return;
    }

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = projectsArray.at(i).toObject();

        Project *project = new Project();
        project->setId(projectObject.value(QLatin1String("id")).toInt());
        project->setName(projectObject.value(QLatin1String("title")).toString());
        if(projectObject.value(QLatin1String("assignment_status")).isNull()){
            project->setAssignmentStatus(-1);
        }
        else {
            project->setAssignmentStatus(projectObject.value(QLatin1String("assignment_status")).toInt());
        }

        if(projectObject.value(QLatin1String("investment")).isNull()){
            project->setStatus(-1);
        }
        else {
            project->setStatus(projectObject.value(QLatin1String("investment")).toObject()
                               .value(QLatin1String("status")).toInt());
        }

        project->setDeadline(projectObject.value(QLatin1String("end")).toString());
        project->setInvestmentStart(projectObject.value(QLatin1String("start")).toString());
        project->setInvestmentEnd(projectObject.value(QLatin1String("end")).toString());
        project->setDescription(projectObject.value(QLatin1String("description")).toString());
        project->setPhoto(projectObject.value(QLatin1String("photo")).toString());

        QJsonArray tasksArray = projectObject.value(QLatin1String("tasks")).toArray();
        QVariantList tasksList;
        const int tasksArraySize = tasksArray.count();
        for(int i = 0; i < tasksArraySize; ++i) {
            QJsonObject taskObject = tasksArray.at(i).toObject();
            Task *task = new Task();
            task->setProjectId(project->id());
            task->setTaskId(taskObject.value(QLatin1String("id")).toInt());
            task->setAction(taskObject.value(QLatin1String("action")).toString());
            task->setReward(taskObject.value(QLatin1String("reward")).toDouble());

            tasksList.append(QVariant::fromValue(task));
        }

        project->setTasks(tasksList);

        projectsList.append(QVariant::fromValue(project));
    }

    emit projectsDataReply(projectsList);
}
