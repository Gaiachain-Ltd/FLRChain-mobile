#ifndef SESSION_H
#define SESSION_H

#include <QByteArray>
#include <QObject>
#include <QPointer>
#include "userptr.h"
#include "datamanager.h"

class RestAPIClient;

class Session : public QObject
{
    Q_OBJECT
    Q_PROPERTY(User* user READ user NOTIFY userChanged)
    Q_PROPERTY(bool internetConnection WRITE setInternetConnection READ internetConnection NOTIFY internetConnectionChanged)

public:
    explicit Session(QObject *parent = nullptr);
    ~Session();
    void setClient(RestAPIClient *client);
    Q_INVOKABLE bool hasToken() const;
    Q_INVOKABLE void login(const QString& email, const QString& password);
    Q_INVOKABLE void registerUser(const QString& email, const QString& password, const QString &firstName,
                                  const QString &lastName, const QString &phone, const QString &village);
    User* user() const;
    bool internetConnection();
    QByteArray getToken() const;
    void setDataManager(DataManager *dataManager);
    Q_INVOKABLE void setRememberMe(const bool val);
    Q_INVOKABLE bool getRememberMe() const;
    Q_INVOKABLE void logout();

    Q_INVOKABLE void getProjectsData() const;
    Q_INVOKABLE void getWorkData(const int projectId) const;
    Q_INVOKABLE void getUserInfo() const;
    Q_INVOKABLE void joinProject(const int projectId) const;
    Q_INVOKABLE void getTransactionsData() const;
    Q_INVOKABLE void getWalletBalance() const;
    Q_INVOKABLE void cashOut(const QString &amount, const QString &phone) const;
    Q_INVOKABLE void getProjectDetails(const int projectId) const;
    Q_INVOKABLE void downloadPhoto(const QString &fileName, const int workId) const;
    Q_INVOKABLE void sendWorkRequest(const QString &filePath, const int projectId, const int taskId) const;

public slots:
    void setInternetConnection(const bool internetConnection);
signals:
    void loginSuccessful(const QString& token) const;
    void loginError(const QString& error) const;
    void registrationSuccessful() const;
    void registrationError(const QString& errors) const;
    void userChanged(User* user) const;
    void userInfoError(const QString& error) const;
    void internetConnectionChanged(bool internetConnection);
private:
    void onLoginSuccessful(const QString& token);
    void onUserInfo(const QString &firstName,
                    const QString &lastName,
                    const QString &email,
                    const QString &phone,
                    bool optedIn);
    void setToken(const QByteArray &token);

    UserPtr mCurrentUser;
    QPointer<RestAPIClient> mClient;
    QPointer<DataManager> m_dataManager;
    bool m_internetConnection;
};

#endif // SESSION_H
