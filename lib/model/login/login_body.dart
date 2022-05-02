import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginBody extends Equatable {

  final String username;
  final String password;

  LoginBody({
    required this.username,
    required this.password,
  });

  factory LoginBody.fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);
  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  @override
  List<Object?> get props => [username, password];
}