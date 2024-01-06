import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/home/home_repo/home_repository.dart';
import '../../../../../domain/parameters/home_params/technical_support_params.dart';
import '../../../../widgets/toasts_messages.dart';

class ContactUsController extends GetxController {
  BaseHomeRepository baseHomeRepository = instance();
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  Color color = Colors.transparent;

  final RxBool isLoading = false.obs;

  // set isLoading(bool val) => _isLoading.value = val;
  //
  // bool get isLoading => _isLoading.value;

  technicalSupport() async {
    isLoading.value = true;
    (await baseHomeRepository.technicalSupport(TechnicalSupportParams(
            subject: titleController.text, message: desController.text)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {
                  Get.back(),
                  titleController.clear(),
                  desController.clear(),
                  showFlutterToast(message: "Send Success")
                });

    isLoading.value = false;
  }

  feedback() async {
    isLoading.value = true;
    (await baseHomeRepository.feedBack(TechnicalSupportParams(
            subject: titleController.text, message: desController.text)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {
                  Get.back(),
                  titleController.clear(),
                  desController.clear(),
                  showFlutterToast(message: "Send Success")
                });

    isLoading.value = false;
  }
}
