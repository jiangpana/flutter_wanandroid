import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {

	bool? admin;
	List<dynamic>? chapterTops;
	int? coinCount;
	List<dynamic>? collectIds;
	String? email;
	String? icon;
	int? id;
	String? nickname;
	String? password;
	String? publicName;
	String? token;
	int? type;
	String? username;
  
  UserEntity();

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}