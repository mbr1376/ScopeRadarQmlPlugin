#include "radarcontroller.h"

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

void RadarController::updateTargets(const QList<RadarTarget> &targets)
{
    for (auto model : m_models)
        model->updateTargets(targets);
}
