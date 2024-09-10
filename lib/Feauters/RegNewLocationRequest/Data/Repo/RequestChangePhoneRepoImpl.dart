import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nspo/Core/constance/url.dart';
import 'package:nspo/Core/servies/api_services.dart';

import '../models/RegNewLocationModel.dart';
import 'RequsetChangePhoneRepo.dart';

class RegNewLocationRepoImpl implements RegNewLocationRepo {
  @override
  Future<Either<String, RegNewLocationRequestModel>> getLastRegNewLocation(
      int personId) async {
    try {
      ApiService apiService = ApiService();
      var response = await apiService.postData(
          path: UrlEndpoint.getLastRegLocationRequest(),
          queryParameters: {'personId': personId});
      RegNewLocationRequestModel reg = RegNewLocationRequestModel.fromJson(response.data);

      return Right(reg);
    } on DioException catch(e){
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
      return Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    } catch (e) {
      return const Left("حدث خطأ ما");
    }
  }

  @override
  Future<Either<String, String>> addNewLocationRequestRequest(
      RegNewLocationRequestModel regNewLocationRequest) async {
    try {
      ApiService apiService = ApiService();
      await apiService.postData(
          path: UrlEndpoint.regLocationRequest(),
          data: regNewLocationRequest.toJson());

      return const Right('Request Added');
    } catch (e) {
      return const Left("حدث خطأ ما");
    }
  }

  @override
  Future<Either<String, String>> Delete(int id) async{
  try {
      ApiService apiService = ApiService();
      apiService.postData(path: UrlEndpoint.deleteRegLocationRequest(), queryParameters: {'id': id});
      return const Right('Request Deleted');
    } catch (e) {
      return const Left("حدث خطأ ما");
    }
  }
}
