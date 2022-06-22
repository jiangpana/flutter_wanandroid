import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/entity/article_list_entity.dart';

part 'HomePageState.freezed.dart';

@freezed
class HomePageState with _$HomePageState{
  factory HomePageState({ @Default([]) List<ArticleListDatas> datas  , ArticleListEntity? articleListEntity}) = _HomePageState;

}