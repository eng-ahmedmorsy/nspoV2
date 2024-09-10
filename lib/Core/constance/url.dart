import '../servies/remoteConfig.dart';

abstract class UrlEndpoint {
  static  String baseUrl = RemoteConfigService.instance.apiURL;

  static loginUrl() => "$baseUrl/Attendance/login";

  static getAttendanceData() => "$baseUrl/Attendance/getAttendanceData";
  static getAttendanceEmployee() => "$baseUrl/Attendance/getAttendanceEmployee";

  static regAttendanceData() => "$baseUrl/Attendance/regAttendance";
  static addChangePhoneRequest() => "$baseUrl/Attendance/addChangePhoneRequest";
  static getLastRequest() => "$baseUrl/Attendance/getLastRequest";
  static getLastRegLocationRequest() => "$baseUrl/Attendance/getLastRegLocationRequest";
  static regSimCard() => "$baseUrl/Attendance/regSimCard";
  static resetPassword() => "$baseUrl/Attendance/resetPassword";
  static regLocationRequest() => "$baseUrl/Attendance/regLocationRequest";
  static deleteRegLocationRequest() => "$baseUrl/Attendance/deleteRegLocationRequest";
  static deleteRequestChangePhone() => "$baseUrl/Attendance/deleteRequestChangePhone";

}
