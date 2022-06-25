

import 'package:flutter_wanandroid/data/db/table/Article.dart';

const databaseName ="wan_android.db";


class WanAndroidDatabase{

  static WanAndroidDatabase? _instance ;

  factory WanAndroidDatabase() {
    _instance ??= WanAndroidDatabase._();
    return _instance!;
  }
  WanAndroidDatabase._();

  final articleTable = ArticleTableProvider.get();


}
