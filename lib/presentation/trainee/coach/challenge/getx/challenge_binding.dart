import 'package:get/get.dart';

import 'challenge_controller.dart';

class ChallengeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeController());
  }
}
