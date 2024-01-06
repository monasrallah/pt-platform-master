import 'package:get/get.dart';

import 'coach_controller.dart';

class CoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CoachController());
  }
}
