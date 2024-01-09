import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/routes_manager.dart';

import '../../../../domain/core/entities/failure.dart';
import '../../../../resources/local_messages_strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    //print("${error}");
    if (error is DioError) {
      // dio error so its an error from response of the API or from dio itself
      print(error.response?.data['message']);
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        print(error.response?.statusCode);
        if (error.response?.statusCode == 403) {
          Get.offNamed(
            Routes.shopRoute,
            arguments: "unAuth",
          );
        }
        return Failure(
            error.response?.statusCode ?? 0,
            error.response?.data['message'] ??
                error.response?.statusMessage ??
                "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        // redirectToLogin();
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static String SUCCESS =
      AppLocalMessagesStringsManager().success; // success with data
  static String NO_CONTENT = AppLocalMessagesStringsManager()
      .success; // success with no data (no content)
  static String BAD_REQUEST = AppLocalMessagesStringsManager()
      .badRequestError; // failure, API rejected request
  static String UNAUTORISED = AppLocalMessagesStringsManager()
      .unauthorizedError; // failure, user is not authorised
  static String FORBIDDEN = AppLocalMessagesStringsManager()
      .forbiddenError; //  failure, API rejected request
  static String INTERNAL_SERVER_ERROR = AppLocalMessagesStringsManager()
      .internalServerError; // failure, crash in server side
  static String NOT_FOUND = AppLocalMessagesStringsManager()
      .notFoundError; // failure, crash in server side

  // local status code
  static String CONNECT_TIMEOUT = AppLocalMessagesStringsManager().timeoutError;
  static String CANCEL = AppLocalMessagesStringsManager().defaultError;
  static String RECIEVE_TIMEOUT = AppLocalMessagesStringsManager().timeoutError;
  static String SEND_TIMEOUT = AppLocalMessagesStringsManager().timeoutError;
  static String CACHE_ERROR = AppLocalMessagesStringsManager().cacheError;
  static String NO_INTERNET_CONNECTION =
      AppLocalMessagesStringsManager().noInternetError;
  static String DEFAULT = AppLocalMessagesStringsManager().defaultError;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
