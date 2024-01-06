import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../app/functions.dart';
import '../../../../data/auth/auth_repo/auth_repository.dart';
import '../../../../domain/parameters/auth_parameter/reset_params.dart';
import '../../../../resources/local_messages_strings_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/toasts_messages.dart';

class ResetPasswordController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool _isLoading = false.obs;
  final RxBool isPasswordValid = true.obs;
  final RxBool isConfirmPasswordValid = true.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  bool isAllValid() {
    _passwordValid();
    _confirmPasswordValid();
    return isPasswordValid.value && isConfirmPasswordValid.value;
  }

  _passwordValid() {
    isPasswordValid.value =
        (password.text.length > 7 && checkPasswordValidity(password.text));
    return isPasswordValid.value;
  }

  bool _confirmPasswordValid() {
    isConfirmPasswordValid.value = confirmPassword.text == password.text;
    return isPasswordValid.value;
  }

  reset() async {
    final BaseAuthRepository authRepository = instance();

    if (isAllValid()) {
      print("ghina ${userType.value}");
      isLoading = true;
      (await authRepository.resetPassword(ResetParams(
              password: password.text,
              confirmPassword: confirmPassword.text,
              token: token.value)))
          .fold(
              (failure) => showFlutterToast(message: failure.message.orEmpty()),
              (data) => Get.offNamedUntil(
                  Routes.loginRoute,
                  arguments: userType.value,
                  ModalRoute.withName(Routes.aboutYouRoute)));
      isLoading = false;
    } else {
      showFlutterToast(
          message:
              AppLocalMessagesStringsManager().requiredFieldsMustNotBeEmpty);
    }
  }

  RxString userType = "".obs;
  RxString token = "".obs;

  @override
  onInit() async {
    super.onInit();
    userType.value = Get.arguments[0];
    token.value = Get.arguments[1];
    password.addListener(() {
      _passwordValid();
    });
  }
}
