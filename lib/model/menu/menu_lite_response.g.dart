// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_lite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuLiteResponse _$MenuLiteResponseFromJson(Map<String, dynamic> json) =>
    MenuLiteResponse(
      menuId: json['menu_id'] as String,
      difficulty: json['difficulty'] as String,
      calories: json['calories'] as int,
      cooTime: json['coo_time'] as int,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$MenuLiteResponseToJson(MenuLiteResponse instance) =>
    <String, dynamic>{
      'menu_id': instance.menuId,
      'difficulty': instance.difficulty,
      'calories': instance.calories,
      'coo_time': instance.cooTime,
      'image': instance.image,
      'rating': instance.rating,
      'title': instance.title,
    };
