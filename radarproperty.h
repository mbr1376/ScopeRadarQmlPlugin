#ifndef RADARPROPERTY_H
#define RADARPROPERTY_H

#include <QObject>
#include <qqmlintegration.h>

class RadarProperty : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(qreal headigRadar READ getHeadingRadar WRITE setHeadingRadar NOTIFY headingRadarChanged FINAL)

public:
    explicit RadarProperty(QObject *parent = nullptr);
    qreal getHeadingRadar() const;
public slots:
    void setHeadingRadar(const qreal &heading);

signals:
    void headingRadarChanged();

private:
    qreal _headigRadar;
};

#endif // RADARPROPERTY_H
