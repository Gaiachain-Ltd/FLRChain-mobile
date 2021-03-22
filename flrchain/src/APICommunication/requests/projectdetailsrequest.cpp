#include "projectdetailsrequest.h"
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "../project.h"
#include "../task.h"

ProjectDetailsRequest::ProjectDetailsRequest(const QByteArray &token, const int projectId) : ApiRequest(QString("projects/%1").arg(projectId))
{
    setPriority(Priority::Normal);
    setType(Type::Get);
    setToken(token);
    connect(this, &ProjectDetailsRequest::replyError, this, &ProjectDetailsRequest::errorHandler);
}

void ProjectDetailsRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void ProjectDetailsRequest::parse()
{
    QJsonObject projectObject(m_replyDocument.object());

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

    emit projectDetailsReply(project);
}
