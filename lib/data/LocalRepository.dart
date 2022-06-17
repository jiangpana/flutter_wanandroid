import 'package:shared_preferences/shared_preferences.dart';

import '../generated/json/base/json_convert_content.dart';
import 'dart:convert' as convert;

class LocalRepository {
  LocalRepository._private();

  static final _instance = LocalRepository._private();

  factory LocalRepository() => _instance;

  Future<T?> get<T>(String key) async {
    var sp = await SharedPreferences.getInstance();
    var jsonStr =sp.getString(key);
    return jsonConvert.convert<T>(convert.jsonDecode(jsonStr!));
  }

  put<T>(String key, String json) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, json);
  }

  remove(String key) async{
    var sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
}
