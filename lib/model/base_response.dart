import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BaseResponse {

  final String status;
  final String message;
  final dynamic data;

  BaseResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}