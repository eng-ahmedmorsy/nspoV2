import 'dart:io';

import 'package:nspo/Core/servies/api_services.dart';
import 'package:nspo/Feauters/Login/Data/Models/LoginData.dart';
import 'package:nspo/Feauters/Login/Data/Models/infoEmployee.dart';
import 'package:nspo/Feauters/Login/Data/Repository/LoginRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../Core/constance/url.dart';

class LoginRepoImpl implements LoginRepo {
  @override
  Future<Either<String, Map>> loginEmployee(
      {required LoginData loginData}) async {
    try {
      ApiService apiService = ApiService();
      final response = await apiService.postData(
          path: UrlEndpoint.loginUrl(), data: loginData.toJson());
      Map  dataEmp = response.data;
      return right(dataEmp);
    } on DioException catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return Left("فشل الاتصال بالخادم، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (  e.error is SocketException) {
        return Left("لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (e.response?.statusCode == 403) {
        return Left(e.response?.data.toString() ?? 'Unknown error');
      }
      if (e.response?.statusCode == 403) {
        return left(e.response?.data ?? 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      }
      return left('حدث خطأ ما يرجى المحاولة مرة أخرى');
    } catch (e) {
      return left('حدث خطأ ما يرجى المحاولة مرة أخرى');
    }
  }
}
