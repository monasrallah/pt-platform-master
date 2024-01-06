import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/core/entities/failure.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../data/auth/auth_repo/auth_repository.dart';
import '../../../../domain/parameters/auth_parameter/otp_params.dart';
import '../../../../resources/local_messages_strings_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/toasts_messages.dart';

class OtpController extends GetxController {
  final TextEditingController codeController = TextEditingController();
  Failure failure = Failure.Default();

  List<TextInputFormatter> inputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(4),
  ];
  RxString userType = "".obs;
  RxString email = "".obs;
  RxString token = "".obs;

  final RxInt _counter = 0.obs;
  final RxInt _duration = 60.obs;

  int get counter => _counter.value;

  set counter(int value) {
    _counter.value = value;
  }

  int get duration => _duration.value;

  set duration(int value) {
    _duration.value = value;
  }

  canResendCode() async {
    if (counter < 1) {
      await sendEmail();
      if (failure.message == null) {
        startTimer();
      }
    }
  }

  sendEmail() async {
    final BaseAuthRepository authRepository = instance();
    isLoading = true;
    if (isRegister.value != "register") {
      (await authRepository.sendEmailForget(email.value)).fold(
          (failure) => showFlutterToast(message: failure.message.orEmpty()),
          (data) => token.value = data);
    } else {
      (await authRepository.sendEmailRegister(email.value)).fold(
          (failure) => showFlutterToast(message: failure.message.orEmpty()),
          (data) => token.value = data);
    }

    isLoading = false;
  }

  void startTimer() {
    counter = duration;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 0) {
        counter--;
      } else {
        timer.cancel();
        // Send code here
      }
    });
  }

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  verification() async {
    final BaseAuthRepository authRepository = instance();
    if (codeController.text.isNotEmpty) {
      isLoading = true;
      (await authRepository.sendOtp(
              OtpParams(token: token.value, code: codeController.text)))
          .fold((failure) {
        this.failure = failure;
        return showFlutterToast(message: failure.message.orEmpty());
      }, (bool data) {
        if (isRegister.value == "register") {
          Get.offNamed(Routes.registerRoute,
              arguments: [userType.value, token.value]);
        } else {
          Get.offNamed(Routes.resetPasswordRoute,
              arguments: [userType.value, token.value]);
        }

        // return userType.value == "forget"
        //     ? Get.offNamed(Routes.resetPasswordRoute,
        //         arguments: [userType.value, token.value])
        //     : {
        //         Get.toNamed(Routes.registerRoute,
        //             arguments: [userType.value, token.value])
        //       };
      });
      isLoading = false;
    } else {
      showFlutterToast(
          message:
              AppLocalMessagesStringsManager().requiredFieldsMustNotBeEmpty);
    }
  }

  resendCode() async {
    final BaseAuthRepository authRepository = instance();

    if (codeController.text.isNotEmpty) {
      isLoading = true;
      (await authRepository.reSendOtp(token.value)).fold((Failure failure) {
        this.failure = failure;
        return showFlutterToast(message: failure.message.orEmpty());
      }, (bool data) {
        // if (isRegister.value == "register") {
        //   Get.offNamed(Routes.registerRoute,
        //       arguments: [userType.value, token.value]);
        // } else {
        //   Get.offNamed(Routes.resetPasswordRoute,
        //       arguments: [userType.value, token.value]);
        // }
      });
      isLoading = false;
    } else {
      showFlutterToast(
          message:
              AppLocalMessagesStringsManager().requiredFieldsMustNotBeEmpty);
    }
  }

  RxString isRegister = "".obs;

  @override
  onInit() async {
    super.onInit();
    startTimer();
    userType.value = Get.arguments[0];
    token.value = Get.arguments[1];
    email.value = Get.arguments[2];
    isRegister.value = Get.arguments[3];
  }
}
