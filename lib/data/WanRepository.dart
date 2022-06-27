

import 'package:flutter_wanandroid/base/vm/BaseViewModel.dart';
import 'package:flutter_wanandroid/data/sp/WanSp.dart';

import 'db/WanAndroidDatabase.dart';
import 'http/WanServer.dart';


class WanRepository {

  late  BaseViewModel vm ;

  WanRepository._(this.vm );

  static  WanRepository? _instance ;

  factory WanRepository(BaseViewModel vm){
    _instance??= WanRepository._(vm);
    return _instance!;
  }

  static var db = WanAndroidDatabase();
  static var sp = WanSp();
  late var server =WanAndroidServer(vm);
}
