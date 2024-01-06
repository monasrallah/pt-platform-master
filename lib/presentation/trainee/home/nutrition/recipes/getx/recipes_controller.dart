import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/home_entities/recipe_entity.dart';

import '../../../../../../app/dependency_injection.dart';
import '../../../../../../data/home/home_repo/home_repository.dart';
import '../../../../../widgets/toasts_messages.dart';

class RecipesController extends GetxController {
  BaseHomeRepository baseHomeRepository = instance();
  TextEditingController nameController = TextEditingController();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<RecipeEntity> recipes = [];

  getRecipes() async {
    isLoading = true;
    (await baseHomeRepository.recipes(nameController.text)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<RecipeEntity> data) => {recipes = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getRecipes();
    super.onInit();
  }
}
