
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReviewResponse extends Equatable {

  final String menuId;
  final String name;
  final String avatar;
  final double rating;

  ReviewResponse({
    required this.menuId,
    required this.name,
    required this.avatar,
    required this.rating
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => _$ReviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);

  @override
  List<Object?> get props => [menuId, name, avatar, rating];

}