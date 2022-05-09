import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_lite_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MenuLiteResponse extends Equatable {

  final String menuId;
  final String difficulty;
  final int calories;
  final int cookTime;
  final String image;
  double? rating = 0;
  final String title;

  MenuLiteResponse({
    required this.menuId,
    required this.difficulty,
    required this.calories,
    required this.cookTime,
    required this.image,
    required this.rating,
    required this.title
  });

  factory MenuLiteResponse.fromJson(Map<String, dynamic> json) =>
    _$MenuLiteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MenuLiteResponseToJson(this);

  @override
  List<Object?> get props => [menuId, difficulty, calories, cookTime, image, rating, title];
}