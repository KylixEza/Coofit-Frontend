import 'package:json_annotation/json_annotation.dart';

part 'base_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, genericArgumentFactories: true)
class BaseListResponse<T> {

  final String status;
  final String message;
  final int count;
  final T data;

  BaseListResponse({
    required this.status,
    required this.message,
    required this.count,
    required this.data,
  });

  factory BaseListResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT
      ) => _$BaseListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(Object? json) toJsonT) =>
      _$BaseListResponseToJson(this, toJsonT);
}