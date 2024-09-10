import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nspo/Feauters/profile/features/Data/Models/reset_password.dart';
import 'package:nspo/Feauters/profile/features/Data/Repoistory/reset_password_repo.dart';

import '../../../../../Core/constance/url.dart';
import '../../../../../Core/servies/api_services.dart';

class RestPasswordRepoImpl implements ResetPasswordRepo {
  @override
  Future<Either<String, String>> resetPassword({required ResetPasswordModel resetPasswordModel}) async {
      try {
        ApiService apiService = ApiService();
        print("resetPasswordModel.toJson() ${resetPasswordModel.toJson()}");
        await apiService.postData(
            path: UrlEndpoint.resetPassword(), data: resetPasswordModel.toJson());
        print("resetPasswordModel.toJson() ${resetPasswordModel.toJson()}");

        return const Right("تم تسجيل تغيير الباسورد بنجاح");
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
          return Left(e.response?.data.toString() ?? 'Unknown error');
        }
        return const Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
      } catch (e) {
        return const Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
      }}


}

