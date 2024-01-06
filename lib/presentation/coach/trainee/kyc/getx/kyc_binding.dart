import 'package:get/get.dart';

import 'kyc_controller.dart';

class KycCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KycCoachController());
  }
}
