import 'package:dio/dio.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  // factory DioHelper() => _instance;

  static DioHelper _internal() {
    print('*******');
    print('_internal');
    // return DioHelper();
    return DioHelper();
  }

  Dio? _dio;

  Dio getDio() {
    print('*******');
    print('getDio');
    _dio ??= Dio()
      ..options.baseUrl = 'https://www.mocky.io/v2/'
      // ..options.responseType = ResponseType.stream
      ..options.responseType = ResponseType.plain
      ..options.connectTimeout = 5000
      ..options.receiveTimeout = 3000
      ..interceptors.add(LogInterceptor(responseBody: true, error: true));
    return _dio!;
  }
}
