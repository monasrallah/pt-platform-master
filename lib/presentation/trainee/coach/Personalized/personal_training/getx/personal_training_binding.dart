import 'package:get/get.dart';

import 'personal_training_controller.dart';

class PersonalTrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalTrainingController());
  }
}
