import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/data/auth/auth_repo/auth_repository.dart';
import 'package:pt_platform/domain/entities/auth_entities/category_entity.dart';
import 'package:pt_platform/domain/entities/auth_entities/coach_entity.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/home/home_repo/home_repository.dart';
import '../../../../../domain/parameters/home_params/filter_coaches_params.dart';
import '../../../../widgets/dialogs/filter_category_coach/filter_category_coach_controller.dart';
import '../../../../widgets/toasts_messages.dart';

class TrainerController extends GetxController {
  AppController appController = Get.find<AppController>();
  BaseHomeRepository baseHomeRepository = instance();
  TextEditingController searchController = TextEditingController();

  // RxInt? selectedIndex;
  List<CategoryEntity> categories = <CategoryEntity>[].obs;
  RxList<String> categoriesString = <String>[].obs;
  RxList<int> categoriesId = <int>[].obs;
  List<CoachEntity> coaches = [];

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  getCoaches() async {
    isLoading = true;
    (await baseHomeRepository.getCoaches(FilterCoachesParams(
            name: searchController.text, categoriesId: categoriesId)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<CoachEntity> data) => {coaches = data});
    isLoading = false;
  }

  convertCategoryToString(List<CategoryEntity> data) {
    data.map((e) => categoriesString.add(e.name)).toList();
  }

  getCategories() async {
    BaseAuthRepository baseAuthRepository = instance();
    isLoading = true;
    (await baseAuthRepository.getAllCategories()).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<CategoryEntity> data) =>
            {categories = data, convertCategoryToString(data)});
    isLoading = false;
  }

  @override
  void onInit() async {
    Get.put(FilterCategoryCoachController());
    await getCategories();
    await getCoaches();
    super.onInit();
  }
}
