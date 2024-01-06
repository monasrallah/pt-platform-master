import 'package:get/get.dart';

import 'history_controller.dart';

class UserHistoryCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserHistoryCoachController());
  }
}
