import 'package:get/get.dart';

import 'supplement_controller.dart';

class SupplementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupplementController());
  }
}
