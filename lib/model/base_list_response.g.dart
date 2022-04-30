// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseListResponse _$BaseListResponseFromJson(Map<String, dynamic> json) =>
    BaseListResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      count: json['count'] as int,
      data: json['data'],
    );

Map<String, dynamic> _$BaseListResponseToJson(BaseListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'count': instance.count,
      'data': instance.data,
    };
