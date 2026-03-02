#ifndef RADARCONTROLLER_H
#define RADARCONTROLLER_H

#include "radarproperty.h"
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
    void registerProperty(RadarProperty *pro);
    void updateTargets(const QList<RadarTarget> &targets);
    void setHeadingRadar (const qreal &val);

private:
    QList<RadarTargetModel*> m_models;
    RadarProperty *_pro = nullptr;
};

#endif // RADARCONTROLLER_H
