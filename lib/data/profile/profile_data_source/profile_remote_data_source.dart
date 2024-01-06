import 'package:pt_platform/data/auth/models/coach_model.dart';
import 'package:pt_platform/data/profile/models/profile_model.dart';

import '../../../domain/parameters/profile/change_password_params.dart';
import '../../../domain/parameters/profile/delete_account_params.dart';
import '../../../domain/parameters/profile/edit_image_params.dart';
import '../../../domain/parameters/profile/edit_name_params.dart';
import '../../core/api_helper/app_api_helper.dart';
import '../../core/models/base_response/base_response.dart';
import '../../core/models/empty_model.dart';
import '../../core/utils/api_routes/api_routes.dart';

abstract class BaseProfileRemoteDataSource {
  Future<BaseResponse<ProfileModel>> getProfile();

  Future<BaseResponse<EmptyModel>> turnNotification(bool notification);

  Future<BaseResponse<CoachesModel>> getAssignedCoaches();

  Future<BaseResponse<EmptyModel>> changePassword(
      ChangePasswordParams changePasswordParams);

  Future<BaseResponse<EmptyModel>> editProfileImage(
      EditImageParams editImageParams);

  Future<BaseResponse<EmptyModel>> editName(EditNameParams editNameParams);

  Future<BaseResponse<EmptyModel>> deleteAccount(
      DeleteAccountParams deleteAccountParams);
}

class ProfileRemoteDataSourceImpl implements BaseProfileRemoteDataSource {
  final AppApiHelper _appApiHelper;

  ProfileRemoteDataSourceImpl(this._appApiHelper);

  @override
  Future<BaseResponse<ProfileModel>> getProfile() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getProfileUrl, ProfileModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> turnNotification(bool notification) async {
    return await _appApiHelper.performPostRequest(AppUrls.turnNotificationUrl,
        {"notification": notification}, EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<CoachesModel>> getAssignedCoaches() async {
    return await _appApiHelper.performPostRequest(
        AppUrls.getAssignedCoachesUrl, {}, CoachesModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> changePassword(
      ChangePasswordParams changePasswordParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.changePasswordUrl,
        changePasswordParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> editProfileImage(
      EditImageParams editImageParams) async {
    final data = await editImageParams.toFormData();
    return await _appApiHelper.performPostRequestWithFormData(
        AppUrls.editProfileImageUrl, data, EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> editName(
      EditNameParams editNameParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.editProfileNameUrl,
        editNameParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> deleteAccount(
      DeleteAccountParams deleteAccountParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.deleteAccountUrl,
        deleteAccountParams.toJson(), EmptyModel.fromJson);
  }
}
