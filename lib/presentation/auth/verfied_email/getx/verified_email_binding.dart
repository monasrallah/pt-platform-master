import 'package:get/get.dart';

import 'verified_email_controller.dart';

class VerifiedEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifiedEmailController());
  }
}
