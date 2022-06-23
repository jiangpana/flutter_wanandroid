import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;

import '../../generated/json/base/json_convert_content.dart';

class WanSp {
  WanSp._();

  static WanSp? _instance;

  factory WanSp() {
    _instance ??= WanSp._();
    return _instance!;
  }

  Future<T?> get<T>(String key) async {
    var sp = await SharedPreferences.getInstance();
    var jsonStr = sp.getString(key);
    if(jsonStr==null){
      return null;
    }
    return jsonConvert.convert<T>(convert.jsonDecode(jsonStr));
  }

  put<T>(String key, String json) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, json);
  }

  remove(String key) async {
    var sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
}
