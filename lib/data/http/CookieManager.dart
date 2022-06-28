import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'WanUrls.dart';


const keyCookie = "cookie";


class CookieManager extends Interceptor {

  CookieManager._();

  static  CookieManager? _instance ;

  factory CookieManager() {
    _instance??=CookieManager._();
    return _instance!;
  }

  static get instance => CookieManager();

  List<String>? _cookie;

  Future initCookie() async {
    var prefs = await SharedPreferences.getInstance();
    _cookie = prefs.getStringList(keyCookie);
  }

  void _persistCookie(List<String> newCookie) async {
    if (_cookie != newCookie) {
      _cookie = newCookie;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(keyCookie, newCookie);
    }
  }

  void _clearCookie() async {
    _cookie = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyCookie);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      if (response.realUri.toString().contains(WanUrls.LOGIN)) {
        if (response.headers.map['set-cookie'] != null) {
          _persistCookie(response.headers.map['set-cookie']!);
        }
      }
      if (response.realUri.toString() == WanUrls.LOGOUT) {
        _clearCookie();
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers[keyCookie] = _cookie;
    return super.onRequest(options, handler);
  }
}
