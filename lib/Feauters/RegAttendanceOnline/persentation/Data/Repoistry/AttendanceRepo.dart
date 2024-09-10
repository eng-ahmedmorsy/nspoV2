import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Data/Models/RegAttendaceModel.dart';
import 'package:dartz/dartz.dart';

import '../Models/InfoMamouria.dart';

abstract class AttendanceRepo {
  Future<Either<String, AttendanceData>> getAttendanceDataEmp({required Map<String,dynamic> data});
  Future<Either<String, String>> addAttendanceData(RegAttendanceModel regAttendanceModel);

}

