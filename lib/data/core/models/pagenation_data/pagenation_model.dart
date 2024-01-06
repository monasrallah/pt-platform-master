import 'package:json_annotation/json_annotation.dart';

import '../../../../app/enum.dart';

part 'pagenation_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Pagination<T> {
  final List<T> data;
  @JsonKey(name: 'pages')
  int total;
  PaginationTypes? paginationType;

  Pagination({
    required this.total,
    required this.data,

    // required this.limit
  });

  factory Pagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationFromJson(json, fromJsonT);
}
