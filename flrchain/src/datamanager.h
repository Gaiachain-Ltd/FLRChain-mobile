#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QThread>
#include <QVariantList>
#include <QVariant>

class FileManager;
class DataManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList projects  READ getProjects WRITE setProjects NOTIFY projectsChanged)
    Q_PROPERTY(QVariantList workList  READ getWorkList WRITE setWorkList NOTIFY workListChanged)
    Q_PROPERTY(QVariantList transactionsList  READ getTransactionsList WRITE setTransactionsList NOTIFY transactionsListChanged)
    Q_PROPERTY(double walletBalance READ getWalletBalance WRITE setWalletBalance NOTIFY walletBalanceChanged)
    Q_PROPERTY(int projectsCount READ getProjectsCount WRITE setProjectsCount NOTIFY projectsCountChanged)

public:
    explicit DataManager(QObject *parent = nullptr);
    QVariantList getProjects() const;
    QVariantList getWorkList() const;
    QVariantList getTransactionsList() const;
    int getProjectsCount() const;
    double getWalletBalance() const;
    void cleanData();
    void projectsDataReceived(const QVariantList &projects);
    void workDataReceived(const QVariantList &work);
    void transactionsDataReceived(const QVariantList &transactions);

public slots:
    void setProjects(const QVariantList &projects);
    void setProjectsCount(const int count);
    void setWorkList(const QVariantList &work);
    void setTransactionsList(const QVariantList &transactions);
    void setWalletBalance(const double walletBalance);
    void cashOutReplyReceived(const bool result);
    void projectJoinRequested(const int projectId);
signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void projectsChanged() const;
    void workListChanged() const;
    void transactionsListChanged() const;
    void walletBalanceChanged() const;
    void projectsCountChanged() const;

private:
    QThread *m_workerThread;
    FileManager *m_fileManager;
    QVariantList m_projects;
    QVariantList m_workList;
    QVariantList m_transactionsList;
    double m_walletBalance = 0.0;
    int m_projectsCount = 0;
};

#endif // DATAMANAGER_H
