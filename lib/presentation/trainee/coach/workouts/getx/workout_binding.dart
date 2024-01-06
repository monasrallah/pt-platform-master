import 'package:get/get.dart';

import 'workout_controller.dart';

class WorkoutsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkoutsController());
  }
}
