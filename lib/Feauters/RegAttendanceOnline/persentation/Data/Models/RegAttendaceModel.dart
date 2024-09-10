class RegAttendanceModel {
  int? personId;
  Coordinates? coordinates;
  String? deviceId;
  bool? isMiddleDay;
  String? attDate;

  RegAttendanceModel({
    this.personId,
    this.coordinates,
    this.deviceId,
    this.isMiddleDay,
    this.attDate,
    // Default value set to false
  });

  factory RegAttendanceModel.fromJson(Map<String, dynamic> json) {
    return RegAttendanceModel(
      personId: json['personId'],
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      deviceId: json['deviceId'],
      attDate: json['attDate'],

      isMiddleDay:
          json['isMiddleDay'] ?? false, // Default to false if not provided
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personId': personId,
      'coordinates': coordinates?.toJson(),
      'deviceId': deviceId,
      'isMiddleDay': isMiddleDay,
      'attDate': attDate,
    };
  }
}

class Coordinates {
  final double? latitude;
  final double? longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
