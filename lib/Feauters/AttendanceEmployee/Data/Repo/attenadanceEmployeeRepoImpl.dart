import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nspo/Core/servies/api_services.dart';

import '../../../../Core/constance/url.dart';
import '../Model/attendance.dart';
import 'attenadanceEmployeeRepo.dart';

class AttendanceEmployeeRepoImpl implements AttendanceEmployeeRepo {
  @override
  Future<Either<String,List< AttendanceEmployee>>> getAttendanceEmployee(
      {required int personId,
      required int month,
      required String year}) async {
    try {
      ApiService apiService = ApiService();
      var response = await apiService.postData(
          path: UrlEndpoint.getAttendanceEmployee(),
          queryParameters: {
            "idPerson": personId,
            "month": month,
            "year": year
          });
     List <AttendanceEmployee> attendance = [];
      if (response.data != null) {
        for (var item in response.data) {
          attendance.add(AttendanceEmployee.fromJson(item));
        }
      }
 attendance=     attendance.reversed.toList();

      return Right(attendance);
    } on DioException catch(e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left("فشل الاتصال بالخادم، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (  e.error is SocketException) {
        return Left("لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (e.response?.statusCode == 403) {
        return Left(e.response?.data.toString() ?? 'Unknown error');
      }
      if (e.response?.statusCode == 403) {
        return Left(e.response?.data.toString() ?? 'Unknown error');
      }
      return Left("حدث خطأ ما يرجى المحاولة مرة أخرى");

    } catch (e) {
      return  Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }
}
