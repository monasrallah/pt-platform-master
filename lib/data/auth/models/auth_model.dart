import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AuthModel<T> {
  @JsonKey(name: "user")
  final T? user;
  @JsonKey(name: "token")
  String token;

  AuthModel({required this.user, required this.token});

  factory AuthModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$AuthModelFromJson(json, fromJsonT);
}
