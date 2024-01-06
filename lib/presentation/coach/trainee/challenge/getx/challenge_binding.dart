import 'package:get/get.dart';

import 'challenge_controller.dart';

class ChallengeCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeCoachController());
  }
}
