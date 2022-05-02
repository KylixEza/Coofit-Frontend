import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prediction_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PredictionResponse extends Equatable {

  final String food;
  final int calories;
  final double accuracy;

  PredictionResponse({
    required this.food,
    required this.calories,
    required this.accuracy,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) => _$PredictionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PredictionResponseToJson(this);

  @override
  List<Object?> get props => [food, calories, accuracy];

}