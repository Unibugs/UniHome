#ifndef HOMELIST_H
#define HOMELIST_H

//抽象列表头文件
#include <QAbstractListModel>

class HomeList : public QAbstractListModel
{
    Q_OBJECT

public:
    HomeList(QObject *parent = nullptr);
};

#endif // HOMELIST_H
