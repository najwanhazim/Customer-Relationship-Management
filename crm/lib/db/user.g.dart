// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      login_id: json['login_id'] as String,
      email: json['email'] as String,
      full_name: json['full_name'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login_id': instance.login_id,
      'email': instance.email,
      'full_name': instance.full_name,
    };
