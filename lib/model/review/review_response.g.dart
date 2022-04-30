// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) =>
    ReviewResponse(
      menuId: json['menu_id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$ReviewResponseToJson(ReviewResponse instance) =>
    <String, dynamic>{
      'menu_id': instance.menuId,
      'name': instance.name,
      'avatar': instance.avatar,
      'rating': instance.rating,
    };
