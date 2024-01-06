import 'package:get/get.dart';

import 'exercises_controller.dart';

class ExercisesCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExercisesCoachController());
  }
}
