#ifndef DEVLIST_H
#define DEVLIST_H

//ListModel的表头同时也可以作为GridView的model
//此处就是使用ListModel代替GridModel
//使用C++的Model而不是QLML的
//在QML Dev.qml中注释的id：gridModel为QML的model
//使用C++创建的Model容易操作
#include <QAbstractListModel>

class DevList : public QAbstractListModel
{
    Q_OBJECT

public:
    DevList(QObject *parent = nullptr);

    enum DevRole {
        DevnameRole,
        DevstateRole,
        DevroomRole,
        DevaddressRole
    };
    Q_ENUM(DevRole)

    int rowCount(const QModelIndex & = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE void append(const QString &devname, const QString &devstate,
                            const QString  &devroom, const QString &devaddress);
    Q_INVOKABLE void set(int row,
                         const QString &devname, const QString &devstate,
                         const QString  &devroom, const QString &devaddress);
    Q_INVOKABLE void remove(int row);

private:
    struct DevInfor {
        QString devname;
        QString devstate;
        QString devroom;
        QString devaddress;
    };

    QList<DevInfor> m_Devs;  //声明Touch的结构体列表
};

#endif // DEVLIST_H
