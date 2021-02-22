// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewsBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsBean _$NewsBeanFromJson(Map<String, dynamic> json) {
  return NewsBean(
    json['listId'] as String,
    json['type'] as String,
    json['expiredTime'] as int,
    json['currentPage'] as int,
    json['totalPage'] as int,
    json['topsize'] as int,
    (json['item'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['showAdvert'] as int,
  );
}

Map<String, dynamic> _$NewsBeanToJson(NewsBean instance) => <String, dynamic>{
      'listId': instance.listId,
      'type': instance.type,
      'expiredTime': instance.expiredTime,
      'currentPage': instance.currentPage,
      'totalPage': instance.totalPage,
      'topsize': instance.topsize,
      'item': instance.item,
      'showAdvert': instance.showAdvert,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['type'] as String,
    json['id'] as String,
    json['title'] as String,
    json['style'] == null
        ? null
        : Style.fromJson(json['style'] as Map<String, dynamic>),
    json['thumbnail'] as String,
    json['documentId'] as String,
    json['staticId'] as String,
    json['link'] == null
        ? null
        : Link.fromJson(json['link'] as Map<String, dynamic>),
    json['reftype'] as String,
    json['intro'] as String,
    json['commentsall'] as String,
  )
    ..commentsUrl = json['commentsUrl'] as String
    ..weburl = json['weburl'] as String;
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'title': instance.title,
      'style': instance.style,
      'thumbnail': instance.thumbnail,
      'documentId': instance.documentId,
      'staticId': instance.staticId,
      'link': instance.link,
      'commentsUrl': instance.commentsUrl,
      'weburl': instance.weburl,
      'reftype': instance.reftype,
      'intro': instance.intro,
      'commentsall': instance.commentsall,
    };

Style _$StyleFromJson(Map<String, dynamic> json) {
  return Style(
    json['view'] as String,
    (json['backreason'] as List)?.map((e) => e as String)?.toList(),
    json['defaultreason'] as String,
    json['recomReason'] == null
        ? null
        : RecomReason.fromJson(json['recomReason'] as Map<String, dynamic>),
    (json['images'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$StyleToJson(Style instance) => <String, dynamic>{
      'view': instance.view,
      'backreason': instance.backreason,
      'defaultreason': instance.defaultreason,
      'images': instance.images,
      'recomReason': instance.recomReason,
    };

RecomReason _$RecomReasonFromJson(Map<String, dynamic> json) {
  return RecomReason(
    json['reasonStyle'] as String,
    json['reasonName'] as String,
  );
}

Map<String, dynamic> _$RecomReasonToJson(RecomReason instance) =>
    <String, dynamic>{
      'reasonStyle': instance.reasonStyle,
      'reasonName': instance.reasonName,
    };

Link _$LinkFromJson(Map<String, dynamic> json) {
  return Link(
    json['type'] as String,
    json['url'] as String,
    json['weburl'] as String,
  );
}

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
      'weburl': instance.weburl,
    };
