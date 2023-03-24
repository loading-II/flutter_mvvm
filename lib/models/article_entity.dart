import 'package:we_flutter/generated/json/base/json_field.dart';
import 'package:we_flutter/generated/json/article_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ArticleEntity {
	late int curPage;
	late List<ArticleDatas> datas;
	late int offset;
	late bool over;
	late int pageCount;
	late int size;
	late int total;

	ArticleEntity();

	factory ArticleEntity.fromJson(Map<String, dynamic> json) => $ArticleEntityFromJson(json);

	Map<String, dynamic> toJson() => $ArticleEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ArticleDatas {
	late bool adminAdd;
	late String apkLink;
	late int audit;
	late String author;
	late bool canEdit;
	late int chapterId;
	late String chapterName;
	late bool collect;
	late int courseId;
	late String desc;
	late String descMd;
	late String envelopePic;
	late bool fresh;
	late String host;
	late int id;
	late bool isAdminAdd;
	late String link;
	late String niceDate;
	late String niceShareDate;
	late String origin;
	late String prefix;
	late String projectLink;
	late int publishTime;
	late int realSuperChapterId;
	late bool route;
	late int selfVisible;
	late int shareDate;
	late String shareUser;
	late int superChapterId;
	late String superChapterName;
	late List<ArticleDatasTags> tags;
	late String title;
	late int type;
	late int userId;
	late int visible;
	late int zan;

	ArticleDatas();

	factory ArticleDatas.fromJson(Map<String, dynamic> json) => $ArticleDatasFromJson(json);

	Map<String, dynamic> toJson() => $ArticleDatasToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ArticleDatasTags {
	late String name;
	late String url;

	ArticleDatasTags();

	factory ArticleDatasTags.fromJson(Map<String, dynamic> json) => $ArticleDatasTagsFromJson(json);

	Map<String, dynamic> toJson() => $ArticleDatasTagsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}