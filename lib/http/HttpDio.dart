

import 'package:dio/dio.dart';

import 'CookieManager.dart';

class HttpDio {
  late Dio instance;

    HttpDio() {
    instance = Dio();
    instance.interceptors.add(TokenInterceptor());
    instance.interceptors.add(CookieManager.instance);
  }

  addGlobalHeaders(map) {
    instance.options.headers.addAll(map);
  }

  addGlobalHeader(key, value) {
    instance.options.headers.addAll({key: value});
  }

  addInterceptor(interceptor) {
    instance.interceptors.add(interceptor);
  }
}



class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    ///token from cache
    // var token = Cache.getToken();
    // options.headers["Authorization"] = "Basic $token";
    print(options.uri);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}



