// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionResponse _$PredictionResponseFromJson(Map<String, dynamic> json) =>
    PredictionResponse(
      food: json['food'] as String,
      calories: json['calories'] as int,
      accuracy: (json['accuracy'] as num).toDouble(),
    );

Map<String, dynamic> _$PredictionResponseToJson(PredictionResponse instance) =>
    <String, dynamic>{
      'food': instance.food,
      'calories': instance.calories,
      'accuracy': instance.accuracy,
    };
