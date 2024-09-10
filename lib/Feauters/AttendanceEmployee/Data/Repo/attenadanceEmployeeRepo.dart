import 'package:dartz/dartz.dart';

import '../Model/attendance.dart';

abstract class AttendanceEmployeeRepo{
  Future<Either<String, List< AttendanceEmployee>>> getAttendanceEmployee({required int personId,required int month, required String year});
}