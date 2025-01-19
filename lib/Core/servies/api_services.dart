import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> get(
      {required String path,
      Map<String, dynamic>? queryParameters,
      String? token}) async {
    _addToken(token);

    var response = await _dio.get(path, queryParameters: queryParameters);

    return response.data;
  }

  _addToken(String? token) {
    _dio.options.headers['Authorization'] = "Bearer $token";
    // _dio!.options.headers['Content-Type'] = 'multipart/form-data';
    //_dio!.options.headers['Accept'] = 'application/json';
  }

  Future<Map<String, dynamic>> update(
      {required String path,
      Object? data,
      Options? options,
      String? token,
      Map<String, dynamic>? queryParameters,
      void Function(int, int)? onSendProgress}) async {
    _addToken(token);

    var response = await _dio.put(path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        onSendProgress: onSendProgress);
    return response.data;
  }

   postData(
      {required String path,
      Object? data,
      Options? options,
      String? token,
     Map<String,dynamic>   ? queryParameters,
      void Function(int, int)? onSendProgress}) async {
    // _addToken(token);
     (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
       client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
       return client;
     };

    var response = await _dio.post(path,
        queryParameters: queryParameters,
        data: data, options: options, onSendProgress: onSendProgress);

    return response;
  }

  Future<Map<String, dynamic>> delete(
      {required String path,
      Object? data,
      Options? options,
      String? token,
      void Function(int, int)? onSendProgress}) async {
    _addToken(token);

    var response = await _dio.delete(
      path,
      data: data,
      options: options,
    );
    return response.data;
  }
}
