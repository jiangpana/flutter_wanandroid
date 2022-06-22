// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectEntity _$CollectEntityFromJson(Map<String, dynamic> json) =>
    CollectEntity()
      ..curPage = json['curPage'] as int?
      ..datas = (json['datas'] as List<dynamic>?)
          ?.map((e) => CollectDatas.fromJson(e as Map<String, dynamic>))
          .toList()
      ..offset = json['offset'] as int?
      ..over = json['over'] as bool?
      ..pageCount = json['pageCount'] as int?
      ..size = json['size'] as int?
      ..total = json['total'] as int?;

Map<String, dynamic> _$CollectEntityToJson(CollectEntity instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };

CollectDatas _$CollectDatasFromJson(Map<String, dynamic> json) => CollectDatas()
  ..author = json['author'] as String?
  ..chapterId = json['chapterId'] as int?
  ..chapterName = json['chapterName'] as String?
  ..courseId = json['courseId'] as int?
  ..desc = json['desc'] as String?
  ..envelopePic = json['envelopePic'] as String?
  ..id = json['id'] as int?
  ..link = json['link'] as String?
  ..niceDate = json['niceDate'] as String?
  ..origin = json['origin'] as String?
  ..originId = json['originId'] as int?
  ..publishTime = json['publishTime'] as int?
  ..title = json['title'] as String?
  ..userId = json['userId'] as int?
  ..visible = json['visible'] as int?
  ..zan = json['zan'] as int?;

Map<String, dynamic> _$CollectDatasToJson(CollectDatas instance) =>
    <String, dynamic>{
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'originId': instance.originId,
      'publishTime': instance.publishTime,
      'title': instance.title,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
    };
