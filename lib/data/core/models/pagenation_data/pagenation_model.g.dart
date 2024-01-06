// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagenation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pagination<T>(
      total: json['pages'] as int,
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    )..paginationType =
        $enumDecodeNullable(_$PaginationTypesEnumMap, json['paginationType']);

Map<String, dynamic> _$PaginationToJson<T>(
  Pagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'pages': instance.total,
      'paginationType': _$PaginationTypesEnumMap[instance.paginationType],
    };

const _$PaginationTypesEnumMap = {
  PaginationTypes.notifications: 'notifications',
};
