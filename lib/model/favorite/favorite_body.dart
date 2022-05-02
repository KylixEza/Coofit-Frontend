
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FavoriteBody extends Equatable {
  final String menuId;

  FavoriteBody({
    required this.menuId
  });

  factory FavoriteBody.fromJson(Map<String, dynamic> json) => _$FavoriteBodyFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteBodyToJson(this);

  @override
  List<Object?> get props => [menuId];
}