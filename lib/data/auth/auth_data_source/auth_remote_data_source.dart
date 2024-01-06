import 'package:pt_platform/data/auth/models/coach_model.dart';
import 'package:pt_platform/data/auth/models/trainee_model.dart';

import '../../../domain/parameters/auth_parameter/login_params.dart';
import '../../../domain/parameters/auth_parameter/otp_params.dart';
import '../../../domain/parameters/auth_parameter/register_params.dart';
import '../../../domain/parameters/auth_parameter/reset_params.dart';
import '../../core/api_helper/app_api_helper.dart';
import '../../core/models/base_response/base_response.dart';
import '../../core/models/empty_model.dart';
import '../../core/utils/api_routes/api_routes.dart';
import '../models/auth_model.dart';
import '../models/token_verification_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<BaseResponse<CategoriesModel>> getAllCategories();

  Future<BaseResponse<AuthModel<TraineeModel>>> loginTrainee(
      LoginParams loginParams);

  Future<BaseResponse<AuthModel<CoachModel>>> loginCoach(
      LoginParams loginParams);

  Future<BaseResponse<TokenVerificationModel>> sendEmailForget(String email);

  Future<BaseResponse<TokenVerificationModel>> sendEmailRegister(String email);

  Future<BaseResponse<EmptyModel>> sendOtp(OtpParams otpParams);

  Future<BaseResponse<EmptyModel>> reSendOtp(String token);

  Future<BaseResponse<EmptyModel>> resetPassword(ResetParams resetParams);

  Future<BaseResponse<AuthModel<TraineeModel>>> registerTrainee(
      RegisterTraineeParams registerTraineeParams);

  Future<BaseResponse<AuthModel<EmptyModel>>> registerCoach(
      RegisterCoachParams registerCoachParams);

  Future<BaseResponse<EmptyModel>> logout(String devicePlayerId);
}

class AuthRemoteDataSourceImpl implements BaseAuthRemoteDataSource {
  final AppApiHelper _appApiHelper;

  AuthRemoteDataSourceImpl(this._appApiHelper);

  @override
  Future<BaseResponse<CategoriesModel>> getAllCategories() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getAllCategoriesUrl, CategoriesModel.fromJson);
  }

  @override
  Future<BaseResponse<AuthModel<TraineeModel>>> loginTrainee(
      LoginParams loginParams) async {
    return await _appApiHelper.performPostUserRequest(
        AppUrls.loginUrl, loginParams.toJson(), TraineeModel.fromJson);
  }

  @override
  Future<BaseResponse<AuthModel<CoachModel>>> loginCoach(
      LoginParams loginParams) async {
    return await _appApiHelper.performPostUserRequest(
        AppUrls.loginUrl, loginParams.toJson(), CoachModel.fromJson);
  }

  @override
  Future<BaseResponse<TokenVerificationModel>> sendEmailForget(
      String email) async {
    return await _appApiHelper.performPostRequest(AppUrls.sendEmailForgetUrl,
        {"email": email}, TokenVerificationModel.fromJson);
  }

  @override
  Future<BaseResponse<TokenVerificationModel>> sendEmailRegister(
      String email) async {
    return await _appApiHelper.performPostRequest(AppUrls.sendEmailRegisterUrl,
        {"email": email}, TokenVerificationModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> sendOtp(OtpParams otpParams) async {
    return await _appApiHelper.performPostRequest(
        AppUrls.checkCodeUrl, otpParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> reSendOtp(String token) async {
    return await _appApiHelper.performPostRequest(
        AppUrls.resetCodeUrl, {"token": token}, EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> resetPassword(
      ResetParams resetParams) async {
    return await _appApiHelper.performPostRequest(
        AppUrls.resetPasswordUrl, resetParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<AuthModel<TraineeModel>>> registerTrainee(
      RegisterTraineeParams registerParams) async {
    return await _appApiHelper.performPostUserRequest(
        AppUrls.registerTraineeUrl,
        registerParams.toJson(),
        TraineeModel.fromJson);
  }

  @override
  Future<BaseResponse<AuthModel<EmptyModel>>> registerCoach(
      RegisterCoachParams registerParams) async {
    return await _appApiHelper.performPostUserRequest(
        AppUrls.registerCoachUrl, registerParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> logout(String devicePlayerId) async {
    return await _appApiHelper.performPostRequest(AppUrls.logoutUrl,
        {"device_player_id": devicePlayerId}, EmptyModel.fromJson);
  }
}
