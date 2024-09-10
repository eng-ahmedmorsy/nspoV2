import 'package:intl/intl.dart';

class AttendanceRecord {
  int? id;
  int? personId;
  Coordinates? coordinates;
  String? deviceId;
  bool? isMiddleDay;
  String? attDate;

  // String? onlyDate;
  int? inOut;
  String? type;

  bool? isSent;
  String? onlyDate;
  String? onlyTime;

  AttendanceRecord(
      {this.id,
      this.personId,
      this.coordinates,
      this.deviceId,
      this.isMiddleDay,
      this.attDate,
      this.isSent,
      this.type,
      this.onlyTime,
      this.onlyDate,

      // this.onlyDate,
      this.inOut});

  Map<String, dynamic> toJson() {
    return {
      'personId': personId,
      'coordinates': coordinates?.toJson(),
      'deviceId': deviceId,
      'isMiddleDay': isMiddleDay,
      'attDate': attDate,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'personId': personId,
      'latitude': coordinates?.latitude,
      'longitude': coordinates?.longitude,
      'deviceId': deviceId,
      'isMiddleDay': isMiddleDay == true ? 1 : 0,
      'attDate': attDate,
      // 'onlyDate':onlyDate,
      'inOut': inOut,
      'isSent': isSent == true ? 1 : 0,
    };
  }

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      id: map['id'],
      personId: map['personId'],
      coordinates: Coordinates(
        latitude: map['latitude'],
        longitude: map['longitude'],
      ),
      deviceId: map['deviceId'],
      // onlyDate: map['onlyDate'],
      inOut: map['inOut'],
      isMiddleDay: map['isMiddleDay'] == 1,
      attDate: map['attDate'],
      isSent: map['isSent'] == 1,
      type: map['inOut'] == 0
          ? "تسجيل الحضور"
          : map['inOut'] == 1
              ? "تسجيل الانصراف"
              : "بصمة تواجد",
      onlyDate: DateFormat('yyyy-MM-dd').format(DateTime.parse(map['attDate'])),
      // 12 hours format
      onlyTime: DateFormat('hh:mm a').format(DateTime.parse(map['attDate'])),
    );
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
