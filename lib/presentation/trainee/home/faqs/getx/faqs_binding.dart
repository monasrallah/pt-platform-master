import 'package:get/get.dart';

import 'faqs_controller.dart';

class FAQsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FAQsController());
  }
}
