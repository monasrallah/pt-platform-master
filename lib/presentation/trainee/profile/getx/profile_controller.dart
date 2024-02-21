import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/profile_entities/profile_entity.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../data/auth/auth_repo/auth_repository.dart';
import '../../../../data/profile/profile_repo/profile_repository.dart';
import '../../../../domain/parameters/profile/delete_account_params.dart';
import '../../../../domain/parameters/profile/edit_image_params.dart';
import '../../../../domain/parameters/profile/edit_name_params.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/dialogs/pick_image_source_dialog.dart';
import '../../../widgets/toasts_messages.dart';

class ProfileController extends GetxController {
  BaseProfileRepository baseProfileRepository = instance();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool readOnly = true.obs;

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  final RxBool _isLogoutLoading = false.obs;

  set isLogoutLoading(bool val) => _isLogoutLoading.value = val;

  bool get isLogoutLoading => _isLogoutLoading.value;

  final Rx<File> productImageFile = File("").obs;
  final RxBool isFileProductImage = false.obs;

  setSelectedProductImage(File file) {
    productImageFile.value = file;
    isFileProductImage.value = true;
    editImage();
    update();
  }

  openSelectProductImageDialog() {
    Future.delayed(Duration.zero, () async {

      print("Test ");
      Get.dialog(PickImageSourceDialog(
        onTap: setSelectedProductImage,
        isMultiSelect: false,
      ));
    });
  }

  Rx<ProfileEntity> profile = ProfileEntity.init().obs;

  getProfile() async {
    isLoading = true;
    (await baseProfileRepository.getProfile()).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (ProfileEntity data) => {
              profile.value = data,
              firstNameController.text = profile.value.firstName,
              lastNameController.text = profile.value.lastName
            });
    isLoading = false;
  }

  editName() async {
    isLoading = true;
    (await baseProfileRepository.editName(EditNameParams(
            firstName: firstNameController.text,
            lastName: lastNameController.text)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {});
    isLoading = false;
  }

  editImage() async {
    isLoading = true;
    (await baseProfileRepository
            .editProfileImage(EditImageParams(avatar: productImageFile.value)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {});
    isLoading = false;
  }

  logout() async {
    final BaseAuthRepository authRepository = instance();

    isLogoutLoading = true;
    (await authRepository.logout("player_id")).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (data) => Get.offAllNamed(Routes.aboutYouRoute));
    isLogoutLoading = false;
  }

  deleteAccount() async {
    isLoading = true;
    (await baseProfileRepository.deleteAccount(DeleteAccountParams(
            password: passwordController.text, devicePlayerId: "player_id")))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {Get.offNamed(Routes.aboutYouRoute)});
    isLoading = false;
    passwordController.clear();
  }

  @override
  void onInit() async {
    await getProfile();
    super.onInit();
  }
}
