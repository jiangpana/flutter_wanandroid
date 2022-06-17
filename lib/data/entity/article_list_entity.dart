import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
part 'article_list_entity.g.dart';

@JsonSerializable()
class ArticleListEntity {

	int? curPage;
	List<ArticleListDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
  
  ArticleListEntity();

  factory ArticleListEntity.fromJson(Map<String, dynamic> json) => _$ArticleListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ArticleListDatas {

	String? apkLink;
	int? audit;
	String? author;
	bool? canEdit;
	int? chapterId;
	String? chapterName;
	bool? collect;
	int? courseId;
	String? desc;
	String? descMd;
	String? envelopePic;
	bool? fresh;
	String? host;
	int? id;
	String? link;
	String? niceDate;
	String? niceShareDate;
	String? origin;
	String? prefix;
	String? projectLink;
	int? publishTime;
	int? realSuperChapterId;
	int? selfVisible;
	int? shareDate;
	String? shareUser;
	int? superChapterId;
	String? superChapterName;
	List<dynamic>? tags;
	String? title;
	int? type;
	int? userId;
	int? visible;
	int? zan;
  
  ArticleListDatas();

  factory ArticleListDatas.fromJson(Map<String, dynamic> json) => _$ArticleListDatasFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleListDatasToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}