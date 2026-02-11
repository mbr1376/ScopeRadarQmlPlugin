#include "radartargetmodel.h"


RadarTargetModel::RadarTargetModel(QObject *parent)
    : QAbstractListModel(parent) {
    QList<RadarTarget> targets;
    targets.append({ 45, 30, 0.8 });
    targets.append({ 120, 70, 0.5 });
    targets.append({ 300, 20, 1.0 });

    updateTargets(targets);
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
