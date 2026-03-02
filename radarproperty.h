#ifndef RADARPROPERTY_H
#define RADARPROPERTY_H

#include <QObject>
#include <qqmlintegration.h>

class RadarProperty : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(qreal headigRadar READ getHeadingRadar WRITE setHeadingRadar NOTIFY headingRadarChanged FINAL)
    Q_PROPERTY(qreal pRF READ prf NOTIFY prfChanged) // Pulse Repetition Frequency
    Q_PROPERTY(qreal beamWidth READ beamWidth NOTIFY beamWidthChanged) // زاویه پرتو (درجه)
    Q_PROPERTY(qreal pulseWidth READ pulseWidth NOTIFY pulseWidthChanged) // پهنای پالس (میکروثانیه)
    Q_PROPERTY(qreal noiseFloor READ noiseFloor NOTIFY noiseFloorChanged) // حداقل سیگنال قابل تشخیص
    Q_PROPERTY(qreal antennaSpeedRPM READ antennaSpeedRPM NOTIFY antennaSpeedRPMChanged) // سرعت چرخش آنتن (دور در دقیقه)
    Q_PROPERTY(QString radarMode READ radarMode NOTIFY radarModeChanged) // حالت رادار (Search, Track, ...)

public:
    explicit RadarProperty(QObject *parent = nullptr);
    qreal getHeadingRadar() const;
    qreal prf() const { return _prf; }
    qreal beamWidth() const { return _beamWidth; }
    qreal pulseWidth() const { return _pulseWidth; }
    qreal noiseFloor() const { return _noiseFloor; }
    qreal antennaSpeedRPM() const { return _antennaSpeedRPM; }
    QString radarMode() const { return _radarMode; }
public slots:
    void setHeadingRadar(const qreal &heading);
    void setPrf(  const qreal &prf);
    void setBeamWidth(const qreal &bw);

signals:
    void headingRadarChanged();
    void prfChanged();
    void beamWidthChanged();
    void pulseWidthChanged();
    void noiseFloorChanged();
    void antennaSpeedRPMChanged();
    void radarModeChanged();

private:
    qreal _headigRadar;
    qreal _prf = 1000.0; // مقدار پیش‌فرض
    qreal _beamWidth = 1.5; // مقدار پیش‌فرض (1.5 درجه)
    qreal _pulseWidth = 1.0; // مقدار پیش‌فرض (1us)
    qreal _noiseFloor = 0.5; // مقدار پیش‌فرض SNR (یا شدت سیگنال)
    qreal _antennaSpeedRPM = 12.0; // 12 دور در دقیقه
    QString _radarMode = "Search";
};

#endif // RADARPROPERTY_H
