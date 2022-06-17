import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
part 'navi_entity.g.dart';

@JsonSerializable()
class NaviEntity {

	List<NaviArticles>? articles;
	double? cid;
	String? name;
  
  NaviEntity();

  factory NaviEntity.fromJson(Map<String, dynamic> json) => _$NaviEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NaviEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class NaviArticles {

	String? apkLink;
	double? audit;
	String? author;
	bool? canEdit;
	double? chapterId;
	String? chapterName;
	bool? collect;
	double? courseId;
	String? desc;
	String? descMd;
	String? envelopePic;
	bool? fresh;
	String? host;
	double? id;
	String? link;
	String? niceDate;
	String? niceShareDate;
	String? origin;
	String? prefix;
	String? projectLink;
	double? publishTime;
	double? realSuperChapterId;
	double? selfVisible;
	double? shareDate;
	String? shareUser;
	double? superChapterId;
	String? superChapterName;
	List<dynamic>? tags;
	String? title;
	double? type;
	double? userId;
	double? visible;
	double? zan;
  
  NaviArticles();

  factory NaviArticles.fromJson(Map<String, dynamic> json) => _$NaviArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$NaviArticlesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}