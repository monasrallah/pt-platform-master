import 'package:get/get.dart';

import 'calorie_calculator_controller.dart';

class CalorieCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalorieCalculatorController());
  }
}
