import 'package:dio/dio.dart';

class RegAttendanceModel {
  int? personId;
  Coordinates? coordinates;
  String? deviceId;
  bool? isMiddleDay;
  String? attDate;
  String? image;

  RegAttendanceModel({
    this.personId,
    this.coordinates,
    this.deviceId,
    this.isMiddleDay,
    this.attDate,
    this.image,
  });

  factory RegAttendanceModel.fromJson(Map<String, dynamic> json) {
    return RegAttendanceModel(
      personId: json['personId'],
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      deviceId: json['deviceId'],
      attDate: json['attDate'],
      isMiddleDay: json['isMiddleDay'] ?? false,
      image: json['image']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personId': personId,
      'coordinates': coordinates?.toJson(),
      'deviceId': deviceId,
      'isMiddleDay': isMiddleDay,
      'attDate': attDate,
      // نترك الصورة خارج toJson لأننا سنرسلها باستخدام FormData
    };
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'personId': personId,
      'coordinates': coordinates?.toJson(),
      'deviceId': deviceId,
      'isMiddleDay': isMiddleDay,
      'attDate': attDate,
      'image': await getImageMultipart(),
    });
  }

  Future<MultipartFile?> getImageMultipart() async {
    if (image != null) {
      return MultipartFile.fromFile(image!,contentType: DioMediaType('image', 'jpg'));
    }
    return null;
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
