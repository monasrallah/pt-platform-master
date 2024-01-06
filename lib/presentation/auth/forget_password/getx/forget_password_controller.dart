import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../app/functions.dart';
import '../../../../data/auth/auth_repo/auth_repository.dart';
import '../../../../resources/local_messages_strings_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/toasts_messages.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController email = TextEditingController();
  final RxBool isEmailValid = true.obs;
  RxString userType = "".obs;

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  bool checkEmailValid() {
    isEmailValid.value =
        (email.text.length > 2 && checkEmailValidity(email.text));
    return isEmailValid.value;
  }

  sendEmailForget() async {
    final BaseAuthRepository authRepository = instance();

    if (checkEmailValid()) {
      isLoading = true;
      (await authRepository.sendEmailForget(email.text)).fold(
          (failure) => showFlutterToast(message: failure.message.orEmpty()),
          (data) =>
              Get.toNamed(Routes.otpRoute, arguments: [userType.value, data,email.text]));
      isLoading = false;
    } else {
      showFlutterToast(
          message:
              AppLocalMessagesStringsManager().requiredFieldsMustNotBeEmpty);
    }
  }

  @override
  void onInit() {
    userType.value = Get.arguments;
    super.onInit();
  }
}
