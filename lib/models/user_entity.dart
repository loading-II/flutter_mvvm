import 'package:we_flutter/generated/json/base/json_field.dart';
import 'package:we_flutter/generated/json/user_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserEntity {
	late bool admin;
	late List<dynamic> chapterTops;
	late int coinCount;
	late List<int> collectIds;
	late String email;
	late String icon;
	late int id;
	late String nickname;
	late String password;
	late String publicName;
	late String token;
	late int type;
	late String username;

	UserEntity();

	factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}