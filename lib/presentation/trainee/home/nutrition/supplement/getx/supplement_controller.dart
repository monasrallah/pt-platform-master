import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../../../app/dependency_injection.dart';
import '../../../../../../data/home/home_repo/home_repository.dart';
import '../../../../../../domain/entities/home_entities/recipe_entity.dart';
import '../../../../../widgets/toasts_messages.dart';

class SupplementController extends GetxController {
  BaseHomeRepository baseHomeRepository = instance();
  TextEditingController nameController = TextEditingController();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<RecipeEntity> supplements = [];

  getSupplements() async {
    isLoading = true;
    (await baseHomeRepository.supplements(nameController.text)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<RecipeEntity> data) => {supplements = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getSupplements();
    super.onInit();
  }
}
