import 'package:get/get.dart';

import 'kyc_controller.dart';

class KycBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KycController());
  }
}
