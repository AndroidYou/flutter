// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return Channel(
    (json['choseList'] as List)
        ?.map((e) =>
            e == null ? null : ChoseList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['unChoseList'] as List)
        ?.map((e) =>
            e == null ? null : ChoseList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
      'choseList': instance.choseList,
      'unChoseList': instance.unChoseList,
    };

ChoseList _$ChoseListFromJson(Map<String, dynamic> json) {
  return ChoseList(
    json['channelName'] as String,
    json['channelNo'] as String,
  );
}

Map<String, dynamic> _$ChoseListToJson(ChoseList instance) => <String, dynamic>{
      'channelName': instance.channelName,
      'channelNo': instance.channelNo,
    };
