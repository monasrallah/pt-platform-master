// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel<T> _$AuthModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    AuthModel<T>(
      user: _$nullableGenericFromJson(json['user'], fromJsonT),
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthModelToJson<T>(
  AuthModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'user': _$nullableGenericToJson(instance.user, toJsonT),
      'token': instance.token,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
