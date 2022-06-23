import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
part 'userinfo_entity.g.dart';

@JsonSerializable()
class UserinfoEntity {

	UserinfoCoinInfo? coinInfo;
	UserinfoCollectArticleInfo? collectArticleInfo;
	UserinfoUserInfo? userInfo;
  
  UserinfoEntity();

  factory UserinfoEntity.fromJson(Map<String, dynamic> json) => _$UserinfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserinfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserinfoCoinInfo {

	int? coinCount;
	int? level;
	String? nickname;
	String? rank;
	int? userId;
	String? username;
  
  UserinfoCoinInfo();

  factory UserinfoCoinInfo.fromJson(Map<String, dynamic> json) => _$UserinfoCoinInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserinfoCoinInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserinfoCollectArticleInfo {

	int? count;
  
  UserinfoCollectArticleInfo();

  factory UserinfoCollectArticleInfo.fromJson(Map<String, dynamic> json) => _$UserinfoCollectArticleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserinfoCollectArticleInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserinfoUserInfo {

	bool? admin;
	List<dynamic>? chapterTops;
	int? coinCount;
	List<int>? collectIds;
	String? email;
	String? icon;
	int? id;
	String? nickname;
	String? password;
	String? publicName;
	String? token;
	int? type;
	String? username;
  
  UserinfoUserInfo();

  factory UserinfoUserInfo.fromJson(Map<String, dynamic> json) => _$UserinfoUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserinfoUserInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}