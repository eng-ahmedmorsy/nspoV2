import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nspo/Core/constance/url.dart';
import 'package:nspo/Core/servies/api_services.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/Repo/RequsetChangePhoneRepo.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/models/RequsetChangePhone.dart';

class RequestChangePhoneRepoImpl implements RequestChangePhoneRepo {
  @override
  Future<Either<String, String>> addChangePhoneRequest(
      RequestChangePhone requestChangePhone) async {
    try {
      ApiService apiService = ApiService();
      await apiService.postData(
          path: UrlEndpoint.addChangePhoneRequest(),
          data: requestChangePhone.toJson());

      return const Right('Request Added');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
            "فشل الاتصال بالخادم، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (e.error is SocketException) {
        return Left(
            "لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
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
  Future<Either<String, RequestChangePhone>> getLastChangePhoneRequest(
      int personId) async {
    try {
      ApiService apiService = ApiService();
      RequestChangePhone requestChangePhone = RequestChangePhone();
      var response = await apiService.postData(
          path: UrlEndpoint.getLastRequest(),
          queryParameters: {'personId': personId});
      requestChangePhone = RequestChangePhone.fromJson(response.data);

      return Right(requestChangePhone);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
            "فشل الاتصال بالخادم، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (e.error is SocketException) {
        return Left(
            "لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      }
      return Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    } catch (e) {
      return const Left("حدث خطأ ما");
    }
  }

  @override
  Future<Either<String, String>> delete(
      int id) async {
    try {
      ApiService apiService = ApiService();
      await apiService.postData(
          path: UrlEndpoint.deleteRequestChangePhone(),
          queryParameters: {'id': id});

      return const Right('Request deleted');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
            "فشل الاتصال بالخادم، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
      } else if (e.error is SocketException) {
        return Left(
            "لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.");
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
  }}
