import 'package:get/get.dart';

import 'today_work_out_controller.dart';

class TodayWorkOutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodayWorkOutController());
  }
}
