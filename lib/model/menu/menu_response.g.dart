// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuResponse _$MenuResponseFromJson(Map<String, dynamic> json) => MenuResponse(
      menuId: json['menu_id'] as String,
      description: json['description'] as String,
      difficulty: json['difficulty'] as String,
      calories: json['calories'] as int,
      cookTime: json['cook_time'] as int,
      image: json['image'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rating: (json['rating'] as num).toDouble(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$MenuResponseToJson(MenuResponse instance) =>
    <String, dynamic>{
      'menu_id': instance.menuId,
      'description': instance.description,
      'difficulty': instance.difficulty,
      'calories': instance.calories,
      'cook_time': instance.cookTime,
      'image': instance.image,
      'ingredients': instance.ingredients,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'steps': instance.steps,
      'title': instance.title,
    };
