#ifndef TASK_H
#define TASK_H
#include <QObject>

class Task
{
    Q_GADGET
    Q_PROPERTY(int projectId READ projectId WRITE setProjectId)
    Q_PROPERTY(QString action READ action WRITE setAction)
    Q_PROPERTY(double reward READ reward WRITE setReward)
public:
    Task();
    int projectId() const;
    QString action() const;
    double reward() const;
public slots:
    void setProjectId(const int projectId);
    void setAction(const QString &action);
    void setReward(const double reward);
private:
    int m_projectId;
    QString m_action;
    double m_reward;
};

#endif // TASK_H
