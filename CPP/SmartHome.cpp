#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "devlist.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<DevList>("My_DevList", 1, 0, "DevList");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/QML/SmartHome.qml")));

    return app.exec();
}
