import 'package:get/get.dart';

import 'personal_training_controller.dart';

class PersonalTrainingCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalTrainingCoachController());
  }
}
