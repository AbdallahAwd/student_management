import 'package:dio/dio.dart';
import 'package:student_system/config/resources/constant.dart';

import '../Cache/cache_helper.dart';
import '../resources/cache_keys.dart';

abstract class BaseNetworkHelper {
  Future<Response> get(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query});
  Future<Response> post(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query});
  Future<Response> delete(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query});
  Future<Response> put(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query});
}

class NetworkHelper extends BaseNetworkHelper {
  late Dio _dio;

  NetworkHelper() {
    _dio = Dio(
      BaseOptions(
          baseUrl: "http://${Constant.baseUrl}:${Constant.basePort}/api",
          contentType: 'application/json',
          headers: {
            'Authorization':
                'Bearer ${CacheHelper.getData(key: CacheKeys.token) ?? ''}',
            "Accept": 'application/json'
          },
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 20)),
    );
  }
  @override
  Future<Response> delete(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    return await _dio.delete(path, data: data, queryParameters: query);
  }

  @override
  Future<Response> get(
      {required String path,
      dynamic data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? query}) async {
    return await _dio.get(path,
        data: data, queryParameters: query, options: Options(headers: headers));
  }

  @override
  Future<Response> post(
      {required String path,
      dynamic data,
      Map<String, dynamic>? query,
      Map<String, dynamic>? headers}) async {
    return await _dio.post(path,
        data: data, queryParameters: query, options: Options(headers: headers));
  }

  @override
  Future<Response> put(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    return await _dio.put(path, data: data, queryParameters: query);
  }
}
