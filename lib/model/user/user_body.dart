
import 'package:json_annotation/json_annotation.dart';

part 'user_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserBody {

  final String username;
  final String password;
  final String address;
  final String avatar;
  final int coofitWallet;
  final String email;
  final String phoneNumber;
  final int xp;

  UserBody({
    required this.username,
    required this.password,
    required this.address,
    required this.avatar,
    required this.coofitWallet,
    required this.email,
    required this.phoneNumber,
    required this.xp,
  });

  factory UserBody.fromJson(Map<String, dynamic> json) => _$UserBodyFromJson(json);
  Map<String, dynamic> toJson() => _$UserBodyToJson(this);
}