import 'package:dio/dio.dart' as d;

import '../../auth/models/auth_model.dart';
import '../models/base_response/base_response.dart';
import '../models/pagenation_data/pagenation_model.dart';

abstract class AppApiHelper {
  Future<BaseResponse<T>> performPutRequest<T>(String endpoint,
      T Function(Map<String, dynamic>) fromJson, Map<String, dynamic> data);

  Future<BaseResponse<T>> performPatchRequest<T>(String endpoint,
      T Function(Map<String, dynamic>) fromJson, d.FormData? data);

  Future<BaseResponse<T>> performPatchRequestJSON<T>(String endpoint,
      T Function(Map<String, dynamic>) fromJson, Map<String, dynamic>? data,
      {Map<String, dynamic>? queryParameters});

  Future<BaseResponse<T>> performPostRequest<T>(String endpoint,
      Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson,
      {Map<String, dynamic>? queryParameters});

  Future<BaseResponse<AuthModel<T>>> performPostUserRequest<T>(String endpoint,
      Map<String, dynamic> data, T Function(Map<String, dynamic> p1) fromJson);

  Future<BaseResponse<T>> performDeleteRequest<T>(String endpoint,
      {required T Function(Map<String, dynamic>) fromJson,
      Map<String, dynamic> data,Map<String, dynamic>? queryParameters});

  Future<BaseResponse<T>> performPostRequestWithFormData<T>(String endpoint,
      d.FormData data, T Function(Map<String, dynamic>) fromJson);

  Future<BaseResponse<T>> performGetRequest<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson,
      {Map<String, dynamic>? queryParameters});

  Future<BaseResponse<T>> performGetListRequest<T>(
      {required String endpoint,
      required T Function(List<dynamic>) fromJson,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters});

  Future<BaseResponse<Pagination<T>>> performGetPagination<T>(
    String endPoint,
    T Function(Map<String, dynamic>) fromJson, {
    String? listName,
    Map<String, dynamic>? params,
  });
}
