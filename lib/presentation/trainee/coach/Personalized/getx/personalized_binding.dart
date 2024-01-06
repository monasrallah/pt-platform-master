import 'package:get/get.dart';

import 'personalized_controller.dart';

class PersonalizedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalizedController());
  }
}
