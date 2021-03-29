#include "task.h"

Task::Task(QObject *parent) :
    QObject(parent),
    m_projectId(),
    m_action(QString()),
    m_reward(),
    m_taskId()
{

}

int Task::projectId() const
{
    return m_projectId;
}

QString Task::action() const
{
    return m_action;
}

double Task::reward() const
{
    return m_reward;
}

int Task::taskId() const
{
    return m_taskId;
}

void Task::setProjectId(const int projectId)
{
    if (m_projectId != projectId) {
        m_projectId = projectId;
    }
}

void Task::setAction(const QString &action)
{
    if (m_action != action) {
        m_action = action;
        emit actionChanged(action);
    }
}

void Task::setReward(const double reward)
{
    if (m_reward != reward) {
        m_reward = reward;
        emit rewardChanged(reward);
    }
}

void Task::setTaskId(int taskId)
{
    if (m_taskId != taskId) {
        m_taskId = taskId;
    }
}
