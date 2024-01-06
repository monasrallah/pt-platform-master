import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import '../../../app/debug/log.dart';
import '../../../app/dependency_injection.dart';
import '../../../app/enum.dart';
import '../../../app/storage/app_prefs.dart';
import '../../auth/models/auth_model.dart';
import '../models/base_response/base_response.dart';
import '../models/pagenation_data/pagenation_model.dart';
import '../utils/dio_factory.dart';
import 'app_api_helper.dart';

class AppApiHelperImpl implements AppApiHelper {
  Dio get dio => _dio;

  final Dio _dio;
  String? userToken;

  AppApiHelperImpl(this._dio);

  getToken() async {
    refreshHeader();
    userToken = instance<AppPreferences>().getAccessToken();

    ///we add this for login route because there is no token yet
    if (userToken!.isNotEmpty) {
      _dio.options.headers.addAll({"Authorization": "Bearer ${userToken!}"});
    }
  }

  refreshHeader() async {
    await instance<DioFactory>().refreshHeader();
  }

  bool addStatusCodeToModel<T>(
      {required BaseResponse<T> model, required Response<T> response}) {
    return response.statusCode == 200 || response.statusCode == 201
        ? true
        : false;
  }

  @override
  Future<BaseResponse<T>> performGetRequest<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson,
      {Map<String, dynamic>? queryParameters}) async {
    await getToken();
    final response = await dio.get(endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: _dio.options.headers,
        ));
    final baseResponse = BaseResponse<T>.fromJson(
        response.data!, (json) => fromJson(json as Map<String, dynamic>));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);

    return baseResponse;
  }

  @override
  Future<BaseResponse<T>> performGetListRequest<T>(
      {required String endpoint,
      required T Function(List<dynamic>) fromJson,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    await getToken();
    final response = await dio.get(endpoint,
        queryParameters: queryParameters,
        // data: data,
        options: Options(
          headers: _dio.options.headers,
        ));
    final baseResponse = BaseResponse<T>.fromJson(
        response.data!, (json) => fromJson(json as List<dynamic>));

    return baseResponse;
  }

  @override
  Future<BaseResponse<Pagination<T>>> performGetPagination<T>(
      String endPoint, T Function(Map<String, dynamic>) fromJson,
      {String? listName, Map<String, dynamic>? params}) async {
    await getToken();
    final response = await _dio.get(endPoint,
        queryParameters: params,
        options: Options(
          headers: _dio.options.headers,
        ));

    final baseResponse = BaseResponse<Pagination<T>>.fromJson(
        response.data!,
        (json) => Pagination.fromJson(response.data!['data'],
            (json) => fromJson(json as Map<String, dynamic>)));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);
    // ///to know which toDomain will be used in mapper
    baseResponse.data?.paginationType = PaginationTypes.notifications;
    return baseResponse;
  }

  @override
  Future<BaseResponse<T>> performPostRequest<T>(String endpoint,
      Map<String, dynamic>? data, T Function(Map<String, dynamic>) fromJson,
      {Map<String, dynamic>? queryParameters}) async {
    await getToken();
    final response = await dio.post(endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: _dio.options.headers,
        ));
    final baseResponse = BaseResponse<T>.fromJson(
        response.data!, (json) => fromJson(json as Map<String, dynamic>));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);
    return baseResponse;
  }

  @override
  Future<BaseResponse<AuthModel<T>>> performPostUserRequest<T>(
      String endpoint,
      Map<String, dynamic> data,
      T Function(Map<String, dynamic> p1) fromJson) async {
    await getToken();
    final response = await _dio.post(endpoint,
        data: data,
        options: Options(
          headers: _dio.options.headers,
        ));
    final baseResponse = BaseResponse<AuthModel<T>>.fromJson(
        response.data!,
        (json) => AuthModel.fromJson(response.data!['data'],
            (json) => fromJson(json as Map<String, dynamic>)));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);
    return baseResponse;
  }

  @override
  Future<BaseResponse<T>> performPutRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic> data,
  ) async {
    await getToken();
    // data.removeWhere((key, value) => value == null);
    final response = await dio.put(endpoint,
        data: data,
        options: Options(
          headers: _dio.options.headers,
        ));
    final baseResponse = BaseResponse<T>.fromJson(
        response.data!, (json) => fromJson(json as Map<String, dynamic>));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);
    // final baseResponse = fromJson(json.decode(response.data));
    // log('PutRequest $baseResponse');

    return baseResponse;
  }

  @override
  Future<BaseResponse<T>> performPatchRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    d.FormData? data,
  ) async {
    log('data in form data is ${data!.fields}');
    await getToken();
    final response = await dio.patch(endpoint,
        data: data,
        options: Options(
          headers: _dio.options.headers,
        ));
    // log('PatchRequest  $response');
    final baseResponse = BaseResponse<T>.fromJson(
        response.data!, (json) => fromJson(json as Map<String, dynamic>));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);
    // if (T.toString() == 'String') {
    //   return 'Success' as T;
    // }
    // final baseResponse = fromJson(json.decode(response.data));
    return baseResponse;
  }

  @override
  Future<BaseResponse<T>> performPatchRequestJSON<T>(String endpoint,
      T Function(Map<String, dynamic>) fromJson, Map<String, dynamic>? data,
      {Map<String, dynamic>? queryParameters}) async {
    await getToken();
    final response = await dio.patch(endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: _dio.options.headers,
        ));
    final baseResponse = BaseResponse<T>.fromJson(
        response.data!, (json) => fromJson(json as Map<String, dynamic>));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);
    // final baseResponse = fromJson(json.decode(response.data));
    return baseResponse;
  }

  @override
  Future<BaseResponse<T>> performPostRequestWithFormData<T>(
    String endpoint,
    d.FormData data,
    T Function(Map<String, dynamic> p1) fromJson,
  ) async {
    await getToken();
    final response = await dio.post(endpoint,
        data: data,
        options: Options(
          headers: _dio.options.headers,
        ));
    final baseResponse = BaseResponse<T>.fromJson(
        response.data!, (json) => fromJson(json as Map<String, dynamic>));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);
    // final baseResponse = fromJson(json.decode(response.data)["data"]);
    log("PostRequestWithFormData $baseResponse");

    return baseResponse;
  }

  @override
  Future<BaseResponse<T>> performDeleteRequest<T>(String endpoint,
      {required T Function(Map<String, dynamic>) fromJson,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    await getToken();

    final response = await dio.delete(endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: _dio.options.headers,
        ));
    log("DeleteRequest ${response.statusCode}");

    final baseResponse = BaseResponse<T>.fromJson(
        response.data!, (json) => fromJson(json as Map<String, dynamic>));
    baseResponse.status =
        addStatusCodeToModel(model: baseResponse, response: response);
    return baseResponse;
  }
}
