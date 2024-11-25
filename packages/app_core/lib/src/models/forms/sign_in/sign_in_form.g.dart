// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInForm _$SignInFormFromJson(Map<String, dynamic> json) => SignInForm(
      username: json['username'] as String,
      password: json['password'] as String,
      expiresInMins: (json['expiresInMins'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SignInFormToJson(SignInForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'expiresInMins': instance.expiresInMins,
    };
