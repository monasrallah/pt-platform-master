import 'package:get/get.dart';

import 'workout_controller.dart';

class WorkoutCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkoutsCoachController());
  }
}
