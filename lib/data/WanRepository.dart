

import 'package:flutter_wanandroid/data/sp/WanSp.dart';

import 'db/WanAndroidDatabase.dart';


class WanRepository {

  WanRepository._();
  static  WanRepository? _instance ;
  factory WanRepository(){
    _instance??= WanRepository._();
    return _instance!;
  }

  var db = WanAndroidDatabase();
  var sp = WanSp();

}
