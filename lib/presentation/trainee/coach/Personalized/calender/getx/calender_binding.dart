import 'package:get/get.dart';

import 'calender_controller.dart';

class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalenderController());
  }
}
