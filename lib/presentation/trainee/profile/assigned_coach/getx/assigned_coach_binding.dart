import 'package:get/get.dart';

import 'assigned_coach_controller.dart';

class AssignedCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssignedCoachController());
  }
}
