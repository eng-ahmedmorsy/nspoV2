import 'package:dartz/dartz.dart';
import 'package:nspo/Core/models/AttendanceRecord.dart';

abstract class UnsentAttendanceRepo {
  Future<Either<String,List<AttendanceRecord>>> getUnsentAttendance( int personId);
}