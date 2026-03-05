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

void RadarProperty::setPRF(const qreal &prf)
{
    if (prf !=_prf){
        _prf=prf;
        emit prfChanged();
    }
}


void RadarProperty::setBeamWidth(const qreal &bw)
{
    if (bw !=_beamWidth){
        _beamWidth=bw;
       emit beamWidthChanged();
    }
}

void RadarProperty::setPulseWidth(const qreal &pw)
{
    if (pw !=_pulseWidth){
        _pulseWidth=pw;
       emit pulseWidthChanged();
    }
}

void RadarProperty::setNoiseFloor(const qreal &nf)
{
    if (nf !=_noiseFloor){
        _noiseFloor=nf;
       emit  noiseFloorChanged();
    }
}

void RadarProperty::setAntennaSpeedRPM(const qreal &asr)
{
    if (asr !=_antennaSpeedRPM){
        _antennaSpeedRPM=asr;
        emit antennaSpeedRPMChanged();
    }
}

void RadarProperty::setRadarMode(const int &bw)
{
    if (bw !=_radarMode){
        _radarMode=bw;
        emit radarModeChanged();
    }
}

void RadarProperty::setLongitude(const qreal &lon)
{
    if (lon !=_longitude){
        _longitude=lon;
       emit longitudeChanged();
    }
}

void RadarProperty::setLatitude(const qreal &lat)
{
    if (lat !=_latitude){
        _latitude=lat;
        emit  latitudeChanged();
    }
}

void RadarProperty::setAltitude(const qreal &alt)
{
    if (alt !=_altitude){
        _altitude=alt;
        emit  altitudeChanged();
    }
}
