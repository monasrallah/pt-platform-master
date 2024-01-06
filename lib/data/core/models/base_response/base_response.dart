import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

//flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  late bool? status;

  @JsonKey(name: 'message', defaultValue: '')
  final String? message;

  @JsonKey(name: 'data')
  final T? data;

  @JsonKey(name: 'data')
  final List<T>? listData;

  BaseResponse({
    this.message,
    this.status,
    this.data,
    this.listData,
  });

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  // factory BaseResponse.fromListJson(
  //         Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
  //     BaseResponse(
  //       status: json["status"],
  //       message: json["message"],
  //       listData: List<T>.from(json["data"].map((x) => fromJsonT)),
  //     );
}
