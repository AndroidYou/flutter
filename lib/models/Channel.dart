import 'package:json_annotation/json_annotation.dart';
part 'Channel.g.dart';


@JsonSerializable()
class Channel extends Object {

  @JsonKey(name: 'choseList')
  List<ChoseList> choseList;

  @JsonKey(name: 'unChoseList')
  List<ChoseList> unChoseList;

  Channel(this.choseList,this.unChoseList,);

  factory Channel.fromJson(Map<String, dynamic> srcJson) => _$ChannelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);

}


@JsonSerializable()
class ChoseList extends Object {

  @JsonKey(name: 'channelName')
  String channelName;

  @JsonKey(name: 'channelNo')
  String channelNo;

  ChoseList(this.channelName,this.channelNo,);

  factory ChoseList.fromJson(Map<String, dynamic> srcJson) => _$ChoseListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChoseListToJson(this);

}




