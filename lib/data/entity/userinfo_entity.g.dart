part of 'userinfo_entity.dart';


UserinfoEntity _$UserinfoEntityFromJson(Map<String, dynamic> json) {
	final UserinfoEntity userinfoEntity = UserinfoEntity();
	final UserinfoCoinInfo? coinInfo = jsonConvert.convert<UserinfoCoinInfo>(json['coinInfo']);
	if (coinInfo != null) {
		userinfoEntity.coinInfo = coinInfo;
	}
	final UserinfoCollectArticleInfo? collectArticleInfo = jsonConvert.convert<UserinfoCollectArticleInfo>(json['collectArticleInfo']);
	if (collectArticleInfo != null) {
		userinfoEntity.collectArticleInfo = collectArticleInfo;
	}
	final UserinfoUserInfo? userInfo = jsonConvert.convert<UserinfoUserInfo>(json['userInfo']);
	if (userInfo != null) {
		userinfoEntity.userInfo = userInfo;
	}
	return userinfoEntity;
}

Map<String, dynamic> _$UserinfoEntityToJson(UserinfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['coinInfo'] = entity.coinInfo?.toJson();
	data['collectArticleInfo'] = entity.collectArticleInfo?.toJson();
	data['userInfo'] = entity.userInfo?.toJson();
	return data;
}

UserinfoCoinInfo _$UserinfoCoinInfoFromJson(Map<String, dynamic> json) {
	final UserinfoCoinInfo userinfoCoinInfo = UserinfoCoinInfo();
	final int? coinCount = jsonConvert.convert<int>(json['coinCount']);
	if (coinCount != null) {
		userinfoCoinInfo.coinCount = coinCount;
	}
	final int? level = jsonConvert.convert<int>(json['level']);
	if (level != null) {
		userinfoCoinInfo.level = level;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		userinfoCoinInfo.nickname = nickname;
	}
	final String? rank = jsonConvert.convert<String>(json['rank']);
	if (rank != null) {
		userinfoCoinInfo.rank = rank;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		userinfoCoinInfo.userId = userId;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userinfoCoinInfo.username = username;
	}
	return userinfoCoinInfo;
}

Map<String, dynamic> _$UserinfoCoinInfoToJson(UserinfoCoinInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['coinCount'] = entity.coinCount;
	data['level'] = entity.level;
	data['nickname'] = entity.nickname;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	return data;
}

UserinfoCollectArticleInfo _$UserinfoCollectArticleInfoFromJson(Map<String, dynamic> json) {
	final UserinfoCollectArticleInfo userinfoCollectArticleInfo = UserinfoCollectArticleInfo();
	final int? count = jsonConvert.convert<int>(json['count']);
	if (count != null) {
		userinfoCollectArticleInfo.count = count;
	}
	return userinfoCollectArticleInfo;
}

Map<String, dynamic> _$UserinfoCollectArticleInfoToJson(UserinfoCollectArticleInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['count'] = entity.count;
	return data;
}

UserinfoUserInfo _$UserinfoUserInfoFromJson(Map<String, dynamic> json) {
	final UserinfoUserInfo userinfoUserInfo = UserinfoUserInfo();
	final bool? admin = jsonConvert.convert<bool>(json['admin']);
	if (admin != null) {
		userinfoUserInfo.admin = admin;
	}
	final List<dynamic>? chapterTops = jsonConvert.convertListNotNull<dynamic>(json['chapterTops']);
	if (chapterTops != null) {
		userinfoUserInfo.chapterTops = chapterTops;
	}
	final int? coinCount = jsonConvert.convert<int>(json['coinCount']);
	if (coinCount != null) {
		userinfoUserInfo.coinCount = coinCount;
	}
	final List<int>? collectIds = jsonConvert.convertListNotNull<int>(json['collectIds']);
	if (collectIds != null) {
		userinfoUserInfo.collectIds = collectIds;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		userinfoUserInfo.email = email;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		userinfoUserInfo.icon = icon;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		userinfoUserInfo.id = id;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		userinfoUserInfo.nickname = nickname;
	}
	final String? password = jsonConvert.convert<String>(json['password']);
	if (password != null) {
		userinfoUserInfo.password = password;
	}
	final String? publicName = jsonConvert.convert<String>(json['publicName']);
	if (publicName != null) {
		userinfoUserInfo.publicName = publicName;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		userinfoUserInfo.token = token;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		userinfoUserInfo.type = type;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userinfoUserInfo.username = username;
	}
	return userinfoUserInfo;
}

Map<String, dynamic> _$UserinfoUserInfoToJson(UserinfoUserInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['admin'] = entity.admin;
	data['chapterTops'] =  entity.chapterTops;
	data['coinCount'] = entity.coinCount;
	data['collectIds'] =  entity.collectIds;
	data['email'] = entity.email;
	data['icon'] = entity.icon;
	data['id'] = entity.id;
	data['nickname'] = entity.nickname;
	data['password'] = entity.password;
	data['publicName'] = entity.publicName;
	data['token'] = entity.token;
	data['type'] = entity.type;
	data['username'] = entity.username;
	return data;
}