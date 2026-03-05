#ifndef RADARPROPERTY_H
#define RADARPROPERTY_H

#include <QObject>
#include <qqmlintegration.h>

class RadarProperty : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(qreal headigRadar     READ getHeadingRadar  WRITE setHeadingRadar     NOTIFY headingRadarChanged FINAL)
    Q_PROPERTY(qreal pRF             READ prf              WRITE setPRF              NOTIFY prfChanged) // Pulse Repetition Frequency
    Q_PROPERTY(qreal beamWidth       READ beamWidth        WRITE setBeamWidth        NOTIFY beamWidthChanged) // زاویه پرتو (درجه)
    Q_PROPERTY(qreal pulseWidth      READ pulseWidth       WRITE setPulseWidth       NOTIFY pulseWidthChanged) // پهنای پالس (میکروثانیه)
    Q_PROPERTY(qreal noiseFloor      READ noiseFloor       WRITE setNoiseFloor       NOTIFY noiseFloorChanged) // حداقل سیگنال قابل تشخیص
    Q_PROPERTY(qreal antennaSpeedRPM READ antennaSpeedRPM WRITE setAntennaSpeedRPM  NOTIFY antennaSpeedRPMChanged) // سرعت چرخش آنتن (دور در دقیقه)
    Q_PROPERTY(int   radarMode       READ radarMode        WRITE setRadarMode        NOTIFY radarModeChanged) // حالت رادار (Search, Track, ...)
    Q_PROPERTY(qreal longitude       READ longitude        WRITE setLongitude        NOTIFY longitudeChanged)
    Q_PROPERTY(qreal latitude        READ latitude         WRITE setLatitude         NOTIFY latitudeChanged)
    Q_PROPERTY(qreal altitude        READ altitude         WRITE setAltitude         NOTIFY altitudeChanged)

public:
    enum RadarMode{
        Search,
        Lock
    };
    Q_ENUM(RadarMode)
    explicit RadarProperty(QObject *parent = nullptr);
    qreal getHeadingRadar() const;
    qreal prf() const { return _prf; }
    qreal beamWidth() const { return _beamWidth; }
    qreal pulseWidth() const { return _pulseWidth; }
    qreal noiseFloor() const { return _noiseFloor; }
    qreal antennaSpeedRPM() const { return _antennaSpeedRPM; }
    qreal longitude() const { return _longitude; }
    qreal latitude() const { return _latitude; }
    qreal altitude() const { return _altitude; }
    int radarMode() const { return _radarMode; }
public slots:
    void setHeadingRadar(const qreal &heading);
    void setPRF(  const qreal &prf);
    void setBeamWidth(const qreal &bw);
    void setPulseWidth(const qreal &pw);
    void setNoiseFloor(const qreal &nf);
    void setAntennaSpeedRPM(const qreal &asr);
    void setRadarMode(const int &bw);
    void setLongitude(const qreal &lon);
    void setLatitude(const qreal &lat);
    void setAltitude(const qreal &alt);

signals:
    void headingRadarChanged();
    void prfChanged();
    void beamWidthChanged();
    void pulseWidthChanged();
    void noiseFloorChanged();
    void antennaSpeedRPMChanged();
    void radarModeChanged();
    void longitudeChanged();
    void latitudeChanged();
    void altitudeChanged();

private:
    qreal _headigRadar;
    qreal _prf = 1000.0; // مقدار پیش‌فرض
    qreal _beamWidth = 1.5; // مقدار پیش‌فرض (1.5 درجه)
    qreal _pulseWidth = 1.0; // مقدار پیش‌فرض (1us)
    qreal _noiseFloor = 0.5; // مقدار پیش‌فرض SNR (یا شدت سیگنال)
    qreal _antennaSpeedRPM = 12.0; // 12 دور در دقیقه
    int _radarMode = static_cast<int>(RadarMode::Lock);
    qreal _longitude= 54.32;
    qreal _altitude= 1000;
    qreal _latitude = 35.65;
};

#endif // RADARPROPERTY_H
