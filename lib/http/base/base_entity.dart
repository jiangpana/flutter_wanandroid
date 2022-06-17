import 'dart:convert';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class BaseEntity<T> {
  T? data;
  int? errorCode;
  String? errorMsg;

  BaseEntity();

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class BaseListEntity<T> {
  List<T>? data;
  int? errorCode;
  String? errorMsg;

  BaseListEntity();

  factory BaseListEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseListEntityFromJson(json);

  @override
  String toString() {
    return data.toString();
  }
}

BaseEntity<T> _$BaseEntityFromJson<T>(Map<String, dynamic> json) {
  final BaseEntity<T> baseEntity = BaseEntity();
  T? data = jsonConvert.convert<T>(json['data']);
  if (data != null) {
    baseEntity.data = data;
  }
  final int? errorCode = jsonConvert.convert<int>(json['errorCode']);
  if (errorCode != null) {
    baseEntity.errorCode = errorCode;
  }
  final String? errorMsg = jsonConvert.convert<String>(json['errorMsg']);
  if (errorMsg != null) {
    baseEntity.errorMsg = errorMsg;
  }
  return baseEntity;
}

BaseListEntity<A> _$BaseListEntityFromJson<A>(Map<String, dynamic> json) {
  final BaseListEntity<A> baseEntity = BaseListEntity();
  var data = jsonConvert.convertListNotNull<A>(json['data']);
  if (data != null) {
    baseEntity.data = data;
  }
  final int? errorCode = jsonConvert.convert<int>(json['errorCode']);
  if (errorCode != null) {
    baseEntity.errorCode = errorCode;
  }
  final String? errorMsg = jsonConvert.convert<String>(json['errorMsg']);
  if (errorMsg != null) {
    baseEntity.errorMsg = errorMsg;
  }
  return baseEntity;
}

Map<String, dynamic> _$BaseEntityToJson(BaseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data?.toJson();
  data['errorCode'] = entity.errorCode;
  data['errorMsg'] = entity.errorMsg;
  return data;
}
