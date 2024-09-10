import 'dart:io';

import 'package:nspo/Core/constance/url.dart';
import 'package:nspo/Core/servies/api_services.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Data/Models/InfoMamouria.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Data/Models/RegAttendaceModel.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Data/Repoistry/AttendanceRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  @override
  Future<Either<String, AttendanceData>> getAttendanceDataEmp(
      {required Map<String,dynamic> data}) async {
    Response response;
    try {
      ApiService apiService = ApiService();
      response = await apiService.postData(
          path: UrlEndpoint.getAttendanceData(),
          data: data);
      AttendanceData attendanceData = AttendanceData.fromJson(response.data);
      return Right(attendanceData);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left("فشل الاتصال بالخادم، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (  e.error is SocketException) {
        return Left("لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (e.response?.statusCode == 403) {
        return Left(e.response?.data.toString() ?? 'Unknown error');
      }
      return Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }  catch (e) {
      return Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future<Either<String, String>> addAttendanceData(
      RegAttendanceModel regAttend) async {
    try {
      ApiService apiService = ApiService();
      await apiService.postData(
          path: UrlEndpoint.regAttendanceData(), data: regAttend.toJson());

      return const Right("تم تسجيل الحضور بنجاح");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left("فشل الاتصال بالخادم، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
        }
      if (e.response?.statusCode == 403) {
        return Left(e.response?.data.toString() ?? 'Unknown error');
      }
      return Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    } catch (e) {
      return Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }
}
