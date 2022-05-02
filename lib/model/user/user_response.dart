
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserResponse extends Equatable {

  final String uid;
  final String username;
  final String password;
  final String address;
  final String avatar;
  final int coofitWallet;
  final String email;
  final String phoneNumber;
  final int xp;

  UserResponse({
    required this.uid,
    required this.username,
    required this.password,
    required this.address,
    required this.avatar,
    required this.coofitWallet,
    required this.email,
    required this.phoneNumber,
    required this.xp,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @override
  List<Object?> get props => [uid, username, password, address, avatar, coofitWallet,
    email, phoneNumber, xp];
}
