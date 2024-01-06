import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/home_entities/faqs_entity.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/home/home_repo/home_repository.dart';
import '../../../../widgets/toasts_messages.dart';

class FAQsController extends GetxController {
  final ValueNotifier<Key> expanded = ValueNotifier(const Key("0"));
  BaseHomeRepository baseHomeRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<FaqsEntity> faqs = [];

  getFaqs() async {
    isLoading = true;
    (await baseHomeRepository.faqs()).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<FaqsEntity> data) => {faqs = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getFaqs();
    super.onInit();
  }
}
