import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/http/WanUrls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookieManager extends Interceptor {
  CookieManager._internal();

  static final CookieManager _instance = CookieManager._internal();

  factory CookieManager() {
    return _instance;
  }

  static get instance => _instance;

  String? _cookie;

  Future initCookie() async {
    var prefs = await SharedPreferences.getInstance();
    print("cookie -> init ${prefs.getString('cookie')}");
    _cookie = prefs.getString('cookie');
  }

  void _persistCookie(String newCookie) async {
    if (_cookie != newCookie) {
      _cookie = newCookie;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('cookie', _cookie!);
    }
  }

  void _clearCookie() async {
    _cookie = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cookie');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response != null) {
      if (response.statusCode == 200) {
        if (response.realUri.toString().contains(WanUrls.LOGIN)) {
          if (response.headers.map['set-cookie'] != null) {
            print("cookie -> ${response.headers.map['set-cookie']![0]}");
            _persistCookie(response.headers.map['set-cookie']![0]);
          }
        }
        if (response.realUri.toString() == WanUrls.LOGOUT) {
          print("cookie -> clear");
          _clearCookie();
        }
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['Cookie'] = _cookie;
    return super.onRequest(options, handler);
  }
}
