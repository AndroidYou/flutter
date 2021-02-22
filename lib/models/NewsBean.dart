import 'package:json_annotation/json_annotation.dart';

part 'NewsBean.g.dart';


List<NewsBean> getNewsBeanList(List<dynamic> list){
  List<NewsBean> result = [];
  list.forEach((item){
    result.add(NewsBean.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class NewsBean extends Object {

  @JsonKey(name: 'listId')
  String listId;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'expiredTime')
  int expiredTime;

  @JsonKey(name: 'currentPage')
  int currentPage;

  @JsonKey(name: 'totalPage')
  int totalPage;

  @JsonKey(name: 'topsize')
  int topsize;

  @JsonKey(name: 'item')
  List<Item> item;

  @JsonKey(name: 'showAdvert')
  int showAdvert;

  NewsBean(this.listId,this.type,this.expiredTime,this.currentPage,this.totalPage,this.topsize,this.item,this.showAdvert,);

  factory NewsBean.fromJson(Map<String, dynamic> srcJson) => _$NewsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsBeanToJson(this);

}


@JsonSerializable()
class Item extends Object {

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'style')
  Style style;

  @JsonKey(name: 'thumbnail')
  String thumbnail;

  @JsonKey(name: 'documentId')
  String documentId;

  @JsonKey(name: 'staticId')
  String staticId;

  @JsonKey(name: 'link')
  Link link;
  @JsonKey(name: 'commentsUrl')
  String commentsUrl;

  @JsonKey(name: 'weburl')
  String weburl;

  @JsonKey(name: 'reftype')
  String reftype;

  @JsonKey(name: 'intro')
  String intro;

  @JsonKey(name: 'commentsall')
  String commentsall;

  Item(this.type,this.id,this.title,this.style,this.thumbnail,this.documentId,this.staticId,this.link,this.reftype,this.intro,this.commentsall,);

  factory Item.fromJson(Map<String, dynamic> srcJson) => _$ItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

}


@JsonSerializable()
class Style extends Object {

  @JsonKey(name: 'view')
  String view;

  @JsonKey(name: 'backreason')
  List<String> backreason;

  @JsonKey(name: 'defaultreason')
  String defaultreason;

  @JsonKey(name: 'images')
  List<String> images;


  @JsonKey(name: 'recomReason')
  RecomReason recomReason;

  Style(this.view,this.backreason,this.defaultreason,this.recomReason,this.images);

  factory Style.fromJson(Map<String, dynamic> srcJson) => _$StyleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StyleToJson(this);

}


@JsonSerializable()
class RecomReason extends Object {

  @JsonKey(name: 'reasonStyle')
  String reasonStyle;

  @JsonKey(name: 'reasonName')
  String reasonName;

  RecomReason(this.reasonStyle,this.reasonName,);

  factory RecomReason.fromJson(Map<String, dynamic> srcJson) => _$RecomReasonFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecomReasonToJson(this);

}


@JsonSerializable()
class Link extends Object {

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'url')
  String url;


  @JsonKey(name: 'weburl')
  String weburl;

  Link(this.type,this.url,this.weburl);

  factory Link.fromJson(Map<String, dynamic> srcJson) => _$LinkFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

}


