#ifndef RADARTARGETMODEL_H
#define RADARTARGETMODEL_H
#include <QAbstractListModel>
#include <qqmlintegration.h>
struct RadarTarget {
    float azimuth;    // 0..360
    float elevation;  // 0..90
    float range; 	  // 0 .. 100
    float strength;   // 0..1
    float rcs;
    float velocity;
};
class RadarTargetModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    enum Roles {
        AzimuthRole = Qt::UserRole + 1,
        ElevationRole,
        RangeRole,
        StrengthRole,
        RCSRole, //سطح مقطع راداری
        VelocityRole // سرعت شعاعی (متر بر ثانیه)
    };

    explicit RadarTargetModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void updateTargets(const QList<RadarTarget> &targets);
private:
    QList<RadarTarget> m_targets;
};

#endif // RADARTARGETMODEL_H
