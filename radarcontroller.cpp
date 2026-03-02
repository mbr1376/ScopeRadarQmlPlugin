#include "radarcontroller.h"
#include "radarproperty.h"

RadarController *RadarController::instance()
{
    static RadarController inst;
    return &inst;
}

void RadarController::registerModel(RadarTargetModel *model)
{
    if (!m_models.contains(model))
        m_models.append(model);
}

void RadarController::registerProperty(RadarProperty *pro)
{
    _pro = pro;
}

void RadarController::updateTargets(const QList<RadarTarget> &targets)
{
    for (auto model : m_models)
        model->updateTargets(targets);
}

void RadarController::setHeadingRadar(const qreal &val)
{
    if(_pro)
        _pro->setHeadingRadar(val);
}

