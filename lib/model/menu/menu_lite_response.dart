import 'package:json_annotation/json_annotation.dart';

part 'menu_lite_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MenuLiteResponse {

  final String menuId;
  final String difficulty;
  final int calories;
  final int cooTime;
  final String image;
  final double rating;
  final String title;

  MenuLiteResponse({
    required this.menuId,
    required this.difficulty,
    required this.calories,
    required this.cooTime,
    required this.image,
    required this.rating,
    required this.title
  });

  factory MenuLiteResponse.fromJson(Map<String, dynamic> json) =>
    _$MenuLiteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MenuLiteResponseToJson(this);
}