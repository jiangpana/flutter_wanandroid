// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navi_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaviEntity _$NaviEntityFromJson(Map<String, dynamic> json) => NaviEntity()
  ..articles = (json['articles'] as List<dynamic>?)
      ?.map((e) => NaviArticles.fromJson(e as Map<String, dynamic>))
      .toList()
  ..cid = (json['cid'] as num?)?.toDouble()
  ..name = json['name'] as String?;

Map<String, dynamic> _$NaviEntityToJson(NaviEntity instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name,
    };

NaviArticles _$NaviArticlesFromJson(Map<String, dynamic> json) => NaviArticles()
  ..apkLink = json['apkLink'] as String?
  ..audit = (json['audit'] as num?)?.toDouble()
  ..author = json['author'] as String?
  ..canEdit = json['canEdit'] as bool?
  ..chapterId = (json['chapterId'] as num?)?.toDouble()
  ..chapterName = json['chapterName'] as String?
  ..collect = json['collect'] as bool?
  ..courseId = (json['courseId'] as num?)?.toDouble()
  ..desc = json['desc'] as String?
  ..descMd = json['descMd'] as String?
  ..envelopePic = json['envelopePic'] as String?
  ..fresh = json['fresh'] as bool?
  ..host = json['host'] as String?
  ..id = (json['id'] as num?)?.toDouble()
  ..link = json['link'] as String?
  ..niceDate = json['niceDate'] as String?
  ..niceShareDate = json['niceShareDate'] as String?
  ..origin = json['origin'] as String?
  ..prefix = json['prefix'] as String?
  ..projectLink = json['projectLink'] as String?
  ..publishTime = (json['publishTime'] as num?)?.toDouble()
  ..realSuperChapterId = (json['realSuperChapterId'] as num?)?.toDouble()
  ..selfVisible = (json['selfVisible'] as num?)?.toDouble()
  ..shareDate = (json['shareDate'] as num?)?.toDouble()
  ..shareUser = json['shareUser'] as String?
  ..superChapterId = (json['superChapterId'] as num?)?.toDouble()
  ..superChapterName = json['superChapterName'] as String?
  ..tags = json['tags'] as List<dynamic>?
  ..title = json['title'] as String?
  ..type = (json['type'] as num?)?.toDouble()
  ..userId = (json['userId'] as num?)?.toDouble()
  ..visible = (json['visible'] as num?)?.toDouble()
  ..zan = (json['zan'] as num?)?.toDouble();

Map<String, dynamic> _$NaviArticlesToJson(NaviArticles instance) =>
    <String, dynamic>{
      'apkLink': instance.apkLink,
      'audit': instance.audit,
      'author': instance.author,
      'canEdit': instance.canEdit,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'descMd': instance.descMd,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'host': instance.host,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'niceShareDate': instance.niceShareDate,
      'origin': instance.origin,
      'prefix': instance.prefix,
      'projectLink': instance.projectLink,
      'publishTime': instance.publishTime,
      'realSuperChapterId': instance.realSuperChapterId,
      'selfVisible': instance.selfVisible,
      'shareDate': instance.shareDate,
      'shareUser': instance.shareUser,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
    };
