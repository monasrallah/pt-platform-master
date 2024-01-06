import 'package:get/get.dart';

import 'coach_home_controller.dart';

class CoachHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CoachHomeController());
  }
}
