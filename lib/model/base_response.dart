import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, genericArgumentFactories: true)
class BaseResponse<T> {

  final String status;
  final String message;
  final T data;

  BaseResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT
      ) => _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(Object? json) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}