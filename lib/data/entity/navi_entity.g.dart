part of 'navi_entity.dart';


NaviEntity _$NaviEntityFromJson(Map<String, dynamic> json) {
	final NaviEntity naviEntity = NaviEntity();
	final List<NaviArticles>? articles = jsonConvert.convertListNotNull<NaviArticles>(json['articles']);
	if (articles != null) {
		naviEntity.articles = articles;
	}
	final double? cid = jsonConvert.convert<double>(json['cid']);
	if (cid != null) {
		naviEntity.cid = cid;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		naviEntity.name = name;
	}
	return naviEntity;
}

Map<String, dynamic> _$NaviEntityToJson(NaviEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['articles'] =  entity.articles?.map((v) => v.toJson()).toList();
	data['cid'] = entity.cid;
	data['name'] = entity.name;
	return data;
}

NaviArticles _$NaviArticlesFromJson(Map<String, dynamic> json) {
	final NaviArticles naviArticles = NaviArticles();
	final String? apkLink = jsonConvert.convert<String>(json['apkLink']);
	if (apkLink != null) {
		naviArticles.apkLink = apkLink;
	}
	final double? audit = jsonConvert.convert<double>(json['audit']);
	if (audit != null) {
		naviArticles.audit = audit;
	}
	final String? author = jsonConvert.convert<String>(json['author']);
	if (author != null) {
		naviArticles.author = author;
	}
	final bool? canEdit = jsonConvert.convert<bool>(json['canEdit']);
	if (canEdit != null) {
		naviArticles.canEdit = canEdit;
	}
	final double? chapterId = jsonConvert.convert<double>(json['chapterId']);
	if (chapterId != null) {
		naviArticles.chapterId = chapterId;
	}
	final String? chapterName = jsonConvert.convert<String>(json['chapterName']);
	if (chapterName != null) {
		naviArticles.chapterName = chapterName;
	}
	final bool? collect = jsonConvert.convert<bool>(json['collect']);
	if (collect != null) {
		naviArticles.collect = collect;
	}
	final double? courseId = jsonConvert.convert<double>(json['courseId']);
	if (courseId != null) {
		naviArticles.courseId = courseId;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		naviArticles.desc = desc;
	}
	final String? descMd = jsonConvert.convert<String>(json['descMd']);
	if (descMd != null) {
		naviArticles.descMd = descMd;
	}
	final String? envelopePic = jsonConvert.convert<String>(json['envelopePic']);
	if (envelopePic != null) {
		naviArticles.envelopePic = envelopePic;
	}
	final bool? fresh = jsonConvert.convert<bool>(json['fresh']);
	if (fresh != null) {
		naviArticles.fresh = fresh;
	}
	final String? host = jsonConvert.convert<String>(json['host']);
	if (host != null) {
		naviArticles.host = host;
	}
	final double? id = jsonConvert.convert<double>(json['id']);
	if (id != null) {
		naviArticles.id = id;
	}
	final String? link = jsonConvert.convert<String>(json['link']);
	if (link != null) {
		naviArticles.link = link;
	}
	final String? niceDate = jsonConvert.convert<String>(json['niceDate']);
	if (niceDate != null) {
		naviArticles.niceDate = niceDate;
	}
	final String? niceShareDate = jsonConvert.convert<String>(json['niceShareDate']);
	if (niceShareDate != null) {
		naviArticles.niceShareDate = niceShareDate;
	}
	final String? origin = jsonConvert.convert<String>(json['origin']);
	if (origin != null) {
		naviArticles.origin = origin;
	}
	final String? prefix = jsonConvert.convert<String>(json['prefix']);
	if (prefix != null) {
		naviArticles.prefix = prefix;
	}
	final String? projectLink = jsonConvert.convert<String>(json['projectLink']);
	if (projectLink != null) {
		naviArticles.projectLink = projectLink;
	}
	final double? publishTime = jsonConvert.convert<double>(json['publishTime']);
	if (publishTime != null) {
		naviArticles.publishTime = publishTime;
	}
	final double? realSuperChapterId = jsonConvert.convert<double>(json['realSuperChapterId']);
	if (realSuperChapterId != null) {
		naviArticles.realSuperChapterId = realSuperChapterId;
	}
	final double? selfVisible = jsonConvert.convert<double>(json['selfVisible']);
	if (selfVisible != null) {
		naviArticles.selfVisible = selfVisible;
	}
	final double? shareDate = jsonConvert.convert<double>(json['shareDate']);
	if (shareDate != null) {
		naviArticles.shareDate = shareDate;
	}
	final String? shareUser = jsonConvert.convert<String>(json['shareUser']);
	if (shareUser != null) {
		naviArticles.shareUser = shareUser;
	}
	final double? superChapterId = jsonConvert.convert<double>(json['superChapterId']);
	if (superChapterId != null) {
		naviArticles.superChapterId = superChapterId;
	}
	final String? superChapterName = jsonConvert.convert<String>(json['superChapterName']);
	if (superChapterName != null) {
		naviArticles.superChapterName = superChapterName;
	}
	final List<dynamic>? tags = jsonConvert.convertListNotNull<dynamic>(json['tags']);
	if (tags != null) {
		naviArticles.tags = tags;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		naviArticles.title = title;
	}
	final double? type = jsonConvert.convert<double>(json['type']);
	if (type != null) {
		naviArticles.type = type;
	}
	final double? userId = jsonConvert.convert<double>(json['userId']);
	if (userId != null) {
		naviArticles.userId = userId;
	}
	final double? visible = jsonConvert.convert<double>(json['visible']);
	if (visible != null) {
		naviArticles.visible = visible;
	}
	final double? zan = jsonConvert.convert<double>(json['zan']);
	if (zan != null) {
		naviArticles.zan = zan;
	}
	return naviArticles;
}

Map<String, dynamic> _$NaviArticlesToJson(NaviArticles entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['apkLink'] = entity.apkLink;
	data['audit'] = entity.audit;
	data['author'] = entity.author;
	data['canEdit'] = entity.canEdit;
	data['chapterId'] = entity.chapterId;
	data['chapterName'] = entity.chapterName;
	data['collect'] = entity.collect;
	data['courseId'] = entity.courseId;
	data['desc'] = entity.desc;
	data['descMd'] = entity.descMd;
	data['envelopePic'] = entity.envelopePic;
	data['fresh'] = entity.fresh;
	data['host'] = entity.host;
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['niceDate'] = entity.niceDate;
	data['niceShareDate'] = entity.niceShareDate;
	data['origin'] = entity.origin;
	data['prefix'] = entity.prefix;
	data['projectLink'] = entity.projectLink;
	data['publishTime'] = entity.publishTime;
	data['realSuperChapterId'] = entity.realSuperChapterId;
	data['selfVisible'] = entity.selfVisible;
	data['shareDate'] = entity.shareDate;
	data['shareUser'] = entity.shareUser;
	data['superChapterId'] = entity.superChapterId;
	data['superChapterName'] = entity.superChapterName;
	data['tags'] =  entity.tags;
	data['title'] = entity.title;
	data['type'] = entity.type;
	data['userId'] = entity.userId;
	data['visible'] = entity.visible;
	data['zan'] = entity.zan;
	return data;
}