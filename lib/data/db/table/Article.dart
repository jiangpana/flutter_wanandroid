import 'package:sqflite/sqflite.dart';

import '../WanAndroidDatabase.dart';

const String tableArticle = 'article';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnChapterName = 'chapterName';
const String columnShareUser = 'shareUser';
const String columnNiceDate = 'niceDate';
const String columnLink = 'link';
const String columnCollect = 'collect';

class Article {
  int id;
  String? title;
  String? chapterName;
  String? shareUser;
  String? niceDate;
  String? link;
  bool? collect;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnShareUser: shareUser,
      columnNiceDate: niceDate,
      columnLink: link,
      columnChapterName: chapterName,
      columnCollect: collect == true ? 1 : 0
    };
    map[columnId] = id;
    return map;
  }

  Article(
      {required this.id,
      this.title,
      this.chapterName,
      this.shareUser,
      this.niceDate,
      this.link,
      this.collect});

  factory Article.fromMap(Map<String, dynamic> map) => Article(
      id: map[columnId],
      title: map[columnTitle],
      chapterName: map[columnChapterName],
      shareUser: map[columnShareUser],
      niceDate: map[columnNiceDate],
      link: map[columnLink],
      collect: map[columnCollect] == 1);
}

class ArticleTableProvider {
  late Database _db;

  static ArticleTableProvider? _instance ;

  static ArticleTableProvider get()=>ArticleTableProvider();

  factory ArticleTableProvider() {
    _instance ??= ArticleTableProvider._();
    return _instance!;
  }
  ArticleTableProvider._(){
    open();
  }
  Future open() async {
    var databasesPath = await getDatabasesPath();
    _db = await openDatabase(dateBaseName, version: 1,
        onCreate: (Database _db, int version) async {
      await _db.execute('''
create table $tableArticle ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnChapterName text not null,
  $columnShareUser text not null,
  $columnNiceDate text not null,
  $columnLink text not null,
  $columnCollect integer not null)
''');
    });
  }

  Future<Article> insert(Article article) async {
    // article.id = await _db.insert(tableArticle, article.toMap() ,conflictAlgorithm:ConflictAlgorithm.replace);
    // return article;
    var batch= _db.batch();
    batch.delete(tableArticle, where: '$columnId = ?', whereArgs: [article.id]);
    batch.insert(tableArticle, article.toMap() ,conflictAlgorithm:ConflictAlgorithm.replace);
    await batch.commit(continueOnError: true);
   return article;
  }

  Future<List<Article>?> getAll() async {
    List<Map<String, dynamic>> maps = await _db.query(tableArticle);
    if (maps.isNotEmpty) {
      var list =<Article>[];
      for (var element in maps) {
        list.add(Article.fromMap(element));
      }
      return list;
    }
    return null;
  }

  Future<Article?> getArticle(int id) async {
    List<Map<String, dynamic>> maps = await _db.query(tableArticle,
        columns: [columnId, columnTitle,columnChapterName ,columnShareUser,  columnNiceDate  ,columnCollect],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Article.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await _db
        .delete(tableArticle, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Article article) async {
    return await _db.update(tableArticle, article.toMap(),
        where: '$columnId = ?', whereArgs: [article.id]);
  }

  Future close() async => _db.close();
}
