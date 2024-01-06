import 'package:get/get.dart';

import 'main_bottom_navigation_bar_controller.dart';

class MainBottomNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainBottomNavigationBarController());
  }
}
