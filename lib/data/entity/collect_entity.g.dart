part of 'collect_entity.dart';


CollectEntity _$CollectEntityFromJson(Map<String, dynamic> json) {
	final CollectEntity collectEntity = CollectEntity();
	final int? curPage = jsonConvert.convert<int>(json['curPage']);
	if (curPage != null) {
		collectEntity.curPage = curPage;
	}
	final List<CollectDatas>? datas = jsonConvert.convertListNotNull<CollectDatas>(json['datas']);
	if (datas != null) {
		collectEntity.datas = datas;
	}
	final int? offset = jsonConvert.convert<int>(json['offset']);
	if (offset != null) {
		collectEntity.offset = offset;
	}
	final bool? over = jsonConvert.convert<bool>(json['over']);
	if (over != null) {
		collectEntity.over = over;
	}
	final int? pageCount = jsonConvert.convert<int>(json['pageCount']);
	if (pageCount != null) {
		collectEntity.pageCount = pageCount;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		collectEntity.size = size;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		collectEntity.total = total;
	}
	return collectEntity;
}

Map<String, dynamic> _$CollectEntityToJson(CollectEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['curPage'] = entity.curPage;
	data['datas'] =  entity.datas?.map((v) => v.toJson()).toList();
	data['offset'] = entity.offset;
	data['over'] = entity.over;
	data['pageCount'] = entity.pageCount;
	data['size'] = entity.size;
	data['total'] = entity.total;
	return data;
}

CollectDatas _$CollectDatasFromJson(Map<String, dynamic> json) {
	final CollectDatas collectDatas = CollectDatas();
	final String? author = jsonConvert.convert<String>(json['author']);
	if (author != null) {
		collectDatas.author = author;
	}
	final int? chapterId = jsonConvert.convert<int>(json['chapterId']);
	if (chapterId != null) {
		collectDatas.chapterId = chapterId;
	}
	final String? chapterName = jsonConvert.convert<String>(json['chapterName']);
	if (chapterName != null) {
		collectDatas.chapterName = chapterName;
	}
	final int? courseId = jsonConvert.convert<int>(json['courseId']);
	if (courseId != null) {
		collectDatas.courseId = courseId;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		collectDatas.desc = desc;
	}
	final String? envelopePic = jsonConvert.convert<String>(json['envelopePic']);
	if (envelopePic != null) {
		collectDatas.envelopePic = envelopePic;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		collectDatas.id = id;
	}
	final String? link = jsonConvert.convert<String>(json['link']);
	if (link != null) {
		collectDatas.link = link;
	}
	final String? niceDate = jsonConvert.convert<String>(json['niceDate']);
	if (niceDate != null) {
		collectDatas.niceDate = niceDate;
	}
	final String? origin = jsonConvert.convert<String>(json['origin']);
	if (origin != null) {
		collectDatas.origin = origin;
	}
	final int? originId = jsonConvert.convert<int>(json['originId']);
	if (originId != null) {
		collectDatas.originId = originId;
	}
	final int? publishTime = jsonConvert.convert<int>(json['publishTime']);
	if (publishTime != null) {
		collectDatas.publishTime = publishTime;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		collectDatas.title = title;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		collectDatas.userId = userId;
	}
	final int? visible = jsonConvert.convert<int>(json['visible']);
	if (visible != null) {
		collectDatas.visible = visible;
	}
	final int? zan = jsonConvert.convert<int>(json['zan']);
	if (zan != null) {
		collectDatas.zan = zan;
	}
	return collectDatas;
}

Map<String, dynamic> _$CollectDatasToJson(CollectDatas entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['author'] = entity.author;
	data['chapterId'] = entity.chapterId;
	data['chapterName'] = entity.chapterName;
	data['courseId'] = entity.courseId;
	data['desc'] = entity.desc;
	data['envelopePic'] = entity.envelopePic;
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['niceDate'] = entity.niceDate;
	data['origin'] = entity.origin;
	data['originId'] = entity.originId;
	data['publishTime'] = entity.publishTime;
	data['title'] = entity.title;
	data['userId'] = entity.userId;
	data['visible'] = entity.visible;
	data['zan'] = entity.zan;
	return data;
}