
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/foundation.dart';

import '../../../app/constants.dart';
import '../../../app/storage/app_prefs.dart';
import 'api_routes/api_routes.dart';


const String APPLICATION_JSON = "application/json";
// const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String ACCEPT_LANGUAGE = "Accept-Language";
const String LANGUAGE = "lang";
const String AUTHORIZATION = "authorization";


class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Dio dio = Dio();

  Future<Dio> getDio() async {
    String language =  _appPreferences.getAppLanguage();
    // String? token;
    //  await _appPreferences.getToken().then((value) => token = value ?? null);
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      ACCEPT_LANGUAGE: language,
      LANGUAGE: language
      // AUTHORIZATION: token!,
      // DEFAULT_LANGUAGE: language
    };

    dio.options = BaseOptions(
        baseUrl: AppUrls.baseUrl,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut);

    if (!kReleaseMode) {
      // its debug mode so print app logs
      // dio.interceptors.add(LogInterceptor(
      //   responseBody: true,
      //   requestBody: true,
      //   responseHeader: true,
      //   requestHeader: true,
      //   request: true,
      // ));
      dio.interceptors.add(dioLoggerInterceptor);
    }

    return dio;
  }

  refreshHeader() async {
    String language =  _appPreferences.getAppLanguage();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      ACCEPT_LANGUAGE: language,
      LANGUAGE: language,
    };

    dio.options = BaseOptions(
        baseUrl: AppUrls.baseUrl,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut);
    // print("language::DIOFACTORY: ${language}");
    if (!kReleaseMode) {
      dio.interceptors.add(dioLoggerInterceptor);
    }
  }
}
