

import 'package:flutter_wanandroid/base/vm/BaseViewModel.dart';
import 'package:flutter_wanandroid/data/sp/WanSp.dart';

import 'db/WanAndroidDatabase.dart';
import 'http/WanServer.dart';


class WanRepository {

  late  BaseViewModel vm ;

  WanRepository(this.vm ){
    //初始化 db , sp
    WanAndroidDatabase();
    WanSp();
  }

  static var db = WanAndroidDatabase();
  static var sp = WanSp();
  late var server =WanAndroidServer(vm);
}
