import 'package:get/get.dart';

import 'recipes_controller.dart';

class RecipesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipesController());
  }
}
