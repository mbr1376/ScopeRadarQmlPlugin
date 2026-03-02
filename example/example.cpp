#include "radartargetmodel.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTimer>
#include <QQmlContext>
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


    // QObject *rootObject = engine.rootObjects().isEmpty() ? nullptr : engine.rootObjects().first();
    // if (rootObject) {
    //     // تزریق نمونه Singleton به Context ریشه با نام "radarController"
    //     engine.rootContext()->setContextProperty("radarController", RadarController::instance());
    // }
    QList<RadarTarget> list;
    list.append({45, 30,30, 0.8});
    list.append({120, 70,80, 0.5});

    RadarController::instance()->updateTargets(list);
    QTimer *sweepTimer = new QTimer(&app);
    RadarController::instance()->setHeadingRadar(0.0);
    qreal currentAngle = 0.0;
    sweepTimer->setInterval(10); // به‌روزرسانی هر 100 میلی‌ثانیه

    QObject::connect(sweepTimer, &QTimer::timeout, [engine_ptr = &engine, &currentAngle]() mutable {
        currentAngle += 0.3;
        if (currentAngle >= 360.0) {
            currentAngle -= 360.0;
        }

        RadarController::instance()->setHeadingRadar(currentAngle);


    });

    // شروع تایمر
    sweepTimer->start();

    return app.exec();
}
