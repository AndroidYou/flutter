import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';


@JsonSerializable()
class News extends Object {

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'error_code')
  int errorCode;

  News(this.reason,this.result,this.errorCode,);

  factory News.fromJson(Map<String, dynamic> srcJson) => _$NewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

}


@JsonSerializable()
class Result extends Object {

  @JsonKey(name: 'stat')
  String stat;

  @JsonKey(name: 'data')
  List<Data> data;

  Result(this.stat,this.data,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'uniquekey')
  String uniquekey;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'author_name')
  String authorName;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'thumbnail_pic_s')
  String thumbnailPicS;

  Data(this.uniquekey,this.title,this.date,this.category,this.authorName,this.url,this.thumbnailPicS,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


