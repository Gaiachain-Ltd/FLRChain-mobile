#include "task.h"

Task::Task() :
    m_projectId(),
    m_action(QString()),
    m_reward()
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

void Task::setProjectId(const int projectId)
{
    m_projectId = projectId;
}

void Task::setAction(const QString &action)
{
    m_action = action;
}

void Task::setReward(const double reward)
{
    m_reward = reward;
}
