part of 'user_entity.dart';


UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
	final UserEntity userEntity = UserEntity();
	final bool? admin = jsonConvert.convert<bool>(json['admin']);
	if (admin != null) {
		userEntity.admin = admin;
	}
	final List<dynamic>? chapterTops = jsonConvert.convertListNotNull<dynamic>(json['chapterTops']);
	if (chapterTops != null) {
		userEntity.chapterTops = chapterTops;
	}
	final int? coinCount = jsonConvert.convert<int>(json['coinCount']);
	if (coinCount != null) {
		userEntity.coinCount = coinCount;
	}
	final List<dynamic>? collectIds = jsonConvert.convertListNotNull<dynamic>(json['collectIds']);
	if (collectIds != null) {
		userEntity.collectIds = collectIds;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		userEntity.email = email;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		userEntity.icon = icon;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		userEntity.id = id;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		userEntity.nickname = nickname;
	}
	final String? password = jsonConvert.convert<String>(json['password']);
	if (password != null) {
		userEntity.password = password;
	}
	final String? publicName = jsonConvert.convert<String>(json['publicName']);
	if (publicName != null) {
		userEntity.publicName = publicName;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		userEntity.token = token;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		userEntity.type = type;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userEntity.username = username;
	}
	return userEntity;
}

Map<String, dynamic> _$UserEntityToJson(UserEntity entity) {
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