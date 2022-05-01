
import 'package:json_annotation/json_annotation.dart';

part 'favorite_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FavoriteBody {
  final String menuId;

  FavoriteBody({
    required this.menuId
  });

  factory FavoriteBody.fromJson(Map<String, dynamic> json) => _$FavoriteBodyFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteBodyToJson(this);
}