import 'package:dartz/dartz.dart';

import '../../../../../Core/models/AttendanceRecord.dart';
import '../Models/InfoMamouria.dart';

abstract class AttendanceOfflineRepo {
  // Future<Either<String, AttendanceData>> getAttendanceDataEmp({required Map<String,dynamic> data});
  Future<Either<String, String>> addAttendanceData(AttendanceRecord regAttendanceModel);
  Future<Either<String, AttendanceEmpToday>> getAttendanceToday(int personId);

}

