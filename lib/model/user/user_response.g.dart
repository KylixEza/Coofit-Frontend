// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      uid: json['uid'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      address: json['address'] as String,
      avatar: json['avatar'] as String,
      coofitWallet: json['coofit_wallet'] as int,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      xp: json['xp'] as int,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'password': instance.password,
      'address': instance.address,
      'avatar': instance.avatar,
      'coofit_wallet': instance.coofitWallet,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'xp': instance.xp,
    };
