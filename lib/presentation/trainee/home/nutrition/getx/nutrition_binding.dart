import 'package:get/get.dart';

import 'nutrition_controller.dart';

class NutritionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NutritionController());
  }
}
