import 'package:flutter_wanandroid/data/db/table/Article.dart';
import 'package:sqflite/sqflite.dart';

const databaseName = "wan_android.db";

class WanAndroidDatabase {

  static WanAndroidDatabase? _instance;

  factory WanAndroidDatabase() {
    _instance ??= WanAndroidDatabase._();
    return _instance!;
  }

  WanAndroidDatabase._() {
    openDatabase(databaseName, version: 1,
        onCreate: (Database _db, int version) async {
      await _db.execute('''
create table $tableArticle ( 
  $columnId integer primary key autoincrement, 
  $columnArticleId integer not null,
  $columnTitle text not null,
  $columnChapterName text not null,
  $columnShareUser text not null,
  $columnNiceDate text not null,
  $columnLink text not null,
  $columnCollect integer not null)
''');
    }).then((value) {
      articleTable = ArticleTableProvider.get(value);
    });
  }

  late ArticleTableProvider articleTable;
}
