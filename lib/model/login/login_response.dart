import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse extends Equatable {
  bool isExist;
  String uid;

  LoginResponse(
    this.isExist,
    [this.uid = '']
  );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  List<Object?> get props => [isExist, uid];


}