#ifndef RADARCONTROLLER_H
#define RADARCONTROLLER_H

#include "radartargetmodel.h"
#include <QObject>
#include <qqmlintegration.h>

class RadarController : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
        static RadarController *instance();
    void registerModel(RadarTargetModel *model);
    void updateTargets(const QList<RadarTarget> &targets);

signals:

private:
    QList<RadarTargetModel*> m_models;
};

#endif // RADARCONTROLLER_H
