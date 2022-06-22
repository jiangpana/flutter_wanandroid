import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
part 'collect_entity.g.dart';

@JsonSerializable()
class CollectEntity {

	int? curPage;
	List<CollectDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
  
  CollectEntity();

  factory CollectEntity.fromJson(Map<String, dynamic> json) => _$CollectEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CollectEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectDatas {

	String? author;
	int? chapterId;
	String? chapterName;
	int? courseId;
	String? desc;
	String? envelopePic;
	int? id;
	String? link;
	String? niceDate;
	String? origin;
	int? originId;
	int? publishTime;
	String? title;
	int? userId;
	int? visible;
	int? zan;
  
  CollectDatas();

  factory CollectDatas.fromJson(Map<String, dynamic> json) => _$CollectDatasFromJson(json);

  Map<String, dynamic> toJson() => _$CollectDatasToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}