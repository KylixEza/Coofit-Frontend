import 'package:json_annotation/json_annotation.dart';

part 'base_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BaseListResponse {

  final String status;
  final String message;
  final int count;
  final dynamic data;

  BaseListResponse({
    required this.status,
    required this.message,
    required this.count,
    required this.data,
  });

  factory BaseListResponse.fromJson(Map<String, dynamic> json) => _$BaseListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseListResponseToJson(this);
}