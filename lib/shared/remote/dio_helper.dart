import 'package:dio/dio.dart';
import '../local/secure_cash_helper.dart';

class DioHelper {
  static late Dio dio;
  static const String baseUrl = "https://lovardportal.online/api/";

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.options.extra['withCredentials'] = true;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Print request details for debugging
          print('Request: ${options.method} ${options.uri}');
          print('Headers: ${options.headers}');
          print('Body: ${options.data}');
          return handler.next(options);
        },
        onError: (e, handler) {
          print(e.message);
          print(e.error);
          print(e.response);
          print(e.requestOptions);
          // Custom error handling for 302 redirections
          if (e.response?.statusCode == 302) {
            print('Redirection message: ${e.response?.data}');
          } else {
            print('Error: ${e.message}');
          }

          // Add custom error information to DioException
          final customError = DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            error: {
              'message': e.response?.data['errors'],
              'msg': e.message,
              'code': e.response?.statusCode,
            },
            type: e.type,
          );

          return handler.next(customError);
        },
      ),
    );
  }

  // Helper function to get the authorization token
  static Future<Map<String, dynamic>> _getHeaders(bool withToken) async {
    final headers = <String, dynamic>{};
    if (withToken) {
      final token = await SecureCashHelper.getToken();
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // GET request
  static Future<Response> getData({
    required String url,
    String urlParam = '',
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    bool withToken = true,
  }) async {
    final headers = await _getHeaders(withToken);
    headers.addAll(header ?? {});
    return dio.get(
      '$url$urlParam',
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  // POST request
  static Future<Response> postData({
    required String url,
    String urlParam = '',
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    bool withToken = true,
  }) async {
    final headers = await _getHeaders(withToken);
    headers.addAll(header ?? {});
    return dio.post(
      '$url$urlParam',
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  // PUT request
  static Future<Response> putData({
    required String url,
    String urlParam = '',
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    bool withToken = true,
  }) async {
    final headers = await _getHeaders(withToken);
    headers.addAll(header ?? {});
    return dio.put(
      '$url$urlParam',
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  // DELETE request
  static Future<Response> deleteData({
    required String url,
    String urlParam = '',
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    bool withToken = true,
  }) async {
    final headers = await _getHeaders(withToken);
    headers.addAll(header ?? {});
    return dio.delete(
      '$url$urlParam',
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }
}
