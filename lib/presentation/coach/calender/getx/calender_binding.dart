import 'package:get/get.dart';

import 'calender_controller.dart';

class CalenderCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalenderCoachController());
  }
}
