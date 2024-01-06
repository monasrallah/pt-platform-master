import 'package:get/get.dart';

import 'food_controller.dart';

class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodController());
  }
}
