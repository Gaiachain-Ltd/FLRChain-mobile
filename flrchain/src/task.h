#ifndef TASK_H
#define TASK_H
#include <QObject>

class Task : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int projectId READ projectId WRITE setProjectId)
    Q_PROPERTY(int taskId READ taskId WRITE setTaskId)
    Q_PROPERTY(QString action READ action WRITE setAction NOTIFY actionChanged)
    Q_PROPERTY(double reward READ reward WRITE setReward NOTIFY rewardChanged)
public:
    Task(QObject *parent = nullptr);
    int projectId() const;
    QString action() const;
    double reward() const;
    int taskId() const;

public slots:
    void setProjectId(const int projectId);
    void setAction(const QString &action);
    void setReward(const double reward);
    void setTaskId(int taskId);

signals:
    void actionChanged(QString action);
    void rewardChanged(double reward);

private:
    int m_projectId;
    QString m_action;
    double m_reward;
    int m_taskId;
};

#endif // TASK_H
