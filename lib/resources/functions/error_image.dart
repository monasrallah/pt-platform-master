import '../../data/core/utils/error_handler/error_handler.dart';
import '../assets_manager.dart';

String getErrorImage(int code) {
  switch (code) {
    case ResponseCode.NO_CONTENT:
      return ImageAssets.errorInternalServer;
    case ResponseCode.INTERNAL_SERVER_ERROR:
      return ImageAssets.errorInternalServer;
    case ResponseCode.FORBIDDEN:
      return ImageAssets.errorInternalServer;
    case ResponseCode.NOT_FOUND:
      return ImageAssets.errorNotFound;
    case ResponseCode.BAD_REQUEST:
      return ImageAssets.errorInternalServer;
    case ResponseCode.UNAUTORISED:
      return ImageAssets.errorInternalServer;
    case ResponseCode.NO_INTERNET_CONNECTION:
      return ImageAssets.errorInternalServer;
    case ResponseCode.CONNECT_TIMEOUT:
      return ImageAssets.errorInternalServer;
    default:
      return ImageAssets.errorInternalServer;
  }
}
