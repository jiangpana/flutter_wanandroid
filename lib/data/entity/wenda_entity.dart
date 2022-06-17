import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
part 'wenda_entity.g.dart';

@JsonSerializable()
class WendaEntity {

	int? curPage;
	List<WendaDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
  
  WendaEntity();

  factory WendaEntity.fromJson(Map<String, dynamic> json) => _$WendaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WendaEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WendaDatas {

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
	List<WendaDatasTags>? tags;
	String? title;
	int? type;
	int? userId;
	int? visible;
	int? zan;
  
  WendaDatas();

  factory WendaDatas.fromJson(Map<String, dynamic> json) => _$WendaDatasFromJson(json);

  Map<String, dynamic> toJson() => _$WendaDatasToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WendaDatasTags {

	String? name;
	String? url;
  
  WendaDatasTags();

  factory WendaDatasTags.fromJson(Map<String, dynamic> json) => _$WendaDatasTagsFromJson(json);

  Map<String, dynamic> toJson() => _$WendaDatasTagsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}