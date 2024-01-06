import 'package:get/get.dart';

import 'progress_controller.dart';

class ProgressCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProgressCoachController());
  }
}
