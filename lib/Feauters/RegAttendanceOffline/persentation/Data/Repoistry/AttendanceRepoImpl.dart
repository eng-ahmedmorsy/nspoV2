import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../../../Core/models/AttendanceRecord.dart';
import '../../../../../Core/servies/DbHelper.dart';
import '../Models/InfoMamouria.dart';
import 'AttendanceRepo.dart';

class AttendanceOfflineRepoImpl implements AttendanceOfflineRepo {
  @override
  Future<Either<String, String>> addAttendanceData(
      AttendanceRecord regAttend) async {
    try {

      DatabaseHelper databaseHelper = DatabaseHelper();
      if (regAttend.inOut == 1) {
        int? idAttendRecord = await databaseHelper.checkIfLeave(regAttend);
        if (idAttendRecord == null) {
          await databaseHelper.insertAttendance(regAttend);
          return const Right("تم تسجيل الحضور بنجاح");
        } else {
          databaseHelper.updateAttendance(
              idAttendRecord, regAttend.attDate!);
          return const Right("تم تسجيل الحضور بنجاح");
        }
      }
      await databaseHelper.insertAttendance(regAttend);

      return const Right("تم تسجيل الحضور بنجاح");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left("فشل الاتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (  e.error is SocketException) {
        return Left("لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (e.response?.statusCode == 403) {
        return Left(e.response?.data.toString() ?? 'Unknown error');
      }
      if (e.response?.statusCode == 403) {
        return Left(e.response?.data.toString() ?? 'Unknown error');
      }
      return const Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AttendanceEmpToday>> getAttendanceToday(
      int personId) async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Map> attendanceRecordToday =
          await databaseHelper.getAttendancesToday(personId);

      AttendanceEmpToday attendanceData = AttendanceEmpToday();
      for (var item in attendanceRecordToday) {
        // convert attDate to Time 12 hour format
        String attDate =
            DateFormat('hh:mm a').format(DateTime.parse(item['attDate']));
        if (item['inOut'] == 0) {
          attendanceData.timeIn = attDate;
        } else if (item['inOut'] == 1) {
          attendanceData.timeOut = attDate;
        }
      }
      if (attendanceData.timeIn != null && attendanceData.timeOut != null) {
        // calculate the total hours and minus
        DateTime timeIn = DateFormat('hh:mm a').parse(attendanceData.timeIn!);
        DateTime timeOut = DateFormat('hh:mm a').parse(attendanceData.timeOut!);

        Duration difference = timeOut.difference(timeIn);

        int hours = difference.inHours;
        int minutes = difference.inMinutes % 60;

        String totalTime = "ساعات: $hours دقائق: $minutes";
        attendanceData.totalTimes = totalTime;
      }
      if (attendanceRecordToday.isEmpty) {
        attendanceData.timeIn = "--:--";
        attendanceData.timeOut = "--:--";
        attendanceData.totalTimes = "--:--";
      }
      attendanceData.countRegInMiddleDay = attendanceRecordToday
          .where((element) => element['inOut'] == 2)
          .length;

      if (attendanceData.timeOut == null) {
        attendanceData.timeOut = "--:--";
        attendanceData.totalTimes = "--:--";
      }

      return Right(attendanceData);
    }on DioException catch(e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left("فشل الاتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (  e.error is SocketException) {
        return Left("لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (e.response?.statusCode == 403) {
        return Left(e.response?.data.toString() ?? 'Unknown error');
      }

      return Left("حدث خطأ ما يرجى المحاولة مرة أخرى");

    } catch  (e) {
      return Left(e.toString());
    }
  }
}
