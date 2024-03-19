import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/auth_entities/auth_entity.dart';
import 'package:pt_platform/providers/notifications_provider.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../app/functions.dart';
import '../../../../data/auth/auth_repo/auth_repository.dart';
import '../../../../domain/parameters/auth_parameter/device_params.dart';
import '../../../../domain/parameters/auth_parameter/login_params.dart';
import '../../../../resources/local_messages_strings_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/toasts_messages.dart';

class LoginController extends GetxController {
  TextEditingController email =
      // TextEditingController();
      TextEditingController();
  // TextEditingController(text: "yuri.fit@hotmail.com");

  TextEditingController password =
      // TextEditingController();
      TextEditingController();
  // TextEditingController(text: "Yuri3112");

  RxString userType = "".obs;

  final RxBool isPasswordVisible = false.obs;
  final RxBool _isLoading = false.obs;
  final RxBool isPasswordValid = true.obs;
  final RxBool isEmailValid = true.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  bool isAllValid() {
    _checkEmailValid();
    _passwordValid();
    return isEmailValid.value && isPasswordValid.value;
  }

  bool _checkEmailValid() {
    isEmailValid.value =
        (email.text.length > 2 && checkEmailValidity(email.text));
    return isEmailValid.value;
  }

  _passwordValid() {
    isPasswordValid.value =
        (password.text.isNotEmpty && checkPasswordValidity(password.text));
    return isPasswordValid.value;
  }

  // String? fcmToken;
  //
  // getFcmToken() async {
  //   return await instance<AppPreferences>().getFcmToken();
  // }

  login() async {
    final BaseAuthRepository authRepository = instance();

    if (isAllValid()) {
      isLoading = true;
      print(userType.value);
      if (userType.value.contains("Trainee")) {
        (await authRepository.loginTrainee(LoginParams(
                email: email.text,
                password: password.text,
                device: DeviceParams(
                    playerId:
                        Get.find<NotificationsProvider>().userNotificationToken,
                    platform: platform(),
                    timezone: Get.find<AppController>().timeZone,
                    appVersion: Get.find<AppController>().version))))
            .fold(
                (failure) =>
                    showFlutterToast(message: failure.message.orEmpty()),
                (AuthTraineeEntity data) {
          Get.find<AppController>().onItemTapped(0);
        });
      } else {
        (await authRepository.loginCoach(LoginParams(
                email: email.text,
                password: password.text,
                device: DeviceParams(
                    playerId:
                        Get.find<NotificationsProvider>().userNotificationToken,
                    platform: platform(),
                    timezone: Get.find<AppController>().timeZone,
                    appVersion: Get.find<AppController>().version))))
            .fold(
                (failure) =>
                    showFlutterToast(message: failure.message.orEmpty()),
                (AuthCoachEntity data) {
          Get.offAllNamed(Routes.coachHomeRoute);
        });
      }

      isLoading = false;
    } else {
      showFlutterToast(
          message:
              AppLocalMessagesStringsManager().requiredFieldsMustNotBeEmpty);
    }
  }

  @override
  onInit() async {
    super.onInit();
    userType.value = Get.arguments;
    email.addListener(() {
      _checkEmailValid();
    });
    password.addListener(() {
      _passwordValid();
    });
  }
}
