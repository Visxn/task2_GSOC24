class LookAtEntity {
  double lng;
  double lat;
  double altitude;
  double range;
  double tilt;
  double heading;
  String altitudeMode;

  LookAtEntity(
      {required this.lng,
        required this.lat,
        required this.range,
        required this.tilt,
        required this.heading,
        this.altitude = 0,
        this.altitudeMode = 'relativeToGround'});

  String get tag => '''
      <LookAt>
        <longitude>$lng</longitude>
        <latitude>$lat</latitude>
        <altitude>$altitude</altitude>
        <range>$range</range>
        <tilt>$tilt</tilt>
        <heading>$heading</heading>
        <gx:altitudeMode>$altitudeMode</gx:altitudeMode>
      </LookAt>
    ''';

  String get linearTag =>
      '<LookAt><longitude>$lng</longitude><latitude>$lat</latitude><altitude>$altitude</altitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><gx:altitudeMode>$altitudeMode</gx:altitudeMode></LookAt>';

  toMap() {
    return {
      'lng': lng,
      'lat': lat,
      'altitude': altitude,
      'range': range,
      'tilt': tilt,
      'heading': heading,
      'altitudeMode': altitudeMode
    };
  }

  factory LookAtEntity.fromMap(Map<String, dynamic> map) {
    return LookAtEntity(
        lng: map['lng'],
        lat: map['lat'],
        altitude: map['altitude'],
        range: map['range'],
        tilt: map['tilt'],
        heading: map['heading'],
        altitudeMode: map['altitudeMode']);
  }
}
