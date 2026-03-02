#include "radarproperty.h"

#include <radarcontroller.h>

RadarProperty::RadarProperty(QObject *parent)
    : QObject{parent}
{
    RadarController::instance()->registerProperty(this);

}
qreal RadarProperty::getHeadingRadar() const
{
    return _headigRadar;
}

void RadarProperty::setHeadingRadar(const qreal &heading)
{
    if (_headigRadar == heading)
        return;

    _headigRadar = heading;

    emit headingRadarChanged();
}

void RadarProperty::setPrf(const qreal &prf)
{

}

void RadarProperty::setBeamWidth(const qreal &bw)
{

}
