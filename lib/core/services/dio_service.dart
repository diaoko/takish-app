import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioService {
  static final _logger = Logger();

  Future<dynamic> getMethod({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final Dio dio = Dio();

    // Header
    dio.options.headers['content-Type'] = 'application/json'; //! ;charset=UTF-8

    try {
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.json,
          method: 'GET',
          headers: headers,
        ),
      );

      return response;
    } on DioException catch (e) {
      _logger.e('DioException: $e');
      return e.response;
    }
  }

  Future<dynamic> postMethod({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final Dio dio = Dio();

    // Header
    dio.options.headers['content-Type'] = 'application/json';

    try {
      Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.json,
          method: 'POST',
          contentType: Headers.jsonContentType,
          headers: headers,
        ),
      );

      return response;
    } on DioException catch (e) {
      print('DioException: $e');
      _logger.e('DioException: $e');
      return e.response;
    }
  }

  Future<dynamic> putMethod({
    required String url,
    String? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final Dio dio = Dio();

    // Header
    dio.options.headers['content-Type'] = 'application/json';

    try {
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.json,
          method: 'PUT',
          contentType: Headers.jsonContentType,
          headers: headers,
        ),
      );

      return response;
    } on DioException catch (e) {
      _logger.e('DioException: $e');
      return e.response;
    }
  }

  Future<dynamic> deleteMethod({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final Dio dio = Dio();

    // Header
    dio.options.headers['content-Type'] = 'application/json'; //! ;charset=UTF-8

    try {
      Response response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.json,
          method: 'DELETE',
          headers: headers,
        ),
      );

      return response;
    } on DioException catch (e) {
      _logger.e('DioException: $e');
      return e.response;
    }
  }
}
