#include "devlist.h"

DevList::DevList(QObject *parent ) :
    QAbstractListModel(parent)
{
    m_Devs.append({ "台灯", "关", "卧室" , "5487" });
    m_Devs.append({ "手机充电器", "关", "卧室" , "6584" });
    m_Devs.append({ "Grant", "Wind", "Ri" , "892" });
    m_Devs.append({ "Gretc", "Suns", "Be" , "991" });
    m_Devs.append({ "Geof", "Uni", "Tru" , "944" });
    m_Devs.append({ "Hen", "Via", "Piob" , "994" });
    m_Devs.append({ "Har", "Nor", "Mad" , "492" });
}

int DevList::rowCount(const QModelIndex &) const
{
    return m_Devs.count();
}

QVariant DevList::data(const QModelIndex &index, int role) const
{
    if (index.row() < rowCount())
        switch (role) {
        case DevnameRole: return m_Devs.at(index.row()).devname;
        case DevstateRole: return m_Devs.at(index.row()).devstate;
        case DevroomRole: return m_Devs.at(index.row()).devroom;
        case DevaddressRole: return m_Devs.at(index.row()).devaddress;
        default: return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> DevList::roleNames() const
{
    static const QHash<int, QByteArray> roles {
        { DevnameRole, "devname" },
        { DevstateRole, "devstate" },
        { DevroomRole, "devroom" },
        { DevaddressRole, "devaddress" }
    };
    return roles;
}

QVariantMap DevList::get(int row) const
{
    const DevInfor DevInfor = m_Devs.value(row);
    return {
        {"devname", DevInfor.devname},
        {"devstate", DevInfor.devstate},
        {"devroom", DevInfor.devroom},
        {"devaddress", DevInfor.devaddress} };
}

void DevList::append(const QString &devname, const QString &devstate,
                     const QString &devroom, const QString &devaddress)
{
    int row = 0;
    while (row < m_Devs.count() && devname > m_Devs.at(row).devname)
        ++row;
    beginInsertRows(QModelIndex(), row, row);
    m_Devs.insert(row, {devname, devstate, devroom, devaddress});
    endInsertRows();
}

void DevList::set(int row,
                  const QString &devname, const QString &devstate,
                  const QString &devroom, const QString &devaddress)
{
    if (row < 0 || row >= m_Devs.count())
        return;

    m_Devs.replace(row, { devname, devstate, devroom, devaddress });
    dataChanged(index(row, 0), index(row, 0), { DevnameRole, DevstateRole, DevroomRole, DevaddressRole });
}

void DevList::remove(int row)
{
    if (row < 0 || row >= m_Devs.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_Devs.removeAt(row);
    endRemoveRows();
}
