#include "radartargetmodel.h"

#include "radarcontroller.h"


RadarTargetModel::RadarTargetModel(QObject *parent)
    : QAbstractListModel(parent) {
       RadarController::instance()->registerModel(this);
}

int RadarTargetModel::rowCount(const QModelIndex &) const {
    return m_targets.size();
}

QVariant RadarTargetModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid())
        return {};

    const auto &t = m_targets[index.row()];

    switch (role) {
    case AzimuthRole:   return t.azimuth;
    case ElevationRole: return t.elevation;
    case StrengthRole:  return t.strength;
    default: return {};
    }
}

QHash<int, QByteArray> RadarTargetModel::roleNames() const {
    return {
        { AzimuthRole, "azimuth" },
        { ElevationRole, "elevation" },
        { StrengthRole, "strength" }
    };
}

void RadarTargetModel::updateTargets(const QList<RadarTarget> &targets) {
    beginResetModel();
    m_targets = targets;
    endResetModel();
}
