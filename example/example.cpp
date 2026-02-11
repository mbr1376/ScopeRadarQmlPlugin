#include "radartargetmodel.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <radarcontroller.h>
#include <QtQml/qqmlextensionplugin.h>

//Q_IMPORT_QML_PLUGIN(ScopeRadarQmlPluginPlugin)

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    // The first subfolder is the libraryName followed by the regular
    // folder structure: LibraryName/Subfolder
    const QUrl url(QStringLiteral("qrc:/ExampleProjectApp/example/example.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    QList<RadarTarget> list;
    list.append({45, 30, 0.8});
    list.append({120, 70, 0.5});

    RadarController::instance()->updateTargets(list);
    return app.exec();
}
