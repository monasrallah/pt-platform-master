import 'package:get/get.dart';

import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/routes_manager.dart';

class NutritionController extends GetxController {
  List<String> gridImageList = [
    ImageCoachAssets.food,
    ImageCoachAssets.supplements,
    ImageCoachAssets.calorieCalculator,
    ImageCoachAssets.recipe,
  ];

  List<String> gridTileList = [
    "food".tr,
    "supplements".tr,
    "caloriesCalculator".tr,
    'recipesAndDietPlans'.tr,
  ];

  List<Function> gridOnTapList = [
    () {
      Get.toNamed(Routes.foodRoute);
    },
    () {
      Get.toNamed(Routes.supplementRoute);
    },
    () {
      Get.toNamed(Routes.calorieCalculatorRoute);
    },
    () {
      Get.toNamed(Routes.recipeRoute);
    },
  ];
}
