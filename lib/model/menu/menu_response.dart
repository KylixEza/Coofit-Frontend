
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../review/review_response.dart';

part 'menu_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MenuResponse extends Equatable{
  final String menuId;
  final String description;
  final String difficulty;
  final int calories;
  final int cookTime;
  final String image;
  final List<String> ingredients;
  final double rating;
  final List<ReviewResponse> reviews;
  final List<String> steps;
  final String title;

  MenuResponse({
    required this.menuId,
    required this.description,
    required this.difficulty,
    required this.calories,
    required this.cookTime,
    required this.image,
    required this.ingredients,
    required this.rating,
    required this.reviews,
    required this.steps,
    required this.title,
  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) => _$MenuResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MenuResponseToJson(this);

  @override
  List<Object?> get props => [menuId, description, difficulty, calories, cookTime,
    image, ingredients, rating, reviews, steps, title];

}