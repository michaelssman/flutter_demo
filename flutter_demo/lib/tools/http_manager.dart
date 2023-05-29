import 'package:dio/dio.dart';

/// 封装网络库

enum HttpMethod { get, post }

class HttpManager {
  //创建dio单例对象
  static Dio? _dioInstance;
  static Dio? _getDioInstance() {
    // if (_dioInstance == null) {
    //   _dioInstance = Dio();
    // }
    _dioInstance ??= Dio();
    return _dioInstance;
  }

  //类方法
  static Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await _sendRequest(HttpMethod.get, url,
        queryParameters: queryParameters);
  }

  static Future<Response> post(String url,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    return await _sendRequest(HttpMethod.post, url,
        queryParameters: queryParameters, data: data);
  }

  static Future _sendRequest(HttpMethod method, String url,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    try {
      switch (method) {
        case HttpMethod.get:
          return await HttpManager._getDioInstance()!
              .get(url, queryParameters: queryParameters);
        case HttpMethod.post:
          return await HttpManager._getDioInstance()!
              .post(url, queryParameters: queryParameters, data: data);
        default:
          throw Exception('请求方式错误');
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}
