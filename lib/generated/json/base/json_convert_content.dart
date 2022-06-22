// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_wanandroid/data/entity/article_list_entity.dart';
import 'package:flutter_wanandroid/data/entity/collect_entity.dart';
import 'package:flutter_wanandroid/data/entity/navi_entity.dart';
import 'package:flutter_wanandroid/data/entity/user_entity.dart';
import 'package:flutter_wanandroid/data/entity/wenda_entity.dart';

JsonConvert jsonConvert = JsonConvert();
typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);

class JsonConvert {
	static final Map<String, JsonConvertFunction> _convertFuncMap = {
		(ArticleListEntity).toString(): ArticleListEntity.fromJson,
		(ArticleListDatas).toString(): ArticleListDatas.fromJson,
		(CollectEntity).toString(): CollectEntity.fromJson,
		(CollectDatas).toString(): CollectDatas.fromJson,
		(NaviEntity).toString(): NaviEntity.fromJson,
		(NaviArticles).toString(): NaviArticles.fromJson,
		(UserEntity).toString(): UserEntity.fromJson,
		(WendaEntity).toString(): WendaEntity.fromJson,
		(WendaDatas).toString(): WendaDatas.fromJson,
		(WendaDatasTags).toString(): WendaDatasTags.fromJson,
	};

  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  T? asT<T extends Object?>(dynamic value) {
    if (value is T) {
      return value;
    }
    final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }
      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type == "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type == "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else if (type == "Map" || type.startsWith("Map<")) {
        return value as T;
      } else {
        if (_convertFuncMap.containsKey(type)) {
          return _convertFuncMap[type]!(value) as T;
        } else {
          throw UnimplementedError('$type unimplemented');
        }
      }
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return null;
    }
  }

	//list is returned by type
	static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
		if(<ArticleListEntity>[] is M){
			return data.map<ArticleListEntity>((Map<String, dynamic> e) => ArticleListEntity.fromJson(e)).toList() as M;
		}
		if(<ArticleListDatas>[] is M){
			return data.map<ArticleListDatas>((Map<String, dynamic> e) => ArticleListDatas.fromJson(e)).toList() as M;
		}
		if(<CollectEntity>[] is M){
			return data.map<CollectEntity>((Map<String, dynamic> e) => CollectEntity.fromJson(e)).toList() as M;
		}
		if(<CollectDatas>[] is M){
			return data.map<CollectDatas>((Map<String, dynamic> e) => CollectDatas.fromJson(e)).toList() as M;
		}
		if(<NaviEntity>[] is M){
			return data.map<NaviEntity>((Map<String, dynamic> e) => NaviEntity.fromJson(e)).toList() as M;
		}
		if(<NaviArticles>[] is M){
			return data.map<NaviArticles>((Map<String, dynamic> e) => NaviArticles.fromJson(e)).toList() as M;
		}
		if(<UserEntity>[] is M){
			return data.map<UserEntity>((Map<String, dynamic> e) => UserEntity.fromJson(e)).toList() as M;
		}
		if(<WendaEntity>[] is M){
			return data.map<WendaEntity>((Map<String, dynamic> e) => WendaEntity.fromJson(e)).toList() as M;
		}
		if(<WendaDatas>[] is M){
			return data.map<WendaDatas>((Map<String, dynamic> e) => WendaDatas.fromJson(e)).toList() as M;
		}
		if(<WendaDatasTags>[] is M){
			return data.map<WendaDatasTags>((Map<String, dynamic> e) => WendaDatasTags.fromJson(e)).toList() as M;
		}

		debugPrint("${M.toString()} not found");
	
		return null;
}

	static M? fromJsonAsT<M>(dynamic json) {
		if (json is List) {
			return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
		} else {
			return jsonConvert.asT<M>(json);
		}
	}
}