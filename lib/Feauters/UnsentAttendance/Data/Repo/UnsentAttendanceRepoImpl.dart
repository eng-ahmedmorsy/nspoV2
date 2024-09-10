import 'package:dartz/dartz.dart';
import 'package:nspo/Core/models/AttendanceRecord.dart';
import 'package:nspo/Feauters/UnsentAttendance/Data/Repo/unsentAttendanceRepo.dart';

import '../../../../Core/servies/DbHelper.dart';

class UnsentAttendanceRepoImpl implements UnsentAttendanceRepo {
  @override
  Future<Either<String, List<AttendanceRecord>>> getUnsentAttendance(int personId)async {

    try {
      DatabaseHelper db = DatabaseHelper();
      List<AttendanceRecord> list = await db.getAttendances(personId);

      return Right(list);


    } catch (e) {
      return Left("حدث خطأ ما غير متوقع");
    }

  }

}